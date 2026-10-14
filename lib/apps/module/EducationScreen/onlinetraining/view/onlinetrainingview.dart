import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/controller/onlinetrainingcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Onlinetrainingview extends GetView<Onlinetrainingcontroller> {
  const Onlinetrainingview({super.key});

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
              ],
            ),
          ),
          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                final bottomNav = Get.find<Bottomnavigationcontroller>();
                bottomNav.selectedIndex.value = 1;
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
          child: Column(
            children: <Widget>[
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Online Training",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screensize.width * 0.04,
                  right: screensize.width * 0.04,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Learn directly from Dimitra and certified Malia instructors with hands-on practice, real-time feedback, and the confidence to start booking clients immediately.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack,
                      height: 1.4,
                    ),
                  )
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Divider(
                  height: 1,
                  color: Colorstheam.arabiangrey,
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "All Courses",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack
                      ),
                    ),
                    Text(
                      "Total 5 Courses",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack.withValues(alpha: 0.6)
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Container(
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
                      "asset/image/image02.png",
                      width: double.infinity,
                      height: 190.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Online Education for Butterfly Method",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "asset/svg/rating.svg",
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "4.9",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w600,
                                      color: Colorstheam.nobelblack,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 2.h,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login to see price",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final bottomNav = Get.find<Bottomnavigationcontroller>();
                                bottomNav.selectedIndex.value = 3;
                                bottomNav.currentPage.value = PageType.onlinetrainingviewclass;
                              },
                              child: Container(
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF242426),
                                ),
                                child: Text(
                                  "View Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Container(
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
                      "asset/image/image02.png",
                      width: double.infinity,
                      height: 190.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Online Education for Freestyle IT Method Tape Wefts",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "asset/svg/rating.svg",
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "4.9",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w600,
                                      color: Colorstheam.nobelblack,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 2.h,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login to see price",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final bottomNav = Get.find<Bottomnavigationcontroller>();
                                bottomNav.selectedIndex.value = 3;
                                bottomNav.currentPage.value = PageType.onlinetrainingviewclass;
                              },
                              child: Container(
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF242426),
                                ),
                                child: Text(
                                  "View Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Container(
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
                      "asset/image/ig4.png",
                      width: double.infinity,
                      height: 190.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Complete Starter Bundle (Online Education, Essentials Kit & Color Ring)",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "asset/svg/rating.svg",
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "4.9",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w600,
                                      color: Colorstheam.nobelblack,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 2.h,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login to see price",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final bottomNav = Get.find<Bottomnavigationcontroller>();
                                bottomNav.selectedIndex.value = 3;
                                bottomNav.currentPage.value = PageType.onlinetrainingviewclass;
                              },
                              child: Container(
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF242426),
                                ),
                                child: Text(
                                  "View Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Container(
                padding: EdgeInsets.only(
                  bottom: 2.h,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  "View All Courses",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Divider(
                  height: 1.h,
                  color: Colorstheam.arabiangrey,
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Why Train With Malia Extensions?",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Join thousands of stylists who switched to faster installs, better pricing, and a support team that actually gets it.",
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
                padding: EdgeInsets.only(
                    top: screensize.height * 0.02,
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: const BoxDecoration(
                        color: Colorstheam.burntearth,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "asset/svg/expert.svg",
                        width: 26.4.w,
                        height: 26.4.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expert Instruction",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Learn from industry professionals with years of experience in extension application and education",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.nobelblack,
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
                    top: screensize.height * 0.02,
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: const BoxDecoration(
                        color: Colorstheam.burntearth,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "asset/svg/weft.svg",
                        width: 26.4.w,
                        height: 26.4.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Premium Products",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Train with our high-quality 100% human hair extensions and professional installation tools",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.nobelblack,
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
                    top: screensize.height * 0.02,
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: const BoxDecoration(
                        color: Colorstheam.burntearth,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "asset/svg/support.svg",
                        width: 26.4.w,
                        height: 26.4.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ongoing Support",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Join our community of professionals with continued education and support after your class",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.nobelblack,
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
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                    top: screensize.height * 0.02
                ),
                child: AnimatedButton(
                  onTap: (){},
                  child: Container(
                    width: 362.w,
                    height: 35.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colorstheam.nobelblack,
                      border: Border.all(
                        color: Colorstheam.nobelblack,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam. clusterwhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Divider(
                  height: 1,
                  color: Colorstheam.arabiangrey,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01,right: screensize.width * 0.04),
                  child: Text(
                    "Become A Malia Stylist",
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
              Container(
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
                      "asset/image/image01.png",
                      width: double.infinity,
                      height: 190.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          "In-Person Education",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          "Whether you’re on the salon floor or just starting out, our education adapts to you.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screensize.width * 0.04,
                          right: screensize.width * 0.04,
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
                            color: Colorstheam.nobelblack,
                            border: Border.all(
                              color: Colorstheam.nobelblack,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Reserve your seat",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600,
                                color: Colorstheam. clusterwhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Container(
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
                      "asset/image/image02.png",
                      width: double.infinity,
                      height: 190.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          "Create Pro Account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04),
                        child: Text(
                          "Any licensed cosmetologist can purchase Malia Extensions. Simply register to gain access to our method and high quality hair.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screensize.width * 0.04,
                          right: screensize.width * 0.04,
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
                            color: Colorstheam.nobelblack,
                            border: Border.all(
                              color: Colorstheam.nobelblack,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Pro Stylist Registration",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600,
                                color: Colorstheam. clusterwhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.03),
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
        bottomNav.currentPage.value = PageType.education;
      },
      child: Container(
        width: 32.w,
        height: 32.h,
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
  Widget _headerIcon({required String icon, VoidCallback? onTap,}) {
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