
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/deleteaccount/controller/deleteaccountcontroller.dart';

class Deleteaccountview extends GetView<Deleteaccountcontroller> {
  Deleteaccountview({super.key});

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
          automaticallyImplyLeading: false,
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          toolbarHeight: 60.h,
          title: Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04),
            child: Row(
              children: <Widget>[
                _backButton(),
                SizedBox(width: 15.w),
                Expanded(
                  child: Text(
                    Apptext.deleteaccounttitle,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
              ],
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
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PRIVACY & ACCOUNT',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 17.h),
                Text(
                  'Permanently delete your account',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -0.7,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'If you would like to permanently delete your Malia Extensions account and associated personal data, please send an account deletion request to our support team.',
                  style: _descriptionStyle(),
                ),
                SizedBox(height: 28.h),
                Text(
                  'CONTACT OUR TEAM',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.6,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h,),
                  decoration: BoxDecoration(
                    color: Colorstheam.clusterwhite,
                    border: Border.all(
                      color: Colorstheam.lightgrey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 19.sp,
                            color: Colorstheam.nobelblack,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'EMAIL ADDRESS',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.3,
                              color: Colorstheam.dimgrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          controller.openEmail();
                          Text("Hello");
                        },
                        child: SelectableText(
                          'info@maliaextensions.com',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack,
                            decoration: TextDecoration.underline,
                            decorationColor: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                      SizedBox(height: 13.h),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colorstheam.lightgrey,
                      ),
                      SizedBox(height: 12.h),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13.sp,
                            height: 1.6,
                            color: Colorstheam.dimgrey,
                          ),
                          children: const [
                            TextSpan(text: 'Email subject: '),
                            TextSpan(
                              text: '"Delete My Account"',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'WHAT HAPPENS NEXT',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.6,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 18.h),
                _informationRow(
                  number: '01',
                  title: 'Request verification',
                  description:
                  'Once we receive your request, our team will verify your account ownership.',
                ),
                SizedBox(height: 22.h),
                _informationRow(
                  number: '02',
                  title: 'Deletion processing',
                  description:
                  'Your account deletion request will be processed within 7 business days.',
                ),
                SizedBox(height: 22.h),
                _informationRow(
                  number: '03',
                  title: 'Permanent deletion',
                  description:
                  'After processing, your Malia Extensions account and associated personal data will be permanently deleted and cannot be recovered.',
                ),
                SizedBox(height: 30.h),
                Container(
                  height: 1.h,
                  width: double.infinity,
                  color: Colorstheam.clusterwhite,
                ),
                SizedBox(height: 17.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      size: 17.sp,
                      color: Colorstheam.dimgrey,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Please make sure you have saved any information you may need before submitting your deletion request.',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 12.sp,
                          height: 1.6,
                          color: Colorstheam.dimgrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  TextStyle _descriptionStyle() {
    return TextStyle(
      fontFamily: 'DMSans',
      fontSize: 14.sp,
      height: 1.75,
      fontWeight: FontWeight.w400,
      color: Colorstheam.dimgrey,
    );
  }
  Widget _informationRow({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 35.w,
          child: Text(
            number,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: Colorstheam.grey,
            ),
          ),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colorstheam.nobelblack,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                description,
                style: _descriptionStyle().copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 10.w,
            height: 10.w,
          ),
        ),
      ),
    );
  }
}