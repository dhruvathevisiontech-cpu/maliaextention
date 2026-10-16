import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Resetpasswordcontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordcontroller = TextEditingController();
  RxBool isLoading = false.obs;
  var passworderror = "".obs;
  var isPasswordvalid = false.obs;
  var isPasswordVisible = false.obs;
  final confirmpasswordcontroller = TextEditingController();

  var confirmpassworderror = "".obs;
  var isConfirmPasswordValid = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void validatePasswordLive(String value) {
    if (value.isEmpty) {
      passworderror.value = "";
      isPasswordvalid.value = false;
    } else if (value.length < 8) {
      passworderror.value = "Password must be at least 8 characters";
      isPasswordvalid.value = false;
    } else {
      passworderror.value = "";
      isPasswordvalid.value = true;
    }

    // Re-check confirm password
    if (confirmpasswordcontroller.text.isNotEmpty) {
      validateConfirmPasswordLive(
        confirmpasswordcontroller.text,
      );
    }
  }

  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    return null;
  }
  void validateConfirmPasswordLive(String value) {
    if (value.isEmpty) {
      confirmpassworderror.value = "";
      isConfirmPasswordValid.value = false;
      return;
    }

    if (value != passwordcontroller.text) {
      confirmpassworderror.value = "Passwords do not match";
      isConfirmPasswordValid.value = false;
      return;
    }

    confirmpassworderror.value = "";
    isConfirmPasswordValid.value = true;
  }
  String? validateConfirmPasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != passwordcontroller.text) {
      return "Passwords do not match";
    }

    return null;
  }
  @override
  void onClose() {
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();

    super.onClose();
  }
}