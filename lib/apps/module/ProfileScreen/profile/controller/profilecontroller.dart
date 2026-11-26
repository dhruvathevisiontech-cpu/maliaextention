import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';

class Profilecontroller extends GetxController {
  final RxBool isProfileExpanded = false.obs;
  final RxInt selectedLogoutButton = (-1).obs;
  void showLogoutBottomSheet() {
    selectedLogoutButton.value = -1;
    Get.bottomSheet(
      Container(
        width: double.infinity,
        color: Colorstheam.white,
        padding: EdgeInsets.fromLTRB(26.w, 30.h, 26.w, 24.h,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ACCOUNT',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
                color: Colorstheam.dimgrey,
              ),
            ),
            SizedBox(height: 13.h),
            Text(
              'Leaving so soon?',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 27.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'You are about to sign out of your account. You can always come back whenever you are ready.',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 14.sp,
                height: 1.7,
                fontWeight: FontWeight.w400,
                color: Colorstheam.dimgrey,
              ),
            ),
            SizedBox(height: 28.h),
            Container(
              height: 1,
              width: double.infinity,
              color: Colorstheam.lightgrey,
            ),
            SizedBox(height: 22.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(() {
                    final isSelected = selectedLogoutButton.value == 0;
                    return AnimatedButton(
                      onTap: () async {
                        selectedLogoutButton.value = 0;
                        await Future.delayed(
                          const Duration(milliseconds: 200),
                        );
                        Get.back();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: isSelected ? Colorstheam.lightgrey : Colorstheam.white,
                          border: Border.all(
                            color: Colorstheam.nobelblack,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(() {
                    final isSelected = selectedLogoutButton.value == 1;
                    return AnimatedButton(
                      onTap: () async {
                        selectedLogoutButton.value = 1;
                        await Future.delayed(
                          const Duration(milliseconds: 250),
                        );
                        Get.back();
                        logout();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: isSelected ? Colorstheam.grey : Colorstheam.nobelblack,
                          border: Border.all(
                            color: Colorstheam.nobelblack,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'LOG OUT',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Colorstheam.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 4.h),
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
  Future<void> logout() async {
    await AuthSessionHelper.logout();
    Get.offAllNamed(Routes.ONBOARDING);
  }
}