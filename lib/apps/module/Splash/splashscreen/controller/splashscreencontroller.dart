import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';


class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> logoScale;
  late Animation<double> logoOpacity;
  late Animation<double> logoRotation;
  late Animation<double> glowOpacity;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    logoScale = Tween<double>(
      begin: 0.78,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.55,
          curve: Curves.easeOut,
        ),
      ),
    );

    logoRotation = Tween<double>(
      begin: -0.025,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    glowOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.15,
          0.65,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
    animationController.forward();
    checkSession();
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(milliseconds: 2300));

    if (isClosed) return;

    final session = AuthSessionHelper.getSession();

    final isLoggedIn = session?['isLoggedIn'] == true;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.BOTTOMNAV);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}