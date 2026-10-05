/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-08
/// - Build This screen
/// ------------------------------------------------------------

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgotpasswordcontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  var emailError = "".obs;
  var isEmailValid = false.obs;
  final inputController = TextEditingController();
  Timer? _debounce;
  RxBool isLoading = false.obs;
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