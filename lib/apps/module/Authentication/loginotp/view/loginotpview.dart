import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Authentication/loginotp/controller/loginotpcontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:pinput/pinput.dart';

class Loginotpview extends GetView<Loginotpcontroller> {
  Loginotpview({super.key});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
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
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
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
                        "asset/svg/arrowleft.svg", // Replace with your right icon
                        width: 10.w,
                        height: 10.h,
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
                        Apptext.loginotptitle,
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
                              fontWeight: FontWeight.w400,
                              fontFamily: "DMSans",
                              color: Colorstheam.black
                          ),
                          children: [
                            TextSpan(
                              text: " (${controller.email})",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colorstheam.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DMSans"
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
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
                            color: Colorstheam.white,
                            border: Border.all(
                              color: Colorstheam.Silver,
                            ),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 44.w,
                          height: 44.h,
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DMSans",
                            color: Colorstheam.nobelblack,
                          ),
                          decoration: BoxDecoration(
                            color: Colorstheam.white,
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
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DMSans",
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
                          padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.015),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Email not received?",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w400,
                                    color: Colorstheam.black,
                                  ),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          " Resend Code",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w600,
                                            color: Colorstheam.black,
                                          ),
                                        ),
                                        Container(
                                          height: 1.5.h,
                                          width: 100.w,
                                          color: Colorstheam.black,
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
                                  color: Colorstheam.black,
                                ),
                              )
                          )
                      );
                    }),
                    Obx(() => Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.03),
                      child: AnimatedButton(
                        onTap: () {
                          if (controller.isLoading.value) return;
                          HapticFeedback.lightImpact();
                          controller.verifyOtp;
                        },
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
                                    "Verify Code...",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.white
                                    ),
                                  ),
                                ],
                              )
                                  : Text(
                                "Verify Code",
                                key: const ValueKey("Verify"),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.white
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
        )
    );
  }
}