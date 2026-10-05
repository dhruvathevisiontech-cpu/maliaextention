// ignore_for_file: prefer_const_constructors_in_immutables

/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-06
/// - Build This Screen
/// ------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/apps/module/Authentication/resetpassword/controller/resetpasswordcontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Resetpasswordview extends GetView<Resetpasswordcontroller> {
  Resetpasswordview({super.key});
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
              Get.offAllNamed(Routes.LOGIN);
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
                        Get.offAllNamed(Routes.LOGIN);
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
                    padding: EdgeInsets.only(
                      bottom: 90.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: screensize.height * 0.03),
                        Padding(
                          padding: EdgeInsets.only(left: screensize.width * 0.04),
                          child: Text(
                            Apptext.resetpassword,
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
                            Apptext.resetsubtitle,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w400,
                                color: Colorstheam.black
                            ),
                          ),
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: screensize.height * 0.025),
                              Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child:  Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'New Password',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: screensize.width * 0.04,
                                  top: screensize.height * 0.01,
                                  right: screensize.width * 0.04,
                                ),
                                child: Obx(() {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      textSelectionTheme: TextSelectionThemeData(
                                        cursorColor: Colorstheam.black,
                                        selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                        selectionHandleColor: Colorstheam.black,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: controller.passwordcontroller,
                                      onChanged: controller.validatePasswordLive,
                                      validator: controller.validatePasswordField,
                                      cursorColor: Colorstheam.black,
                                      selectionControls: Textselect(),
                                      obscureText: !controller.isPasswordVisible.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter your password",
                                        hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.lightgrey,
                                        ),

                                        errorText: controller.passworderror.value.isEmpty
                                            ? null
                                            : controller.passworderror.value,

                                        suffixIcon: controller.passwordcontroller.text.isEmpty
                                            ? null
                                            : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              controller.isPasswordvalid.value
                                                  ? Icons.check_circle_outline
                                                  : Icons.error_outline,
                                              color: controller.isPasswordvalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.Racingred,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.isPasswordVisible.value =
                                                !controller.isPasswordVisible.value;
                                              },
                                              icon: Icon(
                                                controller.isPasswordVisible.value
                                                    ? Icons.visibility_outlined
                                                    : Icons.visibility_off_outlined,
                                                color: Colorstheam.black,
                                              ),
                                            ),
                                          ],
                                        ),

                                        prefixIconConstraints: const BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.passwordcontroller.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isPasswordvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isPasswordvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),

                                        errorStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.Racingred,
                                        ),

                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),

                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),

                                        filled: true,
                                        fillColor: Colorstheam.white,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: screensize.height * 0.025),
                              Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child:  Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Confirm Password',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: screensize.width * 0.04,
                                  top: screensize.height * 0.01,
                                  right: screensize.width * 0.04,
                                ),
                                child: Obx(() {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      textSelectionTheme: TextSelectionThemeData(
                                        cursorColor: Colorstheam.black,
                                        selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                        selectionHandleColor: Colorstheam.black,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: controller.confirmpasswordcontroller,
                                      onChanged: controller.validateConfirmPasswordLive,
                                      validator: controller.validateConfirmPasswordField,
                                      cursorColor: Colorstheam.black,
                                      selectionControls: Textselect(),
                                      obscureText: !controller.isConfirmPasswordVisible.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter your confirm password",
                                        hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.lightgrey,
                                        ),

                                        errorText: controller.confirmpassworderror.value.isEmpty
                                            ? null
                                            : controller.confirmpassworderror.value,

                                        suffixIcon: controller.confirmpasswordcontroller.text.isEmpty
                                            ? null
                                            : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              controller.isConfirmPasswordValid.value
                                                  ? Icons.check_circle_outline
                                                  : Icons.error_outline,
                                              color: controller.isConfirmPasswordValid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.Racingred,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.isConfirmPasswordVisible.value =
                                                !controller.isConfirmPasswordVisible.value;
                                              },
                                              icon: Icon(
                                                controller.isConfirmPasswordVisible.value
                                                    ? Icons.visibility_outlined
                                                    : Icons.visibility_off_outlined,
                                                color: Colorstheam.black,
                                              ),
                                            ),
                                          ],
                                        ),

                                        prefixIconConstraints: const BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.confirmpasswordcontroller.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isConfirmPasswordValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isConfirmPasswordValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),

                                        errorStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.Racingred,
                                        ),

                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),

                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),

                                        filled: true,
                                        fillColor: Colorstheam.white,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: screensize.height * 0.035),
                              Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                  child: Obx((){
                                    return AnimatedButton(
                                      onTap: () {
                                        if (controller.isLoading.value) return;
                                        HapticFeedback.lightImpact();
                                        if (!(controller.formKey.currentState?.validate() ?? false)) {
                                          return;
                                        }

                                        if (!controller.isPasswordvalid.value) {
                                          return;
                                        }

                                        if (!controller.isConfirmPasswordValid.value) {
                                          return;
                                        }
                                        Get.dialog(
                                          Dialog(
                                            backgroundColor: Colorstheam.white,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            insetPadding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                            child: Container(
                                              width: 362.w,
                                              height: 290.h,
                                              child: Padding(
                                                padding: EdgeInsets.all(20.w),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "asset/svg/checkbox.svg",
                                                         height: 40.h,
                                                         width: 40.w,
                                                         color: Colorstheam.green,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Text(
                                                      "Password Changed!",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 32.sp,
                                                        fontFamily: "Urbanist",
                                                        fontWeight: FontWeight.bold,
                                                        color: Colorstheam.nobelblack,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6.h),
                                                    Text(
                                                      "Your password has been updated successfully. You can now use your new password to sign in to your account.",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontFamily: "DMSans",
                                                        fontWeight: FontWeight.w500,
                                                        color: Colorstheam.nobelblack,
                                                      ),
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Get.offAllNamed(Routes.LOGIN);
                                                      },
                                                      child: Container(
                                                        height: 44.h,
                                                        width: 322.w,
                                                        decoration: BoxDecoration(
                                                          color: Colorstheam.nobelblack
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "Login",
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontFamily: "DMSans",
                                                              fontWeight: FontWeight.bold,
                                                              color: Colorstheam.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 44.h,
                                        decoration: BoxDecoration(
                                          color: Colorstheam.black,
                                        ),
                                        child: Center(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(milliseconds: 250),
                                            child: controller.isLoading.value
                                                ? Row(
                                              key: const ValueKey("loading"),
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  "Continue...",
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
                                              "Continue",
                                              key: const ValueKey("Continue"),
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
                                    );
                                  })
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            )
        )
    );
  }
}
