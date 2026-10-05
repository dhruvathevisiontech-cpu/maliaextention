// ignore_for_file: prefer_const_constructors_in_immutables

/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-06
/// - Build This Screen
/// ------------------------------------------------------------
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/accountoption/controller/accountoptioncontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Accountoptionview extends GetView<Accountoptioncontroller> {
  Accountoptionview({super.key});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              Get.offAllNamed(Routes.ONBOARDING);
            },
            child: Scaffold(
                backgroundColor: Colorstheam.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.light,
                  ),
                  elevation: 0,
                  centerTitle:true,
                  leading: Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Get.offAllNamed(Routes.ONBOARDING);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colorstheam.black,
                          border: Border.all(
                            color: Colorstheam.black,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "asset/svg/arrowleft.svg",
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screensize.height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          Apptext.createaccount,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text(
                          Apptext.subtitle,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w400,
                              color: Colorstheam.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screensize.height * 0.015),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Apptext.areyouprosytlist,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screensize.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Obx((){
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              controller.selectOption(0);
                              Get.offAllNamed(Routes.PROSTYLISTREGISTRATION);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 186.h,
                                width: 362.w,
                                decoration: BoxDecoration(
                                    color: controller.selectedOption.value == 0
                                        ? Colorstheam.nobelblack
                                        : Colorstheam.white,
                                    border: Border.all(color: Colorstheam.nobelblack)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: screensize.height * 0.015),
                                      child: Text(
                                        "Yes, I’m a Licensed Stylist",
                                        style: TextStyle(
                                            fontSize: 22.sp,
                                            fontFamily: "Urbanist",
                                            fontWeight: FontWeight.bold,
                                            color: controller.selectedOption.value == 0 ? Colorstheam.clusterwhite : Colorstheam.nobelblack
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screensize.height * 0.005),
                                    Padding(
                                      padding: EdgeInsets.only(left: screensize.width * 0.01,right: screensize.width * 0.01),
                                      child: Text(
                                        "Unlock pro pricing, exclusive education resources, and early access to new collections.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "Urbanist",
                                          fontWeight: FontWeight.w500,
                                          color: controller.selectedOption.value == 0 ? Colorstheam.clusterwhite : Colorstheam.nobelblack
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screensize.height * 0.05),
                                    Padding(
                                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                      child: Container(
                                        height: 44.h,
                                        width: 362.w,
                                        decoration: BoxDecoration(
                                          color: controller.selectedOption.value == 0 ? Colorstheam.clusterwhite : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.selectedOption.value == 0 ? Colorstheam.clusterwhite : Colorstheam.nobelblack,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Pro Stylist Registration",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily: "DMSans",
                                                fontWeight: FontWeight.bold,
                                                color: controller.selectedOption.value == 0 ? Colorstheam.nobelblack : Colorstheam.nobelblack
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ),
                      SizedBox(height: screensize.height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Obx((){
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              controller.selectOption(1);
                              Get.offAllNamed(Routes.CREATEACCOUNT);
                            },
                            child:  Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 186.h,
                                width: 362.w,
                                decoration: BoxDecoration(
                                    color: controller.selectedOption.value == 1
                                        ? Colorstheam.nobelblack
                                        : Colorstheam.white,
                                    border: Border.all(color: Colorstheam.nobelblack)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: screensize.height * 0.015),
                                      child: Text(
                                        "No, I’m a Consumer",
                                        style: TextStyle(
                                            fontSize: 22.sp,
                                            fontFamily: "Urbanist",
                                            fontWeight: FontWeight.bold,
                                            color: controller.selectedOption.value == 1 ? Colorstheam.clusterwhite : Colorstheam.nobelblack
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screensize.height * 0.005),
                                    Padding(
                                      padding: EdgeInsets.only(left: screensize.width * 0.01,right: screensize.width * 0.01),
                                      child: Text(
                                        "Create a basic account to browse collections and purchase premium hair extensions.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "Urbanist",
                                            fontWeight: FontWeight.w500,
                                            color: controller.selectedOption.value == 1 ? Colorstheam.clusterwhite : Colorstheam.nobelblack
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screensize.height * 0.05),
                                    Padding(
                                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                      child: Container(
                                        height: 44.h,
                                        width: 362.w,
                                        decoration: BoxDecoration(
                                          color: controller.selectedOption.value == 1 ? Colorstheam.clusterwhite : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.selectedOption.value == 1 ? Colorstheam.clusterwhite : Colorstheam.nobelblack,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Create Your Account",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily: "DMSans",
                                                fontWeight: FontWeight.bold,
                                                color: controller.selectedOption.value == 1 ? Colorstheam.nobelblack : Colorstheam.nobelblack
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ),
                      SizedBox(height: screensize.height * 0.07),
                      Padding(
                        padding: EdgeInsets.only(top: 0,left: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Have an account?",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.nobelblack
                              ),
                              children: [
                                TextSpan(
                                  text: " Sign in",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colorstheam.nobelblack,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DMSans"
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAllNamed(Routes.LOGIN);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screensize.height * 0.03),
                    ],
                  ),
                ),
            )
        )
    );
  }

}
