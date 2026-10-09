// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/controller/contactuscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Contactusview extends GetView<Contactuscontroller> {
  const Contactusview({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor:Colorstheam.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          toolbarHeight: 60.h,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Text(
                  Apptext.contactustitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              20.w,
              22.h,
              20.w,
              32.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 26.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colorstheam.clusterwhite.withOpacity(0.6),
                    border: Border.all(
                      color: Colorstheam.clusterwhite,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                        ),
                        child: Text(
                          'M A L I A   S U P P O R T',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w700,
                            color: Colorstheam.nobelblack.withOpacity(0.6),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        "We're always\nhappy to help.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.sp,
                          height: 1.15,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'Let’s connect and find the right solution '
                              'for you. Our team is here to make your '
                              'experience seamless.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            height: 1.7,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w400,
                            color: Colorstheam.nobelblack.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'GET IN TOUCH',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'How can we help you?',
                  style: TextStyle(
                    fontSize: 25.sp,
                    height: 1.2,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  "Have a question about your order, our "
                      "products, or certifications? Send us a message "
                      "and we’ll be happy to assist.",
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.65,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w400,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 26.h),
                _fieldLabel('Name', required: true),
                SizedBox(height: 8.h),
                _textField(
                  controller: controller.firstnameController,
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
                _fieldLabel('Email address', required: true),
                SizedBox(height: 8.h),
                _textField(
                  controller: controller.emailController,
                  hint: 'Enter your email address',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
                _fieldLabel('Phone number'),
                SizedBox(height: 8.h),
                _textField(
                  controller: controller.phonenumberController,
                  hint: 'Enter your phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
                _fieldLabel('Order number'),
                SizedBox(height: 8.h),
                _textField(
                  controller: controller.ordernumberController,
                  hint: 'Enter your order number (optional)',
                  icon: Icons.receipt_long_outlined,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.h),
                _fieldLabel('Your message', required: true),
                SizedBox(height: 8.h),
                _textField(
                  controller: controller.yourmessageController,
                  hint: 'Tell us how we can help you...',
                  icon: Icons.chat_bubble_outline_rounded,
                  maxLines: 5,
                  minLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: 26.h),
                AnimatedButton(
                  child: Container(
                    width: double.infinity,
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colorstheam.nobelblack,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                // FOOTER NOTE
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 14.sp,
                        color: Colorstheam.dimgrey,
                      ),
                      SizedBox(width: 7.w),
                      Flexible(
                        child: Text(
                          'Your information is handled with care.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: 'DMSans',
                            color: Colorstheam.dimgrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // REUSABLE FIELD LABEL
  Widget _fieldLabel(
      String label, {
        bool required = false,
      }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w700,
            color: Colorstheam.nobelblack,
          ),
        ),
        if (required)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              '*',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w700,
                color: Colorstheam.Racingred,
              ),
            ),
          ),
      ],
    );
  }

  // REUSABLE PREMIUM INPUT
  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization =
        TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    int minLines = 1,
    int maxLines = 1,
  }) {
    const borderColor = Colorstheam.clusterwhite;

    return TextFormField(
      controller: controller,
      cursorColor: Colorstheam.nobelblack,
      selectionControls: Textselect(),
      keyboardType: textInputAction == TextInputAction.newline
          ? TextInputType.multiline
          : keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w400,
        color: Colorstheam.nobelblack,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w400,
          color: Colorstheam.arabiangrey,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: 14.w,
            right: 10.w,
            bottom: maxLines > 1 ? 65.h : 0,
          ),
          child: Icon(
            icon,
            size: 19.sp,
            color: Colorstheam.arabiangrey,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 44.w,
          minHeight: 48.h,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 16.h,
        ),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colorstheam.nobelblack,
            width: 1.2,
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
            width: 1.2,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 11.sp,
          fontFamily: 'DMSans',
          color: Colorstheam.Racingred,
        ),
      ),
    );
  }

  // BACK BUTTON
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();

        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 11.w,
            height: 11.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
