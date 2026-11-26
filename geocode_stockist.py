
import json
import os
import time
import urllib.parse
import urllib.request
import urllib.error
from pathlib import Path


# --------------------------------------------------
# CONFIGURATION
# --------------------------------------------------

INPUT_FILE = Path("asset/data/stockist-locations.json")

OUTPUT_FILE = Path("asset/data/stockist-locations-geocoded.json")

# Keep True for the first test.
# Change to False only after verifying the dry-run counts.
DRY_RUN = False


# --------------------------------------------------
# BUILD FULL ADDRESS
# --------------------------------------------------

def build_address(salon):
    address_parts = [
        salon.get("address_line_1"),
        salon.get("address_line_2"),
        salon.get("city"),
        salon.get("state_province"),
        salon.get("postal_code"),
        salon.get("country"),
    ]

    return ", ".join(
        str(part).strip()
        for part in address_parts
        if part and str(part).strip()
    )


# --------------------------------------------------
# CHECK ADDRESS COMPLETENESS
# --------------------------------------------------

def is_complete(salon):
    has_street = bool(
        salon.get("address_line_1")
        and str(salon["address_line_1"]).strip()
    )

    has_city_or_postal = bool(
        salon.get("city")
        or salon.get("postal_code")
    )

    has_country = bool(
        salon.get("country")
        and str(salon["country"]).strip()
    )

    return has_street and has_city_or_postal and has_country


# --------------------------------------------------
# GOOGLE GEOCODING API
# --------------------------------------------------

def geocode_address(address, api_key):

    url = "https://maps.googleapis.com/maps/api/geocode/json"

    params = urllib.parse.urlencode({
        "address": address,
        "key": api_key
    })

    request_url = f"{url}?{params}"

    try:
        with urllib.request.urlopen(request_url, timeout=30) as response:
            result = json.loads(response.read().decode("utf-8"))

        status = result.get("status")

        if status == "OK":
            location = result["results"][0]["geometry"]["location"]

            return {
                "latitude": location["lat"],
                "longitude": location["lng"],
                "formatted_address": result["results"][0].get(
                    "formatted_address"
                ),
                "geocoding_status": "OK"
            }

        print(f"Geocoding status: {status} | {address}")

        return {
            "latitude": None,
            "longitude": None,
            "formatted_address": None,
            "geocoding_status": status
        }

    except urllib.error.HTTPError as error:
        print(f"HTTP ERROR: {error.code} | {address}")

        return {
            "latitude": None,
            "longitude": None,
            "formatted_address": None,
            "geocoding_status": f"HTTP_ERROR_{error.code}"
        }

    except Exception as error:
        print(f"ERROR: {error} | {address}")

        return {
            "latitude": None,
            "longitude": None,
            "formatted_address": None,
            "geocoding_status": "ERROR"
        }


# --------------------------------------------------
# MAIN
# --------------------------------------------------

def main():

    if not INPUT_FILE.exists():
        print("ERROR: Input JSON file not found!")
        print(f"Expected: {INPUT_FILE}")
        return

    with open(INPUT_FILE, "r", encoding="utf-8") as file:
        data = json.load(file)

    locations = data.get("locations", [])

    complete_salons = [
        salon for salon in locations
        if is_complete(salon)
    ]

    incomplete_salons = [
        salon for salon in locations
        if not is_complete(salon)
    ]

    print("\n--------------------------------")
    print("STOCKIST SALON ADDRESS REPORT")
    print("--------------------------------")

    print(f"Total salons: {len(locations)}")
    print(f"Complete addresses: {len(complete_salons)}")
    print(f"Incomplete addresses: {len(incomplete_salons)}")

    print("--------------------------------\n")

    # First run: only check counts.
    if DRY_RUN:
        print("DRY RUN: No API requests were made.")
        print("Check the counts above before enabling geocoding.")
        return

    # Read API key from environment.
    api_key = os.environ.get("GOOGLE_GEOCODING_API_KEY")

    if not api_key:
        print("ERROR: GOOGLE_GEOCODING_API_KEY is not set.")
        return

    print("Starting Google Geocoding...\n")

    updated_locations = []

    success_count = 0
    failed_count = 0

    for index, salon in enumerate(locations, start=1):

        salon = dict(salon)

        if is_complete(salon):

            address = build_address(salon)

            print(
                f"[{index}/{len(locations)}] "
                f"Geocoding: {salon.get('name', 'Unknown')}"
            )

            result = geocode_address(address, api_key)

            salon.update(result)

            if result["geocoding_status"] == "OK":
                success_count += 1
            else:
                failed_count += 1

            # Small delay between requests.
            time.sleep(0.1)

        else:
            salon.update({
                "latitude": None,
                "longitude": None,
                "formatted_address": None,
                "geocoding_status": "INCOMPLETE_ADDRESS"
            })

        updated_locations.append(salon)

    # Preserve all original records and add geocoding results.
    data["locations"] = updated_locations

    data["geocoding_summary"] = {
        "total_locations": len(locations),
        "complete_addresses": len(complete_salons),
        "incomplete_addresses": len(incomplete_salons),
        "successfully_geocoded": success_count,
        "failed_geocoding": failed_count
    }

    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=2, ensure_ascii=False)

    print("\n--------------------------------")
    print("GEOCODING COMPLETED")
    print("--------------------------------")

    print(f"Total salons: {len(locations)}")
    print(f"Successfully geocoded: {success_count}")
    print(f"Failed geocoding: {failed_count}")
    print(f"Output file: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
