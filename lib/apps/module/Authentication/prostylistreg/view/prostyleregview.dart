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
import 'package:dotted_border/dotted_border.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/utils/ustextformate.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Authentication/prostylistreg/controller/prostyleregcontroller.dart';

class Prostyleregview extends GetView<Prostyleregcontroller> {
  Prostyleregview({super.key});
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
                          Apptext.prostylistreg,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text(
                          Apptext.prosubtitle,
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
                          children: [
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
                                    controller: controller.firstnamecontroller,
                                    onChanged: controller.validateFirstnameLive,
                                    validator: controller.validateFirstnameField,
                                    cursorColor: Colorstheam.black,
                                    selectionControls: Textselect(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black
                                    ),
                                    decoration: InputDecoration(
                                        errorText: controller.firstnameerror.value.isEmpty
                                            ? null
                                            : controller.firstnameerror.value,
                                        suffixIcon: controller.firstnamecontroller.text.isEmpty
                                            ? null
                                            : Icon(
                                          controller.isFirstnamevalid.value
                                              ? Icons.check_circle_outline
                                              : Icons.error_outline,
                                          color: controller.isFirstnamevalid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          minWidth: 0,
                                          minHeight: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.firstnamecontroller.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isFirstnamevalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.isFirstnamevalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
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
                                            color: Colorstheam.nobelblack,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colorstheam.nobelblack,
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
                                      controller: controller.lastnamecontroller,
                                      onChanged: controller.validatelastnameLive,
                                      validator: controller.validateLastnameField,
                                      cursorColor: Colorstheam.black,
                                      selectionControls: Textselect(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.black
                                      ),
                                      decoration: InputDecoration(
                                          errorText: controller.lastnameerror.value.isEmpty
                                              ? null
                                              : controller.lastnameerror.value,
                                          suffixIcon: controller.lastnamecontroller.text.isEmpty
                                              ? null
                                              : Icon(
                                            controller.isLastnamevalid.value
                                                ? Icons.check_circle_outline
                                                : Icons.error_outline,
                                            color: controller.isLastnamevalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 0,
                                            minHeight: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.lastnamecontroller.text.isEmpty
                                                  ? Colorstheam.clusterwhite
                                                  : controller.isLastnamevalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.Racingred,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.isLastnamevalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.black,
                                            ),
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
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
                                      controller: controller.emailcontroller,
                                      onChanged: controller.validateemailLive,
                                      validator: controller.validateemailField,
                                      cursorColor: Colorstheam.black,
                                      selectionControls: Textselect(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
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
                                          errorText: controller.emailerror.value.isEmpty
                                              ? null
                                              : controller.emailerror.value,
                                          suffixIcon: controller.emailcontroller.text.isEmpty
                                              ? null
                                              : Icon(
                                            controller.isemailvalid.value
                                                ? Icons.check_circle_outline
                                                : Icons.error_outline,
                                            color: controller.isemailvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 0,
                                            minHeight: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.emailcontroller.text.isEmpty
                                                  ? Colorstheam.clusterwhite
                                                  : controller.isemailvalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.Racingred,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.isemailvalid.value
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
                                          text: 'Phone Number',
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
                                    controller: controller.phonecontroller,
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

                                      errorText: controller.phoneerror.value.isEmpty
                                          ? null
                                          : controller.phoneerror.value,

                                      suffixIcon: controller.phonecontroller.text.isEmpty
                                          ? null
                                          : Icon(
                                        controller.isphonevalid.value
                                            ? Icons.check_circle_outline
                                            : Icons.error_outline,
                                        color: controller.isphonevalid.value
                                            ? Colorstheam.green
                                            : Colorstheam.Racingred,
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: controller.phonecontroller.text.isEmpty
                                              ? Colorstheam.clusterwhite
                                              : controller.isphonevalid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: controller.isphonevalid.value
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
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child:  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Address',
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: controller.addresscontroller,
                                      onChanged: controller.onAddressChanged,
                                      validator: controller.validateaddressField,
                                      cursorColor: Colorstheam.black,
                                      keyboardType: TextInputType.streetAddress,
                                      textCapitalization: TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      selectionControls: Textselect(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter your address",
                                        hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.lightgrey,
                                        ),
                                        errorText: controller.addresserror.value.isEmpty
                                            ? null
                                            : controller.addresserror.value,
                                        suffixIcon: controller.addresscontroller.text.isEmpty
                                            ? null
                                            : Icon(
                                          controller.isaddressvalid.value
                                              ? Icons.check_circle_outline
                                              : Icons.error_outline,
                                          color: controller.isaddressvalid.value
                                              ? Colorstheam.green
                                              : Colorstheam.Racingred,
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.Racingred,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: controller.addresscontroller.text.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : controller.isaddressvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: controller.isaddressvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.black,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),

                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide(
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colorstheam.white,
                                      ),
                                    ),
                                    if (controller.addressSuggestions.isNotEmpty)
                                      Container(
                                        margin: EdgeInsets.only(top: 4.h),
                                        decoration: BoxDecoration(
                                          color: Colorstheam.white,
                                          borderRadius: BorderRadius.circular(7),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.08),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: controller.addressSuggestions.length,
                                          itemBuilder: (context, index) {
                                            final suggestion =
                                            controller.addressSuggestions[index];
                                            return InkWell(
                                              onTap: () {
                                                controller.selectAddress(suggestion);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 14.w,
                                                  vertical: 12.h,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_outlined,
                                                      size: 20.sp,
                                                      color: Colorstheam.black,
                                                    ),

                                                    SizedBox(width: 10.w),

                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            suggestion.address,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontFamily: "Urbanist",
                                                              fontWeight: FontWeight.w600,
                                                              color: Colorstheam.black,
                                                            ),
                                                          ),

                                                          SizedBox(height: 3.h),

                                                          Text(
                                                            "${suggestion.city}, "
                                                                "${suggestion.state} "
                                                                "${suggestion.zipCode}",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontFamily: "Urbanist",
                                                              fontWeight: FontWeight.w400,
                                                              color: Colorstheam.lightgrey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
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
                                          text: 'City',
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
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    cursorColor: Colorstheam.black,
                                    selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                    selectionHandleColor: Colorstheam.black,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: controller.citycontroller,

                                  // City is filled automatically from selected address.
                                  readOnly: true,

                                  cursorColor: Colorstheam.black,

                                  selectionControls: Textselect(),

                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "DMSans",
                                    color: Colorstheam.black,
                                  ),

                                  decoration: InputDecoration(
                                    hintText: "City",

                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w500,
                                      color: Colorstheam.lightgrey,
                                    ),

                                    suffixIcon: controller.citycontroller.text.isEmpty
                                        ? null
                                        : Icon(
                                      Icons.check_circle_outline,
                                      color: Colorstheam.green,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.Racingred,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: controller.citycontroller.text.isEmpty
                                            ? Colorstheam.clusterwhite
                                            : Colorstheam.green,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.green,
                                      ),
                                    ),

                                    filled: true,
                                    fillColor: Colorstheam.white,
                                  ),
                                ),
                              )
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
                                          text: 'State',
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
                                // =====================================================
                                // STATES DROPDOWN
                                // =====================================================

                                if (controller.isStateDropdown.value) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // -------------------------------------------------
                                      // SELECT STATE BUTTON
                                      // -------------------------------------------------

                                      InkWell(
                                        onTap: () {
                                          controller.isStateMenuOpen.toggle();
                                        },
                                        borderRadius: BorderRadius.circular(7),
                                        child: Container(
                                          height: 55.h,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: controller.selectedState.value.isEmpty
                                                  ? Colorstheam.clusterwhite
                                                  : Colorstheam.green,
                                            ),
                                          ),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                child: Text(
                                                  controller.selectedState.value.isEmpty
                                                      ? "Select ${controller.stateFieldTitle.value}"
                                                      : controller.selectedState.value,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "DMSans",
                                                    color: controller.selectedState.value.isEmpty
                                                        ? Colorstheam.lightgrey
                                                        : Colorstheam.black,
                                                  ),
                                                ),
                                              ),

                                              AnimatedRotation(
                                                turns: controller.isStateMenuOpen.value
                                                    ? 0.5
                                                    : 0,
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                child: Icon(
                                                  Icons.keyboard_arrow_down_rounded,
                                                  color: Colorstheam.black,
                                                  size: 24.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // -------------------------------------------------
                                      // STATE LIST
                                      // -------------------------------------------------

                                      if (controller.isStateMenuOpen.value)
                                        Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            maxHeight: 300.h,
                                          ),
                                          margin: EdgeInsets.only(
                                            top: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: Colorstheam.clusterwhite,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.08,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount: controller.states.length,
                                            itemBuilder: (context, index) {

                                              final state = controller.states[index];

                                              final bool isSelected =
                                                  controller.selectedState.value == state;

                                              return InkWell(
                                                onTap: () {
                                                  controller.selectState(state);

                                                  // Close menu
                                                  controller.isStateMenuOpen.value = false;
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 14.w,
                                                    vertical: 14.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colorstheam.clusterwhite
                                                        : Colorstheam.white,
                                                  ),
                                                  child: Text(
                                                    state,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                }

                                // =====================================================
                                // OTHER COUNTRIES
                                // =====================================================

                                return TextFormField(
                                  controller: controller.statecontroller,

                                  onChanged: (value) {
                                    controller.selectedState.value = value;
                                  },
                                  selectionControls: Textselect(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "DMSans",
                                    color: Colorstheam.black,
                                  ),

                                  decoration: InputDecoration(
                                    hintText:
                                    "Enter ${controller.stateFieldTitle.value}",

                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.lightgrey,
                                    ),

                                    filled: true,
                                    fillColor: Colorstheam.white,

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: controller.statecontroller.text.isEmpty
                                            ? Colorstheam.clusterwhite
                                            : Colorstheam.green,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.black,
                                      ),
                                    ),
                                  ),

                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "${controller.stateFieldTitle.value} is required";
                                    }

                                    return null;
                                  },
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
                                          text: 'Zip Code',
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
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    cursorColor: Colorstheam.black,
                                    selectionColor: Colorstheam.black.withValues(alpha: 0.3),
                                    selectionHandleColor: Colorstheam.black,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: controller.zipcodecontroller,

                                  keyboardType: TextInputType.number,

                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5),
                                  ],

                                  cursorColor: Colorstheam.black,

                                  selectionControls: Textselect(),

                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "DMSans",
                                    color: Colorstheam.black,
                                  ),

                                  decoration: InputDecoration(
                                    hintText: "ZIP Code",

                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w500,
                                      color: Colorstheam.lightgrey,
                                    ),

                                    suffixIcon: controller.zipcodecontroller.text.isEmpty
                                        ? null
                                        : Icon(
                                      Icons.check_circle_outline,
                                      color: Colorstheam.green,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: controller.zipcodecontroller.text.isEmpty
                                            ? Colorstheam.clusterwhite
                                            : Colorstheam.green,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.black,
                                      ),
                                    ),

                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.Racingred,
                                      ),
                                    ),

                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.Racingred,
                                      ),
                                    ),

                                    errorStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.Racingred,
                                    ),

                                    filled: true,
                                    fillColor: Colorstheam.white,
                                  ),

                                  validator: controller.validateZipcodeField,
                                ),
                              )
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
                                          text: 'Country',
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // =====================================================
                                    // COUNTRY SELECT BUTTON
                                    // =====================================================

                                    InkWell(
                                      onTap: () {
                                        controller.isCountryMenuOpen.toggle();
                                      },
                                      borderRadius: BorderRadius.circular(7),
                                      child: Container(
                                        height: 55.h,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colorstheam.white,
                                          borderRadius: BorderRadius.circular(7),
                                          border: Border.all(
                                            color: controller.selectedCountry.value.isEmpty
                                                ? Colorstheam.clusterwhite
                                                : Colorstheam.green,
                                          ),
                                        ),
                                        child: Row(
                                          children: [

                                            // Country name
                                            Expanded(
                                              child: Text(
                                                controller.selectedCountry.value.isEmpty
                                                    ? "Select Country"
                                                    : controller.selectedCountry.value,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "DMSans",
                                                  color: controller.selectedCountry.value.isEmpty
                                                      ? Colorstheam.lightgrey
                                                      : Colorstheam.black,
                                                ),
                                              ),
                                            ),

                                            // Arrow
                                            AnimatedRotation(
                                              turns: controller.isCountryMenuOpen.value
                                                  ? 0.5
                                                  : 0,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              child: Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: Colorstheam.black,
                                                size: 24.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // =====================================================
                                    // COUNTRY LIST
                                    // =====================================================

                                    if (controller.isCountryMenuOpen.value)
                                      Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxHeight: 300.h,
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colorstheam.white,
                                          borderRadius: BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Colorstheam.clusterwhite,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.08,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: controller.countryList.length,
                                          itemBuilder: (context, index) {

                                            final country =
                                            controller.countryList[index];

                                            final bool isSelected =
                                                controller.selectedCountry.value ==
                                                    country;

                                            return InkWell(
                                              onTap: () {
                                                // Select country
                                                controller.selectCountry(country);

                                                // Close dropdown
                                                controller.isCountryMenuOpen.value = false;
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 14.w,
                                                  vertical: 14.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colorstheam.clusterwhite
                                                      : Colorstheam.white,
                                                ),
                                                child: Text(
                                                  country,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
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
                                          text: 'Cosmetology License Number',
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
                                      controller: controller.cosmetologylicensenumbercontroller,
                                      onChanged: controller.validatecosmetologyLive,
                                      validator: controller.validateCosmetologyField,
                                      cursorColor: Colorstheam.black,
                                      selectionControls: Textselect(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.black
                                      ),
                                      decoration: InputDecoration(
                                          errorText: controller.cosmetologyerror.value.isEmpty
                                              ? null
                                              : controller.cosmetologyerror.value,
                                          suffixIcon: controller.cosmetologylicensenumbercontroller.text.isEmpty
                                              ? null
                                              : Icon(
                                            controller.iscosmetologyvalid.value
                                                ? Icons.check_circle_outline
                                                : Icons.error_outline,
                                            color: controller.iscosmetologyvalid.value
                                                ? Colorstheam.green
                                                : Colorstheam.Racingred,
                                          ),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 0,
                                            minHeight: 0,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.cosmetologylicensenumbercontroller.text.isEmpty
                                                  ? Colorstheam.clusterwhite
                                                  : controller.iscosmetologyvalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.Racingred,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: controller.iscosmetologyvalid.value
                                                  ? Colorstheam.green
                                                  : Colorstheam.black,
                                            ),
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
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
                                          text: 'State',
                                          style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colorstheam.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
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
                                // =====================================================
                                // STATES DROPDOWN
                                // =====================================================

                                if (controller.isStateDropdown.value) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // -------------------------------------------------
                                      // SELECT STATE BUTTON
                                      // -------------------------------------------------

                                      InkWell(
                                        onTap: () {
                                          controller.isStateMenuOpen.toggle();
                                        },
                                        borderRadius: BorderRadius.circular(7),
                                        child: Container(
                                          height: 55.h,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: controller.selectedState.value.isEmpty
                                                  ? Colorstheam.clusterwhite
                                                  : Colorstheam.green,
                                            ),
                                          ),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                child: Text(
                                                  controller.selectedState.value.isEmpty
                                                      ? "Select ${controller.stateFieldTitle.value}"
                                                      : controller.selectedState.value,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "DMSans",
                                                    color: controller.selectedState.value.isEmpty
                                                        ? Colorstheam.lightgrey
                                                        : Colorstheam.black,
                                                  ),
                                                ),
                                              ),

                                              AnimatedRotation(
                                                turns: controller.isStateMenuOpen.value
                                                    ? 0.5
                                                    : 0,
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                child: Icon(
                                                  Icons.keyboard_arrow_down_rounded,
                                                  color: Colorstheam.black,
                                                  size: 24.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // -------------------------------------------------
                                      // STATE LIST
                                      // -------------------------------------------------

                                      if (controller.isStateMenuOpen.value)
                                        Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            maxHeight: 300.h,
                                          ),
                                          margin: EdgeInsets.only(
                                            top: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: Colorstheam.clusterwhite,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.08,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount: controller.states.length,
                                            itemBuilder: (context, index) {

                                              final state = controller.states[index];

                                              final bool isSelected =
                                                  controller.selectedState.value == state;

                                              return InkWell(
                                                onTap: () {
                                                  controller.selectState(state);

                                                  // Close menu
                                                  controller.isStateMenuOpen.value = false;
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 14.w,
                                                    vertical: 14.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colorstheam.clusterwhite
                                                        : Colorstheam.white,
                                                  ),
                                                  child: Text(
                                                    state,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                }

                                // =====================================================
                                // OTHER COUNTRIES
                                // =====================================================

                                return TextFormField(
                                  controller: controller.statecontroller,

                                  onChanged: (value) {
                                    controller.selectedState.value = value;
                                  },
                                  selectionControls: Textselect(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colorstheam.black,
                                  ),

                                  decoration: InputDecoration(
                                    hintText:
                                    "Enter ${controller.stateFieldTitle.value}",

                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.lightgrey,
                                    ),

                                    filled: true,
                                    fillColor: Colorstheam.white,

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: controller.statecontroller.text.isEmpty
                                            ? Colorstheam.clusterwhite
                                            : Colorstheam.green,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colorstheam.black,
                                      ),
                                    ),
                                  ),

                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "${controller.stateFieldTitle.value} is required";
                                    }

                                    return null;
                                  },
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
                                          text: 'Upload Cosmetology License',
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
                                final file = controller.cosmetologyLicenseFile.value;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: controller.pickCosmetologyLicense,
                                      child: DottedBorder(
                                        options: RectDottedBorderOptions(
                                          // borderType: BorderType.RRect,
                                          // radius: Radius.circular(8),
                                          color: controller.cosmetologyLicenseError.value.isEmpty
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.Racingred,
                                          strokeWidth: 1.5,
                                          dashPattern: const [6, 4],
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 28.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                  "asset/svg/arrowshape.svg",
                                                  height: screensize.height * 0.035,
                                                  width: screensize.width * 0.035,
                                              ),
                                              SizedBox(height: 12.h),
                                              Text(
                                                file == null
                                                    ? "Drag and drop your license image here,\nor click to browse"
                                                    : file.path!.split('/').last,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.black,
                                                ),
                                              ),

                                              SizedBox(height: 8.h),

                                              Text(
                                                "JPG, PNG or PDF — Max 10 MB",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.lightgrey,
                                                ),
                                              ),

                                              SizedBox(height: 16.h),

                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colorstheam.black,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  file == null
                                                      ? "Browse Files"
                                                      : "Change File",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    if (controller.cosmetologyLicenseError.value.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 6.h,
                                          left: 4.w,
                                        ),
                                        child: Text(
                                          controller.cosmetologyLicenseError.value,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "DMSans",
                                            color: Colorstheam.Racingred,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              })
                            ),
                            SizedBox(height: screensize.height * 0.025),
                            Padding(
                              padding: EdgeInsets.only(
                                left: screensize.width * 0.04,
                                top: screensize.height * 0.01,
                                right: screensize.width * 0.04,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colorstheam.clusterwhite,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: screensize.width * 0.04,
                                    top: screensize.height * 0.01,
                                    right: screensize.width * 0.04,
                                    bottom: screensize.height * 0.01
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        size: 18.sp,
                                        color: Colorstheam.nobelblack,
                                      ),
                                      SizedBox(width: screensize.width * 0.02),
                                      Expanded(
                                        child: Text(
                                          "We verify all accounts manually — approval usually happens within 24 hours.",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w400,
                                            color: Colorstheam.nobelblack,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            SizedBox(height: screensize.height * 0.035),
                            Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                                child: Obx((){
                                  return AnimatedButton(
                                    onTap: () {
                                      if (controller.isLoading.value) return;
                                      HapticFeedback.lightImpact();
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
                                                "Submit Application...",
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
                                            Apptext.submit,
                                            key: const ValueKey("submit"),
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
                            SizedBox(height: screensize.height * 0.035),
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
                            SizedBox(height: screensize.height * 0.035),
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
