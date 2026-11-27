import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';

class Logincontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailError = ''.obs;
  final isEmailValid = false.obs;
  final RxBool isLoading = false.obs;
  final inputController = TextEditingController();
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  static const String _clientId = '6ddc14ee-d8e6-403b-b938-7cbf9b6d9423';
  static const String _redirectUrl = 'shop.59194507347.app://callback';
  static const String _discoveryUrl = 'https://maliaextensions.com/.well-known/openid-configuration';
  static const AuthorizationServiceConfiguration _serviceConfiguration =
  AuthorizationServiceConfiguration(
    authorizationEndpoint: 'https://shopify.com/authentication/59194507347/oauth/authorize',
    tokenEndpoint: 'https://shopify.com/authentication/59194507347/oauth/token',
    endSessionEndpoint: 'https://shopify.com/authentication/59194507347/logout',
  );
  static const String _customerApiUrl = 'https://shopify.com/59194507347/account/customer/api/2026-10/graphql';
  static const List<String> _scopes = ['openid', 'email', 'customer-account-api:full',];
  Timer? _debounce;
  Future<void> login() async {
    if (isLoading.value) return;
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final email = inputController.text.trim().toLowerCase();
    isLoading.value = true;
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          loginHint: email,
        ),
      );
      final accessToken = result.accessToken;
      final idToken = result.idToken;
      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Shopify access token was not returned.');
      }
      final customer = await getAuthenticatedCustomer(accessToken);
      final customerId = customer['id']?.toString() ?? '';
      final customerEmail = customer['emailAddress']?['emailAddress']?.toString() ?? email;
      if (customerId.isEmpty) {
        throw Exception('Shopify customer ID was not returned.');
      }
      await AuthSessionHelper.saveSession(
        email: customerEmail,
        customerId: customerId,
        token: accessToken,
        idToken: idToken,
        loginType: 'shopify_customer_account',
        accessTokenExpiresAt: result.accessTokenExpirationDateTime,
      );
      Get.offAllNamed(Routes.BOTTOMNAV);
    } on FlutterAppAuthUserCancelledException {
    } catch (e, stackTrace) {
      AppSnackbar.error(
        'Unable to sign in. Please try again.',
      );
    }
  }
  Future<Map<String, dynamic>> getAuthenticatedCustomer(String accessToken) async {
    const query = '''
      query {
        customer {
          id
          firstName
          lastName
          emailAddress {
            emailAddress
          }
        }
      }
    ''';
    final response = await http.post(
      Uri.parse(_customerApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: jsonEncode({
        'query': query,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception(
        'Customer API failed: ${response.statusCode} ${response.body}',
      );
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (decoded['errors'] != null) {
      throw Exception(
        'Shopify GraphQL error: ${decoded['errors']}',
      );
    }
    final data = decoded['data'] as Map<String, dynamic>?;
    final customer = data?['customer'];
    if (customer == null || customer is! Map) {
      throw Exception('Authenticated customer was not found.');
    }
    return Map<String, dynamic>.from(customer);
  }
  void onInputChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => validateEmailLive(value));
  }
  void validateEmailLive(String value) {
    if (value.isEmpty) {
      emailError.value = '';
      isEmailValid.value = false;
      return;
    }
    if (!GetUtils.isEmail(value.trim())) {
      emailError.value = 'Enter a valid email';
      isEmailValid.value = false;
      return;
    }
    emailError.value = '';
    isEmailValid.value = true;
  }
  String? validateEmailField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }
  @override
  void onClose() {
    _debounce?.cancel();
    inputController.dispose();
    super.onClose();
  }
}