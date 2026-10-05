import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maliaextention/color/colorstheam.dart';

class AppSnackbar {
  static void success(String message) {
    _show("Success", message, Colorstheam.black);
  }

  static void error(String message) {
    _show("Error", message, Colorstheam.black);
  }

  static void warning(String message) {
    _show("Warning", message, Colorstheam.black);
  }

  static void info(String message) {
    _show("Help", message, Colorstheam.black);
  }

  static void _show(String title, String message, Color color) {
    final context = Get.context;
    if (context == null) return;
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: const Duration(seconds: 3),
      content: _buildToast(title, message, color),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Widget _buildToast(String title, String message, Color color) {
    final bgColor = Color.lerp(Colors.white, color, 0.12)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: bgColor,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 40, top: 12, bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans", ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.sp,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.w400, ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6,
                color: color,
              ),
            ),
            Positioned(
              right: 10,
              top: 18,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}