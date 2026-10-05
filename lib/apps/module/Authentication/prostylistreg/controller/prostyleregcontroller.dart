import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/model/addressmodel.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class Prostyleregcontroller extends GetxController {
  final List<String> countryList = [
    "United States",
    "Canada",
    "United Kingdom",
    "Australia",
    "Argentina",
    "Austria",
    "Bahamas",
    "Bangladesh",
    "Barbados",
    "Belgium",
    "Brazil",
    "Chile",
    "China",
    "Colombia",
    "Czech Republic",
    "Denmark",
    "Egypt",
    "Finland",
    "France",
    "Germany",
    "Ghana",
    "Greece",
    "Hong Kong",
    "Hungary",
    "India",
    "Indonesia",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Kenya",
    "Malaysia",
    "Mexico",
    "Netherlands",
    "New Zealand",
    "Nigeria",
    "Norway",
    "Pakistan",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Romania",
    "Russia",
    "Saudi Arabia",
    "Singapore",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "Sweden",
    "Switzerland",
    "Taiwan",
    "Thailand",
    "Trinidad and Tobago",
    "Turkey",
    "Ukraine",
    "United Arab Emirates",
    "Vietnam",
  ];
  final Map<String, List<String>> countryStates = {
    "United States": [
      "Alabama",
      "Alaska",
      "Arizona",
      "Arkansas",
      "California",
      "Colorado",
      "Connecticut",
      "Delaware",
      "District of Columbia",
      "Florida",
      "Georgia",
      "Hawaii",
      "Idaho",
      "Illinois",
      "Indiana",
      "Iowa",
      "Kansas",
      "Kentucky",
      "Louisiana",
      "Maine",
      "Maryland",
      "Massachusetts",
      "Michigan",
      "Minnesota",
      "Mississippi",
      "Missouri",
      "Montana",
      "Nebraska",
      "Nevada",
      "New Hampshire",
      "New Jersey",
      "New Mexico",
      "New York",
      "North Carolina",
      "North Dakota",
      "Ohio",
      "Oklahoma",
      "Oregon",
      "Pennsylvania",
      "Rhode Island",
      "South Carolina",
      "South Dakota",
      "Tennessee",
      "Texas",
      "Utah",
      "Vermont",
      "Virginia",
      "Washington",
      "West Virginia",
      "Wisconsin",
      "Wyoming",
    ],

    "Canada": [
      "Alberta",
      "British Columbia",
      "Manitoba",
      "New Brunswick",
      "Newfoundland and Labrador",
      "Nova Scotia",
      "Northwest Territories",
      "Nunavut",
      "Ontario",
      "Prince Edward Island",
      "Quebec",
      "Saskatchewan",
      "Yukon",
    ],

    "United Kingdom": [
      "England",
      "Scotland",
      "Wales",
      "Northern Ireland",
    ],

    "Australia": [
      "Australian Capital Territory",
      "New South Wales",
      "Queensland",
      "South Australia",
      "Tasmania",
      "Victoria",
      "Western Australia",
    ],
  };
  final formKey = GlobalKey<FormState>();
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final zipcodecontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final cosmetologylicensenumbercontroller = TextEditingController();



  var firstnameerror = "".obs;
  var isFirstnamevalid = false.obs;
  var lastnameerror = "".obs;
  var isLastnamevalid = false.obs;
  var emailerror = "".obs;
  var isemailvalid = false.obs;
  var phoneerror = "".obs;
  var isphonevalid = false.obs;
  var addresserror = "".obs;
  var isaddressvalid = false.obs;
  var selectedState = "".obs;
  var states = <String>[].obs;
  var isAddressSelected = false.obs;
  var zipcodeerror = "".obs;
  var iszipcodevalid = false.obs;
  var cosmetologyerror = "".obs;
  var iscosmetologyvalid = false.obs;
  var selectedCountry = "".obs;
  var stateFieldTitle = "State / Province / Region".obs;
  var isStateDropdown = false.obs;
  final RxBool isStateMenuOpen = false.obs;
  final RxBool isCountryMenuOpen = false.obs;
  final ValueNotifier<String?> stateValueNotifier = ValueNotifier<String?>(null);
  final Rxn<PlatformFile> cosmetologyLicenseFile = Rxn<PlatformFile>();
  final RxString cosmetologyLicenseError = ''.obs;
  final RxBool isAccepted = false.obs;
  final RxBool isAccepted1 = false.obs;
  RxBool isLoading = false.obs;
  final List<AddressSuggestion> allAddresses = [
    // USA
    AddressSuggestion(
      address: "123 Main Street",
      city: "New York",
      state: "New York",
      stateCode: "NY",
      zipCode: "10001",
      country: "United States",
    ),

    AddressSuggestion(
      address: "456 Market Street",
      city: "San Francisco",
      state: "California",
      stateCode: "CA",
      zipCode: "94105",
      country: "United States",
    ),

    AddressSuggestion(
      address: "789 Congress Avenue",
      city: "Austin",
      state: "Texas",
      stateCode: "TX",
      zipCode: "73301",
      country: "United States",
    ),

    // Canada
    AddressSuggestion(
      address: "123 Queen Street",
      city: "Toronto",
      state: "Ontario",
      stateCode: "ON",
      zipCode: "M5H 2N2",
      country: "Canada",
    ),

    AddressSuggestion(
      address: "456 Rue Sainte-Catherine",
      city: "Montreal",
      state: "Quebec",
      stateCode: "QC",
      zipCode: "H3B 1A7",
      country: "Canada",
    ),
  ];
  void loadStates() {
    final country = selectedCountry.value.trim();

    if (country.isEmpty) {
      states.clear();
      selectedState.value = "";
      statecontroller.clear();
      isStateDropdown.value = false;
      stateFieldTitle.value = "State / Province / Region";
      return;
    }

    if (countryStates.containsKey(country)) {
      states.value = List<String>.from(countryStates[country]!);
      isStateDropdown.value = true;
    } else {
      states.clear();
      isStateDropdown.value = false;
    }

    switch (country) {
      case "United States":
        stateFieldTitle.value = "State";
        break;

      case "Canada":
        stateFieldTitle.value = "Province";
        break;

      case "United Kingdom":
        stateFieldTitle.value = "Region";
        break;

      case "Australia":
        stateFieldTitle.value = "State";
        break;

      default:
        stateFieldTitle.value = "State / Province / Region";
    }

    if (!states.contains(selectedState.value)) {
      selectedState.value = "";
      statecontroller.clear();
    }
  }
  final Rxn<PlatformFile> licenseFile = Rxn<PlatformFile>();
  final RxString licenseError = ''.obs;

  Future<void> pickLicenseFile() async {
    licenseError.value = '';

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'pdf',
        ],
      );

      if (result.isEmpty) {
        return;
      }

      final file = result.first;

      // Make sure we have a path
      if (file.path == null || file.path!.isEmpty) {
        licenseError.value = 'Unable to access the selected file.';
        return;
      }

      final pickedFile = File(file.path!);

      // Check file size
      final fileSize = await pickedFile.length();

      const maxSize = 10 * 1024 * 1024; // 10 MB

      if (fileSize > maxSize) {
        licenseFile.value = null;
        licenseError.value = 'File size must be less than 10 MB.';
        return;
      }

      licenseFile.value = file;

      debugPrint('License: ${file.name}');
      debugPrint('Path: ${file.path}');
      debugPrint('Size: $fileSize bytes');
    } catch (e) {
      licenseError.value =
      'Unable to select the license. Please try again.';

      debugPrint('License picker error: $e');
    }
  }
  Future<void> pickCosmetologyLicense() async {
    try {
      debugPrint("LICENSE PICKER CALLED");

      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'pdf',
        ],
      );

      if (file == null) {
        debugPrint("LICENSE PICKER: USER CANCELLED");
        return;
      }

      debugPrint("LICENSE NAME: ${file.name}");

      // --------------------------------
      // Get extension from file name
      // --------------------------------

      final String fileName = file.name.toLowerCase();

      final String extension = fileName.contains('.')
          ? fileName.split('.').last
          : '';

      const allowedExtensions = [
        'jpg',
        'jpeg',
        'png',
        'pdf',
      ];

      if (!allowedExtensions.contains(extension)) {
        cosmetologyLicenseError.value =
        "Only JPG, PNG or PDF files are allowed";

        cosmetologyLicenseFile.value = null;
        return;
      }

      // --------------------------------
      // Store selected file
      // --------------------------------

      cosmetologyLicenseFile.value = file;

      cosmetologyLicenseError.value = '';

      debugPrint(
        "LICENSE PICKED SUCCESSFULLY: ${file.name}",
      );

    } catch (e, stackTrace) {
      debugPrint("LICENSE PICKER ERROR: $e");
      debugPrint(stackTrace.toString());

      cosmetologyLicenseError.value =
      "Unable to select license file. Please try again.";
    }
  }

  @override
  void onInit() {
    super.onInit();

    loadStates();
  }
  var addressSuggestions = <AddressSuggestion>[].obs;

  void onAddressChanged(String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      addressSuggestions.clear();

      addresserror.value = "";
      isaddressvalid.value = false;

      return;
    }

    addressSuggestions.value = allAddresses.where((item) {
      final fullAddress =
          "${item.address}, "
          "${item.city}, "
          "${item.state}, "
          "${item.zipCode}, "
          "${item.country}";

      final matchesQuery =
      fullAddress.toLowerCase().contains(query);

      final matchesCountry =
          selectedCountry.value.isEmpty ||
              item.country.toLowerCase() ==
                  selectedCountry.value.toLowerCase();

      return matchesQuery && matchesCountry;
    }).take(5).toList();

    if (value.trim().length < 5) {
      addresserror.value = "Enter a valid address";
      isaddressvalid.value = false;
    } else {
      addresserror.value = "";
      isaddressvalid.value = true;
    }
  }
  void selectAddress(AddressSuggestion suggestion) {
    addresscontroller.text = suggestion.address;

    citycontroller.text = suggestion.city;

    zipcodecontroller.text = suggestion.zipCode;

    countrycontroller.text = suggestion.country;
    selectedCountry.value = suggestion.country;

    // Load state options for the selected country
    if (countryStates.containsKey(suggestion.country)) {
      states.value = List<String>.from(
        countryStates[suggestion.country]!,
      );

      isStateDropdown.value = true;
    } else {
      states.clear();
      isStateDropdown.value = false;
    }

    // Set title
    switch (suggestion.country) {
      case "United States":
        stateFieldTitle.value = "State";
        break;

      case "Canada":
        stateFieldTitle.value = "Province";
        break;

      case "United Kingdom":
        stateFieldTitle.value = "Region";
        break;

      case "Australia":
        stateFieldTitle.value = "State";
        break;

      default:
        stateFieldTitle.value = "State / Province / Region";
    }

    statecontroller.text = suggestion.state;
    selectedState.value = suggestion.state;

    isAddressSelected.value = true;

    addressSuggestions.clear();

    addresserror.value = "";
    isaddressvalid.value = true;

    addresscontroller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: addresscontroller.text.length,
      ),
    );
  }
  void selectCountry(String? value) {
    if (value == null || value.isEmpty) return;

    selectedCountry.value = value;
    countrycontroller.text = value;

    // Clear previous state
    selectedState.value = "";
    statecontroller.clear();
    states.clear();

    // Check whether this country has predefined states
    if (countryStates.containsKey(value)) {
      states.value = List<String>.from(countryStates[value]!);
      isStateDropdown.value = true;
    } else {
      // Other countries use normal text field
      isStateDropdown.value = false;
    }

    // Change title
    switch (value) {
      case "United States":
        stateFieldTitle.value = "State";
        break;

      case "Canada":
        stateFieldTitle.value = "Province";
        break;

      case "United Kingdom":
        stateFieldTitle.value = "Region";
        break;

      case "Australia":
        stateFieldTitle.value = "State";
        break;

      default:
        stateFieldTitle.value = "State / Province / Region";
    }
  }

  void selectState(String? value) {
    if (value == null || value.isEmpty) return;

    selectedState.value = value;
    statecontroller.text = value;
  }
  @override
  void onClose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    citycontroller.dispose();
    statecontroller.dispose();
    zipcodecontroller.dispose();
    countrycontroller.dispose();
    cosmetologylicensenumbercontroller.dispose();
    super.onClose();
  }
  //Validation
  void validateFirstnameLive(String value) {
    if (value.isEmpty) {
      firstnameerror.value = "";
      isFirstnamevalid.value = false;
      return;
    }

    if (!GetUtils.isUsername(value.trim())) {
      firstnameerror.value = "Enter a valid name";
      isFirstnamevalid.value = false;
      return;
    }

    firstnameerror.value = "";
    isFirstnamevalid.value = true;
  }
  String? validateFirstnameField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "First Name is required";
    }

    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid First Name";
    }

    return null;
  }
  void validatelastnameLive(String value) {
    if (value.isEmpty) {
      lastnameerror.value = "";
      isLastnamevalid.value = false;
      return;
    }

    if (!GetUtils.isUsername(value.trim())) {
      lastnameerror.value = "Enter a valid name";
      isLastnamevalid.value = false;
      return;
    }

    lastnameerror.value = "";
    isLastnamevalid.value = true;
  }
  String? validateLastnameField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Last Name is required";
    }

    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid Last Name";
    }

    return null;
  }
  void validateemailLive(String value) {
    if (value.isEmpty) {
      emailerror.value = "";
      isemailvalid.value = false;
      return;
    }

    if (!GetUtils.isEmail(value.trim())) {
      emailerror.value = "Enter a valid email";
      isemailvalid.value = false;
      return;
    }

    emailerror.value = "";
    isemailvalid.value = true;
  }
  String? validateemailField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }
  void validatephoneLive(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      phoneerror.value = "";
      isphonevalid.value = false;
      return;
    }

    if (digits.length != 10) {
      phoneerror.value = "Enter a valid phone number";
      isphonevalid.value = false;
      return;
    }

    phoneerror.value = "";
    isphonevalid.value = true;
  }
  String? validatephoneField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 10) {
      return "Enter a valid phone number";
    }

    return null;
  }
  void validateaddressLive(String value) {
    if (value.trim().isEmpty) {
      addresserror.value = "";
      isaddressvalid.value = false;
      return;
    }

    if (value.trim().length < 5) {
      addresserror.value = "Enter a valid address";
      isaddressvalid.value = false;
      return;
    }

    addresserror.value = "";
    isaddressvalid.value = true;
  }
  String? validateaddressField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }

    if (value.trim().length < 5) {
      return "Enter a valid address";
    }

    return null;
  }
  void validateZipcodeLive(String value) {
    final zip = value.trim();

    if (zip.isEmpty) {
      zipcodeerror.value = "";
      iszipcodevalid.value = false;
      return;
    }

    if (!RegExp(r'^\d{5}$').hasMatch(zip)) {
      zipcodeerror.value = "Enter a valid ZIP code";
      iszipcodevalid.value = false;
      return;
    }

    zipcodeerror.value = "";
    iszipcodevalid.value = true;
  }
  String? validateZipcodeField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "ZIP Code is required";
    }

    if (!RegExp(r'^\d{5}$').hasMatch(value.trim())) {
      return "Enter a valid ZIP code";
    }

    return null;
  }
  void validatecosmetologyLive(String value) {
    final licenseNumber = value.trim();

    // Empty
    if (licenseNumber.isEmpty) {
      cosmetologyerror.value = "";
      iscosmetologyvalid.value = false;
      return;
    }

    // Remove spaces only for validation
    final normalizedLicense = licenseNumber.replaceAll(' ', '');

    // Allow letters, numbers, hyphen and slash
    final licenseRegex = RegExp(r'^[A-Za-z0-9/-]{4,20}$');

    if (!licenseRegex.hasMatch(normalizedLicense)) {
      cosmetologyerror.value = "Enter a valid cosmetology license number";
      iscosmetologyvalid.value = false;
      return;
    }

    cosmetologyerror.value = "";
    iscosmetologyvalid.value = true;
  }
  String? validateCosmetologyField(String? value) {
    final licenseNumber = value?.trim() ?? '';

    if (licenseNumber.isEmpty) {
      return "Cosmetology license number is required";
    }

    final normalizedLicense = licenseNumber.replaceAll(' ', '');

    final licenseRegex = RegExp(r'^[A-Za-z0-9/-]{4,20}$');

    if (!licenseRegex.hasMatch(normalizedLicense)) {
      return "Enter a valid cosmetology license number";
    }

    return null;
  }
}