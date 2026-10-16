// ignore_for_file: prefer_const_constructors_in_immutables

/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-06
/// - Build This Screen
/// ------------------------------------------------------------

import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Authentication/login/controller/logincontroller.dart';

class Loginview extends GetView<Logincontroller> {
  Loginview({super.key});
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
            body: SafeArea(
             child: Column(
               children: <Widget>[
                 Expanded(
                   child: Container(
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
                               Apptext.welcometext,
                               style: TextStyle(
                                   fontSize: 30.sp,
                                   fontFamily: "Urbanist",
                                   fontWeight: FontWeight.bold,
                                   color: Colorstheam.nobelblack
                               ),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(left: screensize.width * 0.04),
                             child: Text(
                               Apptext.subtitletext,
                               style: TextStyle(
                                   fontSize: 16.sp,
                                   fontFamily: "DMSans",
                                   fontWeight: FontWeight.w400,
                                   color: Colorstheam.nobelblack
                               ),
                             ),
                           ),
                           Form(
                             key: controller.formKey,
                             child: Column(
                               children: [
                                 Padding(
                                     padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.04),
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
                                   child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(8),
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colorstheam.black.withValues(alpha: 0.05),
                                             blurRadius: 6,
                                             offset: Offset(0, 2),
                                           ),
                                         ],
                                       ),
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
                                             controller: controller.inputController,
                                             onChanged: controller.onInputChanged,
                                             validator: controller.validateEmailField,
                                             cursorColor: Colorstheam.black,
                                             selectionControls: Textselect(),
                                             style: TextStyle(
                                                 fontSize: 14.sp,
                                                 fontWeight: FontWeight.w400,
                                                 fontFamily: "DMSans",
                                                 color: Colorstheam.black
                                             ),
                                             decoration: InputDecoration(
                                                 hintText: "Enter your email",
                                                 hintStyle: TextStyle(
                                                     fontSize: 14.sp,
                                                     fontWeight: FontWeight.w400,
                                                     fontFamily: "DMSans",
                                                     color: Colorstheam.lightgrey
                                                 ),
                                                 errorText: controller.emailError.value.isEmpty
                                                     ? null
                                                     : controller.emailError.value,
                                                 suffixIcon: controller.inputController.text.isEmpty
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
                                                   borderRadius: BorderRadius.zero,
                                                   borderSide: BorderSide(
                                                     color: controller.inputController.text.isEmpty
                                                         ? Colorstheam.Silver
                                                         : controller.isEmailValid.value
                                                         ? Colorstheam.green
                                                         : Colorstheam.Racingred,
                                                   ),
                                                 ),
                                                 focusedBorder: OutlineInputBorder(
                                                   borderRadius: BorderRadius.zero,
                                                   borderSide: BorderSide(
                                                     color: controller.isEmailValid.value
                                                         ? Colorstheam.green
                                                         : Colorstheam.black,
                                                   ),
                                                 ),
                                                 errorStyle: TextStyle(
                                                     fontSize: 14.sp,
                                                     fontWeight: FontWeight.w400,
                                                     fontFamily: "DMSans",
                                                     color: Colorstheam.Racingred
                                                 ),
                                                 errorBorder: OutlineInputBorder(
                                                   borderRadius: BorderRadius.zero,
                                                   borderSide: BorderSide(color: Colorstheam.Racingred),
                                                 ),
                                                 focusedErrorBorder: OutlineInputBorder(
                                                   borderRadius: BorderRadius.zero,
                                                   borderSide: BorderSide(color: Colorstheam.Racingred),
                                                 ),
                                                 filled: true,
                                                 fillColor: Colorstheam.white
                                             ),
                                           ),
                                         );
                                       })
                                   ),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01,right: screensize.width * 0.04),
                                   child: GestureDetector(
                                     onTap: (){
                                       HapticFeedback.lightImpact();
                                       Get.offAllNamed(Routes.FORGOTPASSWORD);
                                     },
                                     child: Align(
                                       alignment: Alignment.topRight,
                                       child: Text(
                                         "Forgot Password?",
                                         style: TextStyle(
                                           fontSize: 13.sp,
                                           fontFamily: "DMSans",
                                           fontWeight: FontWeight.w500,
                                           color: Colorstheam.nobelblack
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: screensize.height * 0.03,),
                                 Padding(
                                     padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                     child: Obx((){
                                       return AnimatedButton(
                                         onTap: () {
                                           if (controller.isLoading.value) return;
                                           HapticFeedback.lightImpact();
                                           controller.login();
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
                                                     "Sign In...",
                                                     style: TextStyle(
                                                         fontSize: 16.sp,
                                                         fontFamily: "Urbanist",
                                                         fontWeight: FontWeight.bold,
                                                         color: Colorstheam.white
                                                     ),
                                                   ),
                                                 ],
                                               )
                                                   : Text(
                                                 Apptext.login,
                                                 key: const ValueKey("login"),
                                                 style: TextStyle(
                                                     fontSize: 16.sp,
                                                     fontFamily: "Urbanist",
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
                                 SizedBox(height: screensize.height * 0.01),
                                 Padding(
                                   padding: EdgeInsets.symmetric(
                                     horizontal: screensize.width * 0.04,
                                     vertical: screensize.height * 0.02,
                                   ),
                                   child: Row(
                                     children: [
                                       Expanded(
                                         child: Divider(
                                           color: Colorstheam.lightgrey,
                                           thickness: 1,
                                         ),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.symmetric(horizontal: 12),
                                         child: Text(
                                           "Or Continue With",
                                           style: TextStyle(
                                               fontSize: 14.sp,
                                               fontFamily: "DMSans",
                                               fontWeight: FontWeight.w500,
                                               color: Colorstheam.nobelblack
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                         child: Divider(
                                           color: Colorstheam.lightgrey,
                                           thickness: 1,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: screensize.height * 0.01),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     Padding(
                                       padding: EdgeInsets.only(left: 0,right: 0),
                                       child: GestureDetector(
                                         onTap: () {
                                           HapticFeedback.lightImpact();
                                         },
                                         child: SvgPicture.asset(
                                           "asset/svg/google.svg",
                                           height: 48.h,
                                           width: 48.w,
                                         ),
                                       ),
                                     ),
                                     SizedBox(height: screensize.height * 0.01),
                                     Padding(
                                       padding: EdgeInsets.only(left: screensize.width * 0.015,right: 0),
                                       child: GestureDetector(
                                         onTap: () {
                                           HapticFeedback.lightImpact();
                                         },
                                         child: SvgPicture.asset(
                                           "asset/svg/apple.svg",
                                           height: 48.h,
                                           width: 48.w,
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.only(top: 0,left: 0),
                   child: Align(
                     alignment: Alignment.center,
                     child: RichText(
                       text: TextSpan(
                         text: "Don’t have an account?",
                         style: TextStyle(
                             fontSize: 16.sp,
                             fontWeight: FontWeight.w400,
                             fontFamily: "DMSans",
                             color: Colorstheam.black
                         ),
                         children: [
                           TextSpan(
                             text: " Sign up",
                             style: TextStyle(
                                 fontSize: 16.sp,
                                 color: Colorstheam.black,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "DMSans"
                             ),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 Get.offAllNamed(Routes.ACCOUNTOPTION);
                               },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             )
            )
        )
      )
    );
  }
}
