import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';
import 'package:maliaextention/typo/appsnackbar.dart';

class Loginotpcontroller extends GetxController {
  static const String staticOtp = "123456";
  late String email;
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();
  final isLoading = false.obs;
  final canResend = false.obs;
  final seconds = 30.obs;
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map) {
      email = arguments['email']?.toString() ?? '';
    }
    startTimer();
  }

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
      AppSnackbar.error("Please enter a 6-digit OTP",);
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (otpController.text == staticOtp) {
      await AuthSessionHelper.saveSession(
        email: email,
        customerId: "",
        token: "",
        loginType: "email",
      );
      isLoading.value = false;
      AppSnackbar.success("OTP Verified Successfully",);
      Get.offAllNamed(Routes.BOTTOMNAV);
    } else {
      isLoading.value = false;
      AppSnackbar.error(
        "Invalid OTP",
      );
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    otpController.clear();
    otpFocusNode.requestFocus();
    startTimer();
    AppSnackbar.success("OTP resent successfully",);
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }
}