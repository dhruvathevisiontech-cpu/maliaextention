
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../model/countrymodel.dart';

class Saveaddresscontroller extends GetxController {
  final GetStorage storage = GetStorage();

  // Temporary customer ID for local testing.
  static const String customerId = '9310057726208';

  String get addressStorageKey => 'addresses_$customerId';

  RxString selectedCountry = "United States".obs;

  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();

  final RxBool isSaving = false.obs;

  final RxList<Map<String, dynamic>> availableCountries =
      <Map<String, dynamic>>[].obs;

  final RxString countryError = ''.obs;

  final List<CountryModel> countries = [
    CountryModel(name: "United States", code: "US", dialCode: "+1"),
    CountryModel(name: "Canada", code: "CA", dialCode: "+1"),
    CountryModel(name: "India", code: "IN", dialCode: "+91"),
    CountryModel(name: "United Kingdom", code: "GB", dialCode: "+44"),
    CountryModel(name: "Australia", code: "AU", dialCode: "+61"),
  ];

  @override
  void onInit() {
    super.onInit();

    // Load countries locally. No Shopify API call.
    availableCountries.assignAll(
      countries.map((country) {
        return {
          'name': country.name,
          'isoCode': country.code,
        };
      }).toList(),
    );
  }

  // Local address suggestions.
  final List<Map<String, String>> dummyAddresses = [
    {
      "address": "1254 Sunset Boulevard",
      "location": "Los Angeles, CA, USA",
      "city": "Los Angeles",
      "country": "United States",
    },
    {
      "address": "1254 Sunset Boulevard",
      "location": "West Hollywood, CA, USA",
      "city": "West Hollywood",
      "country": "United States",
    },
    {
      "address": "455 Market Street",
      "location": "San Francisco, CA, USA",
      "city": "San Francisco",
      "country": "United States",
    },
    {
      "address": "1600 Amphitheatre Parkway",
      "location": "Mountain View, CA, USA",
      "city": "Mountain View",
      "country": "United States",
    },
    {
      "address": "350 Fifth Avenue",
      "location": "New York, NY, USA",
      "city": "New York",
      "country": "United States",
    },
    {
      "address": "Connaught Place",
      "location": "New Delhi, India",
      "city": "New Delhi",
      "country": "India",
    },
  ];

  RxList<Map<String, String>> addressSuggestions =
      <Map<String, String>>[].obs;

  void searchAddress(String query) {
    if (query.trim().isEmpty) {
      addressSuggestions.clear();
      return;
    }

    final searchQuery = query.toLowerCase().trim();

    addressSuggestions.assignAll(
      dummyAddresses.where((address) {
        final fullAddress =
        "${address["address"]} ${address["location"]}".toLowerCase();

        return fullAddress.contains(searchQuery);
      }).toList(),
    );
  }

  void selectAddress(Map<String, String> address) {
    addressController.text = address["address"] ?? "";
    cityController.text = address["city"] ?? "";

    final country = address["country"];

    if (country != null && country.isNotEmpty) {
      selectedCountry.value = country;
    }

    addressSuggestions.clear();
  }

  String get selectedDialCode {
    final country = countries.firstWhere(
          (country) => country.name == selectedCountry.value,
      orElse: () => countries.first,
    );

    return country.dialCode;
  }

  void selectCountry(String country) {
    selectedCountry.value = country;
  }

  // SAVE ADDRESS LOCALLY

  Future<bool> saveAddress() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      debugPrint('Address form validation failed');
      return false;
    }

    try {
      isSaving.value = true;

      final List<dynamic> savedData =
          storage.read<List<dynamic>>(addressStorageKey) ?? [];

      final List<Map<String, dynamic>> addresses =
      savedData.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();

      final bool isFirstAddress = addresses.isEmpty;

      final Map<String, dynamic> newAddress = {
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'name':
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        'company': companyController.text.trim(),
        'address': addressController.text.trim(),
        'address2': apartmentController.text.trim(),
        'city': cityController.text.trim(),
        'country': selectedCountry.value,
        'phone': phoneController.text.trim(),
        'dialCode': selectedDialCode,
        'type': 'HOME',
        'isDefault': isFirstAddress,
        'createdAt': DateTime.now().toIso8601String(),
      };

      addresses.add(newAddress);

      await storage.write(addressStorageKey, addresses);

      debugPrint('ADDRESS SAVED SUCCESSFULLY');
      debugPrint('Saved addresses: ${storage.read(addressStorageKey)}');

      Get.snackbar(
        'Success',
        'Address saved successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e, stackTrace) {
      debugPrint('SAVE ADDRESS ERROR: $e');
      debugPrint('STACK TRACE: $stackTrace');

      Get.snackbar(
        'Error',
        'Unable to save address. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isSaving.value = false;
    }
  }


  @override
  void onClose() {
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    companyController.dispose();
    addressController.dispose();
    apartmentController.dispose();
    cityController.dispose();

    super.onClose();
  }
}
