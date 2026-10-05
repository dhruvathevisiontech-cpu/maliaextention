import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';

class Forgotpasscodecontroller extends GetxController {
  static const String staticOtp = "123456";
  late final String email;
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  final isLoading = false.obs;
  final canResend = false.obs;
  final seconds = 30.obs;
  @override
  void onClose() {
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is String) {
      email = args;
    } else if (args is Map && args['email'] is String) {
      email = args['email'];
    } else {
      email = '';
    }
  }
  Timer? _timer;
  void startTimer() {
    _timer?.cancel();

    canResend.value = false;
    seconds.value = 30;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (seconds.value <= 1) {
          timer.cancel();
          seconds.value = 0;
          canResend.value = true;
        } else {
          seconds.value--;
        }
      },
    );
  }
  Future<void> verifyOtp() async {
    if (otpController.text.length != 6) {
      Get.snackbar(
        "Error",
        "Please enter a 6-digit OTP",
      );
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    if (otpController.text == staticOtp) {
      Get.snackbar(
        "Success",
        "OTP Verified Successfully",
      );
      Get.offAllNamed(Routes.RESETPASSWORD);
    } else {
      Get.snackbar(
        "Error",
        "Invalid OTP",
      );
    }
  }
  Future<void> resendOtp() async {
    if (!canResend.value) return;

    otpController.clear();

    otpFocusNode.requestFocus();

    startTimer();

    Get.snackbar(
      "Success",
      "OTP resent successfully\nStatic OTP: $staticOtp",
    );
  }
}