import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Profilecontroller extends GetxController {
  final RxBool isProfileExpanded = false.obs;
  final RxInt selectedLogoutButton = (-1).obs;
  void showLogoutBottomSheet() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          24.w,
          24.h,
          24.w,
          12.h,
        ),
        decoration: BoxDecoration(
          color: Colorstheam.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'LOG OUT',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                "Are you sure you want to log out of your account? ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  height: 1.65,
                  color: Colorstheam.dimgrey,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: Obx(
                        () {
                      final isSelected = selectedLogoutButton.value == 0;

                      return AnimatedButton(
                        onTap: () async {
                          selectedLogoutButton.value = 0;
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );

                          Get.back();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colorstheam.nobelblack
                                : Colorstheam.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colorstheam.white:Colorstheam.nobelblack,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Obx(
                        () {
                      final isSelected = selectedLogoutButton.value == 1;

                      return AnimatedButton(
                        onTap: () async {
                          selectedLogoutButton.value = 1;

                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );

                          Get.back();
                          logout();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colorstheam.nobelblack
                                : Colorstheam.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Log out',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colorstheam.white:Colorstheam.nobelblack,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      ignoreSafeArea: true,
    );
  }


  void logout() {
    // Add your existing authentication logout logic here.
  }
}