
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Deleteaccountcontroller extends GetxController {

  Future<void> openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@maliaextensions.com',
      queryParameters: {
        'subject': 'Delete My Account',
      },
    );

    try {
      final bool launched = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar(
          'Unable to open email',
          'Please configure an email application on your device.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open your email application.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
