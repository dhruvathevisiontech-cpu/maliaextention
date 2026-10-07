import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/countrymodel.dart';

class Saveaddresscontroller extends GetxController {
  RxString selectedCountry = "United States".obs;
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();

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
  final List<CountryModel> countries = [
    CountryModel(
      name: "United States",
      code: "US",
      dialCode: "+1",
    ),
    CountryModel(
      name: "Canada",
      code: "CA",
      dialCode: "+1",
    ),
    CountryModel(
      name: "India",
      code: "IN",
      dialCode: "+91",
    ),
    CountryModel(
      name: "United Kingdom",
      code: "GB",
      dialCode: "+44",
    ),
    CountryModel(
      name: "Australia",
      code: "AU",
      dialCode: "+61",
    ),
  ];

  void searchAddress(String query) {
    if (query.trim().isEmpty) {
      addressSuggestions.clear();
      return;
    }

    final searchQuery = query.toLowerCase().trim();

    addressSuggestions.value = dummyAddresses.where((address) {
      final fullAddress =
      "${address["address"]} ${address["location"]}".toLowerCase();

      return fullAddress.contains(searchQuery);
    }).toList();
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