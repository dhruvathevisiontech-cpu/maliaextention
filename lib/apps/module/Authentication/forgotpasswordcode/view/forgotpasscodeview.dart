/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-08
/// - Build This screen
/// ------------------------------------------------------------

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpassword/controller/forgotpasswordcontroller.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpasswordcode/controller/forgotpasscodecontroller.dart';

class Forgotpasscodeview extends GetView<Forgotpasscodecontroller> {
  Forgotpasscodeview({super.key});
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
            final forgotPasswordController = Get.find<Forgotpasswordcontroller>();
            forgotPasswordController.inputController.clear();
            forgotPasswordController.emailError.value = "";
            forgotPasswordController.isEmailValid.value = false;
            Get.back();
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
                      final forgotPasswordController = Get.find<Forgotpasswordcontroller>();
                      forgotPasswordController.inputController.clear();
                      forgotPasswordController.emailError.value = "";
                      forgotPasswordController.isEmailValid.value = false;
                      Get.back();
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screensize.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          Apptext.forgotpasswordcode,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: RichText(
                          text: TextSpan(
                            text: "Enter 6 digit code that you receive on your email",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack
                            ),
                            children: [
                              TextSpan(
                                text: " (${controller.email})",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colorstheam.nobelblack,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DMSans"
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                        child: Pinput(
                          controller: controller.otpController,
                          focusNode: controller.otpFocusNode,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          defaultPinTheme: PinTheme(
                            width: 44.w,
                            height: 44.h,
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "DMSans",
                              color: Colorstheam.nobelblack,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colorstheam.Silver,
                              ),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 44.w,
                            height: 44.h,
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.black,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colorstheam.nobelblack,
                                width: 2,
                              ),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 44.w,
                            height: 44.h,
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                          ),
                          length: 6,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          onCompleted: (_) {
                            controller.verifyOtp();
                          },
                        ),
                      ),
                      Obx(() {
                        return controller.canResend.value
                            ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Email not received?",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w400,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: GestureDetector(
                                        onTap: () {
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              " Resend Code",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily: "DMSans",
                                                fontWeight: FontWeight.w600,
                                                color: Colorstheam.nobelblack,
                                              ),
                                            ),
                                            Container(
                                              height: 1.5.h,
                                              width: 100.w,
                                              color: Colorstheam.nobelblack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        )
                            : Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01),
                                child: Text(
                                  "Resend code in ${controller.seconds.value}s",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w400,
                                    color: Colorstheam.nobelblack,
                                  ),
                                )
                            )
                        );
                      }),
                      Obx(() => AnimatedButton(
                        onTap: () {
                          if (controller.isLoading.value) return;
                          HapticFeedback.lightImpact();
                          controller.verifyOtp;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: screensize.height * 0.05,left: screensize.width * 0.04,right: screensize.width * 0.04),
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                              color: Colorstheam.nobelblack,
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: controller.isLoading.value
                                    ? Row(
                                  key: const ValueKey("loading"),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 18.w,
                                      height: 18.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      "Confirm...",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.bold,
                                        color: Colorstheam.clusterwhite
                                      ),
                                    ),
                                  ],
                                )
                                    : Text(
                                  "Confirm",
                                  key: const ValueKey("Confirm"),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.clusterwhite
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}