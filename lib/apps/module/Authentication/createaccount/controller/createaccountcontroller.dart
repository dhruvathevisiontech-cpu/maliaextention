
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

// Add your existing ShopifyCollectionService import here.

class Createaccountcontroller extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String countryCode = '+1';
  String countryIsoCode = 'US';

  final RxBool isAccepted = false.obs;
  final RxBool isAccepted1 = false.obs;

  final firstNameError = ''.obs;
  final lastNameError = ''.obs;
  final emailError = ''.obs;
  final phoneError = ''.obs;

  final isFirstNameValid = false.obs;
  final isLastNameValid = false.obs;
  final isEmailValid = false.obs;
  final isPhoneValid = false.obs;

  final isLoading = false.obs;

  // ---------------- FIRST NAME ----------------

  void validateFirstNameLive(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      firstNameError.value = '';
      isFirstNameValid.value = false;
    } else if (trimmed.length < 2) {
      firstNameError.value = 'Minimum 2 characters required';
      isFirstNameValid.value = false;
    } else if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$')
        .hasMatch(trimmed)) {
      firstNameError.value = 'Enter a valid name';
      isFirstNameValid.value = false;
    } else {
      firstNameError.value = '';
      isFirstNameValid.value = true;
    }
  }

  String? validateFirstName(String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) return 'First name is required';
    if (trimmed.length < 2) {
      return 'Minimum 2 characters required';
    }
    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$')
        .hasMatch(trimmed)) {
      return 'Enter a valid name';
    }

    return null;
  }

  // ---------------- LAST NAME ----------------

  void validateLastNameLive(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      lastNameError.value = '';
      isLastNameValid.value = false;
    } else if (trimmed.length < 2) {
      lastNameError.value = 'Minimum 2 characters required';
      isLastNameValid.value = false;
    } else if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$')
        .hasMatch(trimmed)) {
      lastNameError.value = 'Enter a valid name';
      isLastNameValid.value = false;
    } else {
      lastNameError.value = '';
      isLastNameValid.value = true;
    }
  }

  String? validateLastName(String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) return 'Last name is required';
    if (trimmed.length < 2) {
      return 'Minimum 2 characters required';
    }
    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$')
        .hasMatch(trimmed)) {
      return 'Enter a valid name';
    }

    return null;
  }

  // ---------------- EMAIL ----------------

  void validateEmailLive(String value) {
    final email = value.trim();

    if (email.isEmpty) {
      emailError.value = '';
      isEmailValid.value = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email';
      isEmailValid.value = false;
    } else {
      emailError.value = '';
      isEmailValid.value = true;
    }
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  // ---------------- PHONE ----------------

  void updateCountry({
    required String dialCode,
    required String isoCode,
  }) {
    countryCode = dialCode;
    countryIsoCode = isoCode;
    validatePhoneLive(phoneController.text);
  }
  bool isValidUSPhone(String digits) {
    return RegExp(r'^[2-9][0-9]{2}[2-9][0-9]{6}$')
        .hasMatch(digits);
  }
  void validatePhoneLive(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      phoneError.value = '';
      isPhoneValid.value = false;
      return;
    }
    if (countryIsoCode == 'US') {
      final valid = digits.length == 10 && RegExp(r'^[2-9][0-9]{2}[2-9][0-9]{6}$').hasMatch(digits);
      isPhoneValid.value = valid;
      phoneError.value = valid ? '' : 'Enter a valid phone number';
      return;
    }
    try {
      final parsedPhone = PhoneNumber.parse(
        digits,
        destinationCountry: IsoCode.fromJson(countryIsoCode),
      );

      isPhoneValid.value = parsedPhone.isValid();
      phoneError.value =
      isPhoneValid.value ? '' : 'Enter a valid phone number';
    } catch (_) {
      isPhoneValid.value = false;
      phoneError.value = 'Enter a valid phone number';
    }
  }

  String? validatePhoneField(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      return 'Phone number is required';
    }

    if (countryIsoCode == 'US') {
      return isValidUSPhone(digits)
          ? null
          : 'Enter a valid phone number';
    }

    try {
      final parsedPhone = PhoneNumber.parse(
        digits,
        destinationCountry: IsoCode.fromJson(countryIsoCode),
      );

      return parsedPhone.isValid()
          ? null
          : 'Enter a valid phone number';
    } catch (_) {
      return 'Enter a valid phone number';
    }
  }
// Keep these names because your existing UI may call them.
  void validatephoneLive(String value) {
    validatePhoneLive(value);
  }

  String? validatephoneField(String? value) {
    return validatePhoneField(value);
  }

  String getFullPhoneNumber() {
    final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');

    return '$countryCode$digits';
  }

  // ---------------- FORM VALIDATION ----------------

  bool validateForm() {
    validateFirstNameLive(firstNameController.text);
    validateLastNameLive(lastNameController.text);
    validateEmailLive(emailController.text);
    validatePhoneLive(phoneController.text);

    final formValid = formKey.currentState?.validate() ?? false;

    return formValid &&
        isFirstNameValid.value &&
        isLastNameValid.value &&
        isEmailValid.value &&
        isPhoneValid.value;
  }

  // ---------------- RANDOM PASSWORD ----------------

  String generateRandomPassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyz'
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        '0123456789';

    final random = Random.secure();

    final randomPart = List.generate(
      24,
          (_) => chars[random.nextInt(chars.length)],
    ).join();

    return 'Malia$randomPart@9Aa';
  }

  // ---------------- SHOPIFY CUSTOMER CREATE ----------------

  Future<String> createShopifyCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    const mutation = r'''
      mutation CustomerCreate($input: CustomerCreateInput!) {
        customerCreate(input: $input) {
          customer {
            id
            firstName
            lastName
            email
            phone
          }
          customerUserErrors {
            field
            message
            code
          }
        }
      }
    ''';

    final data = await ShopifyCollectionService.query(
      mutation,
      variables: {
        'input': {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
        },
      },
    );

    final result = data['customerCreate'];

    if (result == null) {
      throw Exception('Shopify customer creation returned no response.');
    }

    final errors =
        result['customerUserErrors'] as List<dynamic>? ?? [];

    if (errors.isNotEmpty) {
      throw Exception(
        errors.first['message'] ?? 'Unable to create customer.',
      );
    }

    final customer = result['customer'];

    if (customer == null || customer['id'] == null) {
      throw Exception('Shopify customer ID was not returned.');
    }

    return customer['id'].toString();
  }
  void validatePhoneLive1(String value) {
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


  // ---------------- SHOPIFY CUSTOMER LOGIN ----------------

  Future<Map<String, dynamic>> shopifyLogin({
    required String email,
    required String password,
  }) async {
    const mutation = r'''
      mutation CustomerAccessTokenCreate(
        $input: CustomerAccessTokenCreateInput!
      ) {
        customerAccessTokenCreate(input: $input) {
          customerAccessToken {
            accessToken
            expiresAt
          }
          customerUserErrors {
            field
            message
            code
          }
        }
      }
    ''';

    final data = await ShopifyCollectionService.query(
      mutation,
      variables: {
        'input': {
          'email': email,
          'password': password,
        },
      },
    );

    final result = data['customerAccessTokenCreate'];

    if (result == null) {
      throw Exception('Shopify login returned no response.');
    }

    final errors =
        result['customerUserErrors'] as List<dynamic>? ?? [];

    if (errors.isNotEmpty) {
      throw Exception(
        errors.first['message'] ?? 'Shopify login failed.',
      );
    }

    final accessToken = result['customerAccessToken'];

    if (accessToken == null ||
        accessToken['accessToken'] == null) {
      throw Exception('Customer access token was not returned.');
    }

    return {
      'token': accessToken['accessToken'].toString(),
      'expiresAt': accessToken['expiresAt'],
    };
  }

  // ---------------- CUSTOMER DETAILS ----------------

  Future<Map<String, dynamic>> getCustomerDetails(
      String token,
      ) async {
    const query = r'''
      query GetCustomer($customerAccessToken: String!) {
        customer(customerAccessToken: $customerAccessToken) {
          id
          firstName
          lastName
          email
          phone
        }
      }
    ''';

    final data = await ShopifyCollectionService.query(
      query,
      variables: {
        'customerAccessToken': token,
      },
    );

    final customer = data['customer'];

    if (customer == null || customer['id'] == null) {
      throw Exception('Unable to load Shopify customer details.');
    }

    return Map<String, dynamic>.from(customer);
  }

  // ---------------- CREATE ACCOUNT ----------------

  Future<void> createAccount() async {
    if (isLoading.value) return;

    if (!validateForm()) {
      AppSnackbar.error('Please check all required fields.');
      return;
    }

    isLoading.value = true;

    try {
      final email = emailController.text.trim().toLowerCase();
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final phone = getFullPhoneNumber();
      final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');
      final password = generateRandomPassword();
      await createShopifyCustomer(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );

      // 2. Generate Shopify customer access token.
      final loginResult = await shopifyLogin(
        email: email,
        password: password,
      );

      final token = loginResult['token'].toString();

      // 3. Fetch Shopify customer details.
      final customer = await getCustomerDetails(token);

      final customerId = customer['id'].toString();

      // 4. Save Malia customer session.
      await AuthSessionHelper.saveSession(
        email: customer['email']?.toString() ?? email,
        customerId: customerId.split('/').last,
        token: token,
        loginType: 'email',
        phone: customer['phone']?.toString() ?? phone,
        accessTokenExpiresAt:
        DateTime.tryParse(loginResult['expiresAt']?.toString() ?? ''),
      );

      // 5. Navigate to home.
      AppSnackbar.success('Account created successfully!');

      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      Get.offAllNamed(Routes.BOTTOMNAV);
    } catch (e, stackTrace) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
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
class UsPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final limitedDigits = digits.length > 10
        ? digits.substring(0, 10)
        : digits;

    final buffer = StringBuffer();

    for (int i = 0; i < limitedDigits.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');

      buffer.write(limitedDigits[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}