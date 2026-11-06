
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Contactuscontroller extends GetxController {
  final firstnameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final ordernumberController = TextEditingController();
  final yourmessageController = TextEditingController();

  final isSubmitting = false.obs;

  // Your MALIÁ Shopify store
  final String contactUrl =
      'https://maliaextensions.com/contact';

  Future<void> submitContactForm() async {
    if (isSubmitting.value) return;

    final firstName = firstnameController.text.trim();
    final email = emailController.text.trim();
    final phone = phonenumberController.text.trim();
    final orderNumber = ordernumberController.text.trim();
    final message = yourmessageController.text.trim();

    // Validation
    if (firstName.isEmpty) {
      showMessage('Please enter your name.');
      return;
    }

    if (email.isEmpty ||
        !GetUtils.isEmail(email)) {
      showMessage('Please enter a valid email address.');
      return;
    }

    if (message.isEmpty) {
      showMessage('Please enter your message.');
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await http.post(
        Uri.parse(contactUrl),
        headers: {
          'Content-Type':
          'application/x-www-form-urlencoded',
          'Accept': 'text/html',
        },
        body: {
          'form_type': 'contact',
          'utf8': '✓',
          'contact[first_name]': firstName,
          'contact[email]': email,
          'contact[phone]': phone,
          'contact[order_number]': orderNumber,
          'contact[body]': message,
        },
      );

      debugPrint(
        'Contact API Status: ${response.statusCode}',
      );

      debugPrint(
        'Contact API Response: ${response.body}',
      );

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        showMessage(
          'Shopify responded to your contact request. Please verify that the message reached your store email.',
          isSuccess: true,
        );

        // Clear fields after a successful HTTP response.
        firstnameController.clear();
        emailController.clear();
        phonenumberController.clear();
        ordernumberController.clear();
        yourmessageController.clear();
      } else {
        showMessage(
          'Unable to submit your message. Please try again.',
        );
      }
    } catch (e) {
      debugPrint('Contact API Error: $e');

      showMessage(
        'Something went wrong. Please try again.',
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void showMessage(
      String message, {
        bool isSuccess = false,
      }) {
    Get.snackbar(
      isSuccess ? 'Success' : 'Contact Us',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }

  @override
  void onClose() {
    firstnameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    ordernumberController.dispose();
    yourmessageController.dispose();

    super.onClose();
  }
}
