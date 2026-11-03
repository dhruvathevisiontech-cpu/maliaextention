import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colorstheam.white,
        appBar: AppBar(
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: _handleBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: Colorstheam.nobelblack,
            ),
          ),
          title: Text(
            'Profile details',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colorstheam.nobelblack,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colorstheam.clusterwhite,
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 30.sp,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Name',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'your@email.com',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'DMSans',
                              color: Colorstheam.grey,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Text(
                  'PERSONAL INFORMATION',
                  style: TextStyle(
                    fontSize: 11.sp,
                    letterSpacing: 0.8,
                    fontFamily: 'DMSans',
                    color: Colorstheam.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                _detailRow('Full name', 'Your Name'),
                _detailRow('Email address', 'your@email.com'),
                _detailRow('Phone number', 'Add phone number'),
                _detailRow(
                  'Date of birth',
                  'Add date of birth',
                  showDivider: false,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 46.h,
                  child: AnimatedButton(
                    onTap: () {
                    },
                    child: Container(
                      height: 40.h,
                      color: Colorstheam.nobelblack,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Edit profile',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.clusterwhite
                          ),
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
  }

  Widget _detailRow(
      String label,
      String value, {
        bool showDivider = true,
      }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w500,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'DMSans',
                    color: Colorstheam.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1.h,
            color: Colorstheam.clusterwhite,
          ),
      ],
    );
  }

  void _handleBack() {
    HapticFeedback.heavyImpact();
    final bottomController = Get.find<Bottomnavigationcontroller>();
    bottomController.selectedIndex.value = 4;
    bottomController.currentPage.value = PageType.profile;
    Get.back();
  }
}