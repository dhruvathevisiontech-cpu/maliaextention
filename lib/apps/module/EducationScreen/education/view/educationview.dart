// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/controller/educationcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Educationview extends GetView<Educationcontroller> {
  const Educationview({super.key});

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
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 10.w),
                Text(
                  "Education",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),
          ),

          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),

            SizedBox(width: 20.w),

            Padding(
              padding: EdgeInsets.only(
                right: screensize.width * 0.04,
              ),
              child: _headerIcon(
                onTap: (){
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "asset/image/education.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              _sectionTitle(
                "The Butterfly Method",
                screensize,
              ),
              _bodyText(
                "We don’t just teach the Butterfly Method, we created it.",
                screensize,
                maxLines: 1,
              ),
              _bodyText(
                "The Butterfly Method is a modern hair extension method designed to prioritize your time, protect your body, and deliver results your clients can't stop looking at.",
                screensize,
                maxLines: 4,
              ),
              _bodyText(
                "No unnecessary steps. No outdated techniques. Just a smarter hair extension training system that works as hard as you do.",
                screensize,
                maxLines: 3,
              ),
              SizedBox(height: 8.h),
              _divider(screensize),
              _benefitItem(
                number: "01",
                text:
                "Certificate of Completion from Malia EDU, complete with full brand kit",
                screensize: screensize,
              ),
              _divider(screensize),
              _benefitItem(
                number: "02",
                text:
                "Get more time back in your day with rows installed in as little as 15 minutes",
                screensize: screensize,
              ),
              _divider(screensize),
              _benefitItem(
                number: "03",
                text:
                "A hair extension method that protects natural hair",
                screensize: screensize,
              ),
              _divider(screensize),
              _benefitItem(
                number: "04",
                text:
                "Pro pricing on Butterfly Wefts & exclusive access to product drops",
                screensize: screensize,
              ),
              _divider(screensize),
              _benefitItem(
                number: "05",
                text:
                "A community of Malia EDU-certified stylists who actually have your back",
                screensize: screensize,
              ),
              SizedBox(height: 12.h),
              _primaryButton(
                title: "Unlock The Method",
                screensize: screensize,
                onTap: () {},
              ),
              _sectionTitle(
                "Hair Extension Training",
                screensize,
              ),
              SizedBox(height: 8.h),
              _educationCard(
                image: "asset/image/image01.png",
                title: "In-Person Education",
                bullets: const [
                  "One Day at Malia HQ.",
                  "Hands-On.",
                  "Full Kit Included",
                  "Leave Certified",
                ],
                buttonText: "Reserve your seat",
                screensize: screensize,
              ),
              SizedBox(height: 16.h),
              _educationCard1(
                image: "asset/image/image02.png",
                title: "Online Education",
                bullets: const [
                  "Learn on your own time.",
                  "Lifetime Access.",
                  "Become Certified From Anywhere",
                ],
                buttonText: "Start Learning",
                screensize: screensize,
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                color: Colorstheam.nobelblack,
                padding: EdgeInsets.symmetric(
                  horizontal: screensize.width * 0.04,
                  vertical: 24.h,
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Become a Malia Pro",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Join thousands of stylists who switched to faster installs, better pricing, and a support team that actually gets it.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screensize.height * 0.02
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F2ED),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "asset/svg/Group.svg",
                              width: 18.w,
                              height: 18.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pro Pricing",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.2,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  "Upgrade to Pro and unlock more value, tools, and flexibility.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w300,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screensize.height * 0.02
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F2ED),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "asset/svg/education.svg",
                              width: 18.w,
                              height: 18.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "In-Person & Online Education",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.2,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  "Access professional education through  In-Person and Online Education.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w300,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screensize.height * 0.02
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F2ED),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "asset/svg/lock.svg",
                              width: 18.w,
                              height: 18.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Full Access to Malia Extensions",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Unlock full access to Malia Extensions with exclusive features and benefits.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w300,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screensize.height * 0.02
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F2ED),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "asset/svg/lock.svg",
                              width: 18.w,
                              height: 18.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Full Access to Malia Extensions",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Unlock full access to Malia Extensions with exclusive features and benefits.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w300,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screensize.height * 0.02
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F2ED),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "asset/svg/gift.svg",
                              width: 18.w,
                              height: 18.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exclusive Promotions",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Discover limited offers and premium benefits available only here.",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w300,
                                    color: Colorstheam.clusterwhite,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.01,
                        right: screensize.width * 0.01,
                        top: screensize.height * 0.02
                      ),
                      child: AnimatedButton(
                        onTap: (){},
                        child: Container(
                          width: 362.w,
                          height: 40.h,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Colorstheam.clusterwhite,
                            border: Border.all(
                              color: Colorstheam.clusterwhite,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Unlock your free pro account",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.bold,
                                color: Colorstheam. nobelblack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01,),
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      decoration:  BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1,
                          ),
                        ),
                      ),
                      child:  Text(
                        "Malia is only available to licensed stylist",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.clusterwhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _sectionTitle(
      String title,
      Size screensize,
      ) {
    return Padding(
      padding: EdgeInsets.only(
        left: screensize.width * 0.04,
        right: screensize.width * 0.04,
        top: screensize.height * 0.02,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.sp,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.bold,
          color: Colorstheam.nobelblack,
        ),
      ),
    );
  }
  Widget _bodyText(
      String text,
      Size screensize, {
        int? maxLines,
      }) {
    return Padding(
      padding: EdgeInsets.only(
        left: screensize.width * 0.04,
        right: screensize.width * 0.04,
        top: screensize.height * 0.015,
      ),
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        minFontSize: 12,
        maxFontSize: 14,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: "DMSans",
          fontWeight: FontWeight.w500,
          color: Colorstheam.nobelblack,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _divider(Size screensize) {
    return Padding(
      padding: EdgeInsets.only(
        left: screensize.width * 0.04,
        right: screensize.width * 0.04,
        top: 12.h,
      ),
      child: Divider(
        color: Colorstheam.clusterwhite,
        height: 1,
      ),
    );
  }
  Widget _benefitItem({
    required String number,
    required String text,
    required Size screensize,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: screensize.width * 0.04,
        right: screensize.width * 0.04,
        top: 14.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "DMSans",
              color: Colorstheam.burntearth,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "DMSans",
                color: Colorstheam.nobelblack,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _educationCard({
    required String image,
    required String title,
    required List<String> bullets,
    required String buttonText,
    required Size screensize,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screensize.width * 0.04,
      ),
      padding: EdgeInsets.only(
        bottom: 20.h,
      ),
      color: Colorstheam.clusterwhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            width: double.infinity,
            height: 190.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
              right: screensize.width * 0.04,
              top: 16.h,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          ...bullets.map(
                (bullet) => Padding(
              padding: EdgeInsets.only(
                left: screensize.width * 0.07,
                right: screensize.width * 0.04,
                top: 7.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DMSans",
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: Text(
                      bullet,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          _primaryButton(
            title: buttonText,
            screensize: screensize,
            onTap: () {
              final bottomNav = Get.find<Bottomnavigationcontroller>();
              bottomNav.selectedIndex.value = 3;
              bottomNav.currentPage.value = PageType.inperson;
            },
          ),
        ],
      ),
    );
  }

  Widget _educationCard1({
    required String image,
    required String title,
    required List<String> bullets,
    required String buttonText,
    required Size screensize,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screensize.width * 0.04,
      ),

      padding: EdgeInsets.only(
        bottom: 20.h,
      ),

      color: Colorstheam.clusterwhite,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            width: double.infinity,
            height: 190.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
              right: screensize.width * 0.04,
              top: 16.h,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          ...bullets.map(
                (bullet) => Padding(
              padding: EdgeInsets.only(
                left: screensize.width * 0.07,
                right: screensize.width * 0.04,
                top: 7.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "•",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DMSans",
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: Text(
                      bullet,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          _primaryButton(
            title: buttonText,
            screensize: screensize,
            onTap: () {
              final bottomNav = Get.find<Bottomnavigationcontroller>();
              bottomNav.selectedIndex.value = 3;
              bottomNav.currentPage.value = PageType.onlinetraing;
            },
          ),
        ],
      ),
    );
  }

  Widget _primaryButton({
    required String title,
    required Size screensize,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screensize.width * 0.04,
      ),
      child: AnimatedButton(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colorstheam.nobelblack,
            border: Border.all(
              color: Colorstheam.nobelblack,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
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
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 1;
        bottomNav.currentPage.value = PageType.collection;
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

  Widget _headerIcon({
    required String icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: onTap,

      child: SizedBox(
        width: 22.w,
        height: 22.w,

        child: SvgPicture.asset(
          icon,
          width: 22.w,
          height: 22.w,
        ),
      ),
    );
  }
}