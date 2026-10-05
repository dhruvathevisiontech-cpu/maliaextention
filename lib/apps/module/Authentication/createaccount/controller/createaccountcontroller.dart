import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class Createaccountcontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  // ------------------------------------------------------------
  // Controllers
  // ------------------------------------------------------------

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // ------------------------------------------------------------
  // Phone
  // ------------------------------------------------------------

  String countryCode = '+1';
  String countryIsoCode = 'US';
  final RxBool isAccepted = false.obs;
  final RxBool isAccepted1 = false.obs;
  // ------------------------------------------------------------
  // Validation
  // ------------------------------------------------------------
  final firstNameError = "".obs;
  final lastNameError = "".obs;
  final emailError = "".obs;
  final phoneError = "".obs;

  final isFirstNameValid = false.obs;
  final isLastNameValid = false.obs;
  final isEmailValid = false.obs;
  final isPhoneValid = false.obs;

  final isLoading = false.obs;

  // ------------------------------------------------------------
  // First Name
  // ------------------------------------------------------------
  void validateFirstNameLive(String value) {
    if (value.trim().isEmpty) {
      firstNameError.value = "";
      isFirstNameValid.value = false;
      return;
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      firstNameError.value = "Minimum 2 characters required";
      isFirstNameValid.value = false;
      return;
    }

    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(trimmed)) {
      firstNameError.value = "Enter a valid name";
      isFirstNameValid.value = false;
      return;
    }

    firstNameError.value = "";
    isFirstNameValid.value = true;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "First name is required";
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return "Minimum 2 characters required";
    }

    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(trimmed)) {
      return "Enter a valid name";
    }

    return null;
  }

  // ------------------------------------------------------------
  // Last Name
  // ------------------------------------------------------------

  void validateLastNameLive(String value) {
    if (value.trim().isEmpty) {
      lastNameError.value = "";
      isLastNameValid.value = false;
      return;
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      lastNameError.value = "Minimum 2 characters required";
      isLastNameValid.value = false;
      return;
    }

    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(trimmed)) {
      lastNameError.value = "Enter a valid name";
      isLastNameValid.value = false;
      return;
    }

    lastNameError.value = "";
    isLastNameValid.value = true;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Last name is required";
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return "Minimum 2 characters required";
    }

    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(trimmed)) {
      return "Enter a valid name";
    }

    return null;
  }

  // ------------------------------------------------------------
  // Email
  // ------------------------------------------------------------
  void validateEmailLive(String value) {
    if (value.trim().isEmpty) {
      emailError.value = "";
      isEmailValid.value = false;
      return;
    }

    if (!GetUtils.isEmail(value.trim())) {
      emailError.value = "Enter a valid email";
      isEmailValid.value = false;
      return;
    }

    emailError.value = "";
    isEmailValid.value = true;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  // ------------------------------------------------------------
  // Phone
  // ------------------------------------------------------------

  void updateCountry({
    required String dialCode,
    required String isoCode,
  }) {
    countryCode = dialCode;
    countryIsoCode = isoCode;

    validatePhoneLive(phoneController.text);
  }
  void validatePhoneLive(String value) {
    final phone = value.trim();

    if (phone.isEmpty) {
      phoneError.value = "Phone number is required";
      isPhoneValid.value = false;
      return;
    }

    try {
      final isoCode = IsoCode.fromJson(countryIsoCode);

      final parsedPhone = PhoneNumber.parse(
        phone,
        destinationCountry: isoCode,
      );

      if (!parsedPhone.isValid()) {
        phoneError.value = "Enter a valid phone number";
        isPhoneValid.value = false;
        return;
      }

      phoneError.value = "";
      isPhoneValid.value = true;
    } catch (e) {
      phoneError.value = "Enter a valid phone number";
      isPhoneValid.value = false;
    }
  }
  // ------------------------------------------------------------
  // Complete Validation
  // ------------------------------------------------------------

  bool validateForm() {
    // Trigger all GetX validations
    validateFirstNameLive(firstNameController.text);
    validateLastNameLive(lastNameController.text);
    validateEmailLive(emailController.text);
    validatePhoneLive(phoneController.text);

    // Trigger Form validators
    final formValid =
        formKey.currentState?.validate() ?? false;
    return formValid &&
        isFirstNameValid.value &&
        isLastNameValid.value &&
        isEmailValid.value &&
        isPhoneValid.value;
  }

  Future<void> createAccount() async {
    if (!validateForm()) {
      return;
    }
    isLoading.value = true;

    try {
      // --------------------------------------------------------
      // API LOGIC WILL GO HERE LATER
      // --------------------------------------------------------
      //
      // Example:
      //
      // final result = await repository.createAccount(
      //   firstName: firstNameController.text.trim(),
      //   lastName: lastNameController.text.trim(),
      //   email: emailController.text.trim(),
      //   phone: getFullPhoneNumber(),
      // );
      //
      // --------------------------------------------------------

      await Future.delayed(const Duration(seconds: 1));

      debugPrint("First Name: ${firstNameController.text.trim()}");
      debugPrint("Last Name: ${lastNameController.text.trim()}");
      debugPrint("Email: ${emailController.text.trim()}");
      debugPrint("Phone: ${getFullPhoneNumber()}");

      Get.snackbar(
        "Success",
        "Account information is valid",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }
  // ------------------------------------------------------------
  // Full Phone Number
  // ------------------------------------------------------------

  String getFullPhoneNumber() {
    return "$countryCode${phoneController.text.replaceAll(RegExp(r'\D'), '')}";
  }

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------
  void validatephoneLive(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      phoneError.value = "";
      isPhoneValid.value = false;
      return;
    }

    if (digits.length != 10) {
      phoneError.value = "Enter a valid phone number";
      isPhoneValid.value = false;
      return;
    }

    phoneError.value = "";
    isPhoneValid.value = true;
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
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.onClose();
  }
}