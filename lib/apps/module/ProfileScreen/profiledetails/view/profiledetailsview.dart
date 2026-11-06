import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/controller/profiledetailscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Profiledetailsview extends GetView<Profiledetailscontroller> {
  const Profiledetailsview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorstheam.white,
      appBar: AppBar(
        backgroundColor: Colorstheam.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: _backButton,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colorstheam.black,
            size: 18.sp,
          ),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colorstheam.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26.h),

                // Profile identity
                Row(
                  children: [
                    Container(
                      height: 82.w,
                      width: 82.w,
                      decoration: BoxDecoration(
                        color: Colorstheam.white,
                        border: Border.all(
                          color: Colorstheam.clusterwhite,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person_outline,
                        size: 40.sp,
                        color: Colorstheam.grey,
                      ),
                    ),
                    SizedBox(width: 17.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dhruva Chavda',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                              color: Colorstheam.black,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'jemish.thevision@gmail.com',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 11.sp,
                              color: Colorstheam.grey,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'CHANGE PHOTO',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: Colorstheam.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 34.h),

                Text(
                  'PERSONAL DETAILS',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                    color: Colorstheam.black,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Update your personal information below.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 12.sp,
                    color: Colorstheam.grey,
                  ),
                ),

                SizedBox(height: 24.h),

                _editableField(
                  label: 'Full Name',
                  initialValue: 'Dhruva Chavda',
                  textInputType: TextInputType.name,
                ),

                SizedBox(height: 20.h),

                _editableField(
                  label: 'Email Address',
                  initialValue: 'jemish.thevision@gmail.com',
                  textInputType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20.h),

                _editableField(
                  label: 'Phone Number',
                  initialValue: '+91 00000 00000',
                  textInputType: TextInputType.phone,
                ),

                SizedBox(height: 20.h),

                _editableField(
                  label: 'Date of Birth',
                  initialValue: '',
                  hintText: 'Enter your date of birth',
                  textInputType: TextInputType.datetime,
                ),

                SizedBox(height: 32.h),

                AnimatedButton(
                  onTap: () {},
                  child: Container(
                    height: 48.h,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Colorstheam.nobelblack,
                    child: Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Colorstheam.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editableField({
    required String label,
    required String initialValue,
    required TextInputType textInputType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Colorstheam.black,
          ),
        ),
        SizedBox(height: 9.h),
        TextFormField(
          initialValue: initialValue,
          keyboardType: textInputType,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 13.sp,
            color: Colorstheam.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13.sp,
              color: Colorstheam.grey,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 15.h,
            ),
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colorstheam.clusterwhite,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colorstheam.nobelblack,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _backButton() {
    final bottomController = Get.find<Bottomnavigationcontroller>();
    bottomController.selectedIndex.value = 4;
    bottomController.currentPage.value = PageType.policy;
  }
}