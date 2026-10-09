// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/controller/hostclasscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Hostclassview extends GetView<Hostclasscontroller> {
  const Hostclassview({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final bottomNav = Get.find<Bottomnavigationcontroller>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colorstheam.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              width: double.infinity,
              color: Colorstheam.clusterwhite,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: screensize.width * 0.02),
                Text(
                  "Host A Class",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screensize.height * 0.01),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    "Want to host a class in your city?",
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    "We partner with select salons to host Butterfly Method education experiences across the country. These classes are designed for stylists who value elevated education, intentional growth, and modern extension techniques that prioritize efficiency, comfort, and results.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Image.asset(
                  "asset/image/image03.png",
                   height: 362.h,
                  width: 362.w,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screensize.height * 0.015),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.fullname,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: TextFormField(
                        controller: controller.nameController,
                        cursorColor: Colorstheam.nobelblack,
                        cursorErrorColor: Colorstheam.Racingred,
                        selectionControls: Textselect(),
                        validator: (value) {
                          final name = value?.trim() ?? '';
                          if (name.isEmpty) {
                            return Apptext.fullnameerror;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w300,
                            color: Colorstheam.Racingred
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 02.w
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.Racingred,
                            ),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.Racingred,
                            ),
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.email,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.emailcontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          keyboardType: TextInputType.emailAddress,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) {
                              return Apptext.emailerror;
                            }
                            final emailRegex = RegExp(
                              r'^[\w.!#$%&*+/=?^`{|}~-]+@[\w-]+(\.[\w-]+)+$',
                            );
                            if (!emailRegex.hasMatch(email)) {
                              return Apptext.emailerror1;
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 02.w
                            ),
                            hint: Text(
                              Apptext.hintemail,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w500,
                                color: Colorstheam.lightgrey
                              ),
                            ),
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            hintFadeDuration: Duration(seconds: 1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.phonenumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: TextFormField(
                        controller: controller.phonenumbercontroller,
                        cursorColor: Colorstheam.nobelblack,
                        cursorErrorColor: Colorstheam.Racingred,
                        keyboardType: TextInputType.phone,
                        selectionControls: Textselect(),
                        validator: (value) {
                          final phone = value?.trim() ?? '';
                          if (phone.isEmpty) {
                            return Apptext.phonenumbererror;
                          }
                          final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
                          if (digitsOnly.length != 10) {
                            return Apptext.phonenumbererror1;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.Racingred
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 2.w,
                          ),
                          hint: Text(
                            "(123) 456-7890",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              color: Colorstheam.lightgrey,
                            ),
                          ),
                          hintFadeDuration: const Duration(seconds: 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.nobelblack,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.Racingred,
                            ),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colorstheam.Racingred,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.saloname,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.salonamecontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final salonName = value?.trim() ?? '';
                            if (salonName.isEmpty) {
                              return Apptext.salonamerror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.instagramhandle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.instagramController,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final instagram = value?.trim() ?? '';
                            if (instagram.isEmpty) {
                              return Apptext.instagramhandleerror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.salonaddress,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding (
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.salonaddresscontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final address = value?.trim() ?? '';
                            if (address.isEmpty) {
                              return Apptext.salonaddresserror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.yourrole,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.salonRoles.map((role) {
                              final isSelected =
                              controller.selectedSalonRoles.contains(role);
                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selectedSalonRoles.remove(role);
                                        } else {
                                          controller.selectedSalonRoles.add(role);
                                        }

                                        // Remove error once user selects a role
                                        if (controller.selectedSalonRoles.isNotEmpty) {
                                          controller.salonRoleError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.salonRoleError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            // Error message
                            if (controller.salonRoleError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.salonRoleError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.hwmanysylist,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.howmanystylistwork.map((role) {
                              final isSelected = controller.selecthowmanystylist.contains(role);
                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selecthowmanystylist.remove(role);
                                        } else {
                                          controller.selecthowmanystylist.add(role);
                                        }
                                        // Remove error immediately after selection
                                        if (controller.selecthowmanystylist.isNotEmpty) {
                                          controller.stylistCountError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.stylistCountError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            if (controller.stylistCountError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.stylistCountError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.stylistcurrently,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.howmanystylistwork1.map((role) {
                              final isSelected =
                              controller.selecthowmanystylist1.contains(role);

                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selecthowmanystylist1.remove(role);
                                        } else {
                                          controller.selecthowmanystylist1.add(role);
                                        }

                                        // Clear validation error after selecting
                                        if (controller.selecthowmanystylist1.isNotEmpty) {
                                          controller.stylistExtensionError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.stylistExtensionError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            // Validation error
                            if (controller.stylistExtensionError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.stylistExtensionError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.currentlyused,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.extentionmenthod.map((role) {
                              final isSelected =
                              controller.selectextentionmethod.contains(role);

                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selectextentionmethod.remove(role);
                                        } else {
                                          controller.selectextentionmethod.add(role);
                                        }

                                        // Clear error when user selects an option
                                        if (controller.selectextentionmethod.isNotEmpty) {
                                          controller.extensionMethodError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.extensionMethodError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            // Validation error
                            if (controller.extensionMethodError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.extensionMethodError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.saloneducation,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.education.map((role) {
                              final isSelected =
                              controller.selecteducation.contains(role);

                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selecteducation.remove(role);
                                        } else {
                                          controller.selecteducation.add(role);
                                        }

                                        // Clear error after selecting
                                        if (controller.selecteducation.isNotEmpty) {
                                          controller.educationError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.educationError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            // Validation error
                            if (controller.educationError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.educationError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.estimatednumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.hostcomfortablecontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final name = value?.trim() ?? '';
                            if (name.isEmpty) {
                              return Apptext.estimatednumbererror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.previouslytrained,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...controller.previously.map((role) {
                              final isSelected =
                              controller.selectpreviously.contains(role);

                              return SizedBox(
                                height: 32.h,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isSelected) {
                                          controller.selectpreviously.remove(role);
                                        } else {
                                          controller.selectpreviously.add(role);
                                        }

                                        // Clear error after selecting
                                        if (controller.selectpreviously.isNotEmpty) {
                                          controller.previouslyError.value = '';
                                        }
                                      },
                                      child: Container(
                                        width: 18.w,
                                        height: 18.w,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,
                                          border: Border.all(
                                            color: controller.previouslyError.value.isNotEmpty
                                                ? Colorstheam.Racingred
                                                : Colorstheam.nobelblack,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkright.svg",
                                            height: 7.5.h,
                                            width: 10.w,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            // Validation error
                            if (controller.previouslyError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 2.w,
                                ),
                                child: Text(
                                  controller.previouslyError.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w300,
                                      color: Colorstheam.Racingred
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.prefredmonth,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.monthhostcontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final name = value?.trim() ?? '';
                            if (name.isEmpty) {
                              return Apptext.prefredmontherror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text.rich(
                          TextSpan(
                            text: Apptext.salonorcommunity,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                            children: [
                              TextSpan(
                                text: Apptext.hastric,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.005),
                    Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: TextFormField(
                          controller: controller.salonandcomunitycontroller,
                          cursorColor: Colorstheam.nobelblack,
                          cursorErrorColor: Colorstheam.Racingred,
                          selectionControls: Textselect(),
                          validator: (value) {
                            final name = value?.trim() ?? '';
                            if (name.isEmpty) {
                              return Apptext.salonorcommunityerror;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w300,
                                color: Colorstheam.Racingred
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 02.w
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.nobelblack,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colorstheam.Racingred,
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: screensize.height * 0.015),

                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.009),
                      child: AnimatedButton(
                        onTap: () {
                          controller.submitForm();
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: Colorstheam.nobelblack,
                              border: BoxBorder.all(
                                  color: Colorstheam.nobelblack,
                                  width: 1
                              )
                          ),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w700,
                                  color: Colorstheam.clusterwhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 3;
        bottomNav.currentPage.value = PageType.inperson;
      },
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            "asset/svg/arrowleft.svg",
            width: 10.w,
            height: 10.h,
          ),
        ),
      ),
    );
  }
}
