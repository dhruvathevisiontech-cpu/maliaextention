import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/apps/module/Authentication/createaccount/controller/createaccountcontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/utils/ustextformate.dart';

class Createaccountview extends GetView<Createaccountcontroller> {
  Createaccountview({super.key});

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
            Get.offAllNamed(Routes.ACCOUNTOPTION);
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
                      Get.offAllNamed(Routes.ACCOUNTOPTION);
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
                          Apptext.createaccount,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack
                          ),
                        ),
                      ),
                      SizedBox(height: screensize.height * 0.01),
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
                                          text: 'First Name',
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
                                padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01,right: screensize.width * 0.04),
                              child: Obx((){
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      cursorColor: Colorstheam.black,
                                      selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                      selectionHandleColor: Colorstheam.black,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: controller.firstNameController,
                                    onChanged: controller.validateFirstNameLive,
                                    validator: controller.validateFirstName,
                                    cursorColor: Colorstheam.black,
                                    selectionControls: Textselect(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black
                                    ),
                                    decoration: InputDecoration(
                                        errorText: controller.firstNameError.value.isEmpty
                                            ? null
                                            : controller.firstNameError.value,
                                        suffixIcon: controller.firstNameController.text.isEmpty
                                            ? null
                                            : Icon(
                                          controller.isFirstNameValid.value
                                              ? Icons.check_circle_outline
                                              : Icons.error_outline,
                                          color: controller.isFirstNameValid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.firstNameController.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isFirstNameValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isFirstNameValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "DMSans",
                                            color: Colorstheam.Racingred
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        filled: true,
                                        fillColor: Colorstheam.white
                                    ),
                                  ),
                                );
                              })
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
                                          text: 'Last Name',
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
                              padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01,right: screensize.width * 0.04),
                              child: Obx((){
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      cursorColor: Colorstheam.black,
                                      selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                      selectionHandleColor: Colorstheam.black,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: controller.lastNameController,
                                    onChanged: controller.validateLastNameLive,
                                    validator: controller.validateLastName,
                                    cursorColor: Colorstheam.black,
                                    selectionControls: Textselect(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black
                                    ),
                                    decoration: InputDecoration(
                                        errorText: controller.lastNameError.value.isEmpty
                                            ? null
                                            : controller.lastNameError.value,
                                        suffixIcon: controller.lastNameController.text.isEmpty
                                            ? null
                                            : Icon(
                                          controller.isLastNameValid.value
                                              ? Icons.check_circle_outline
                                              : Icons.error_outline,
                                          color: controller.isLastNameValid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.lastNameController.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isLastNameValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isLastNameValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "DMSans",
                                            color: Colorstheam.Racingred
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        filled: true,
                                        fillColor: Colorstheam.white
                                    ),
                                  ),
                                );
                              })
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
                                          text: 'Email',
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
                              padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01,right: screensize.width * 0.04),
                              child: Obx((){
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                      cursorColor: Colorstheam.black,
                                      selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                      selectionHandleColor: Colorstheam.black,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    onChanged: controller.validateEmailLive,
                                    validator: controller.validateEmail,
                                    cursorColor: Colorstheam.black,
                                    selectionControls: Textselect(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Enter your email",
                                        hintStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w500,
                                            color: Colorstheam.lightgrey

                                        ),
                                        errorText: controller.emailError.value.isEmpty
                                            ? null
                                            : controller.emailError.value,
                                        suffixIcon: controller.emailController.text.isEmpty
                                            ? null
                                            : Icon(
                                          controller.isEmailValid.value
                                              ? Icons.check_circle_outline
                                              : Icons.error_outline,
                                          color: controller.isEmailValid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.emailController.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isEmailValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isEmailValid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "DMSans",
                                            color: Colorstheam.Racingred
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colorstheam.Racingred),
                                        ),
                                        filled: true,
                                        fillColor: Colorstheam.white
                                    ),
                                  ),
                                );
                              })
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
                                          text: 'Phone',
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
                                    controller: controller.phoneController,
                                    onChanged: controller.validatephoneLive,
                                    validator: controller.validatephoneField,
                                    cursorColor: Colorstheam.black,
                                    selectionControls: Textselect(),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      USPhoneNumberFormatter(),
                                    ],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "(123) 456-7890",

                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.lightgrey,
                                      ),

                                      errorText: controller.phoneError.value.isEmpty
                                          ? null
                                          : controller.phoneError.value,

                                      suffixIcon: controller.phoneController.text.isEmpty
                                          ? null
                                          : Icon(
                                        controller.isPhoneValid.value
                                            ? Icons.check_circle_outline
                                            : Icons.error_outline,
                                        color: controller.isPhoneValid.value
                                            ? Colorstheam.green
                                            : Colorstheam.Racingred,
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: controller.phoneController.text.isEmpty
                                              ? Colorstheam.clusterwhite
                                              : controller.isPhoneValid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: controller.isPhoneValid.value
                                              ? Colorstheam.green
                                              : Colorstheam.black,
                                        ),
                                      ),

                                      errorStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
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
                              padding: EdgeInsets.only(
                                left: screensize.width * 0.04,
                                top: screensize.height * 0.01,
                                right: screensize.width * 0.04,
                              ),
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    controller.isAccepted.toggle();
                                  },
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        width: 22.w,
                                        height: 22.w,
                                        decoration: BoxDecoration(
                                          color: controller.isAccepted.value
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.clusterwhite,
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: controller.isAccepted.value ? Colorstheam.nobelblack : Colorstheam.clusterwhite,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: controller.isAccepted.value
                                            ? Icon(
                                          Icons.check,
                                          size: 16.sp,
                                          color: Colorstheam.clusterwhite,
                                        )
                                            : null,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          "I agree to receive SMS marketing messages. Message and data rates may apply.",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w400,
                                            color: Colorstheam.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: screensize.height * 0.001),
                            Padding(
                              padding: EdgeInsets.only(
                                left: screensize.width * 0.04,
                                top: screensize.height * 0.01,
                                right: screensize.width * 0.04,
                              ),
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    controller.isAccepted1.toggle();
                                  },
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        width: 22.w,
                                        height: 22.w,
                                        decoration: BoxDecoration(
                                          color: controller.isAccepted1.value
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.clusterwhite,
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: controller.isAccepted1.value ? Colorstheam.nobelblack : Colorstheam.clusterwhite,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: controller.isAccepted1.value
                                            ? Icon(
                                          Icons.check,
                                          size: 16.sp,
                                          color: Colorstheam.clusterwhite,
                                        )
                                            : null,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          "I agree to receive email marketing communications.",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w400,
                                            color: Colorstheam.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: screensize.height * 0.025),
                            Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                child: Obx((){
                                  return AnimatedButton(
                                    onTap: () {
                                      if (controller.isLoading.value) return;
                                      HapticFeedback.lightImpact();
                                      controller.createAccount();
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
                                                "Signup...",
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
                                            "Create Account",
                                            key: const ValueKey("signup"),
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
                            SizedBox(height: screensize.height * 0.025),
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
                                        color: Colorstheam.black
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " Sign in",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colorstheam.black,
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
                            SizedBox(height: screensize.height * 0.015),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}