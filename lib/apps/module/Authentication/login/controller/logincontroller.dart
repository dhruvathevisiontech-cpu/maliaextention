import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/authrepository.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/typo/appsnackbar.dart';

class Logincontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  var emailError = "".obs;
  var isEmailValid = false.obs;
  final inputController = TextEditingController();
  final repository = AuthRepository();
  RxBool isLoading = false.obs;
  Timer? _debounce;
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading(true);

    final result = await repository.login(
      inputController.text.trim(),
    );

    isLoading(false);

    if (!result.success) {
      AppSnackbar.error(result.message);
      return;
    }

    if (result.isVerified) {
      AppSnackbar.success("OTP sent successfully.");
      Get.offAllNamed(
        Routes.LOGINOTP,
        arguments: {
          'email': inputController.text.trim(),
        },
      );
    } else {
      AppSnackbar.warning("Your account is not verified.");
    }
  }
  @override
  void onInit() {
    super.onInit();
    print("LoginController Init");
  }
  @override
  void onClose() {
    print("LoginController Close");
    _debounce?.cancel();
    inputController.dispose();
    super.onClose();
  }
  void onInputChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      validateEmailLive(value);
    });
  }
  //Validation
  void validateEmailLive(String value) {
    if (value.isEmpty) {
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
  String? validateEmailField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }
}