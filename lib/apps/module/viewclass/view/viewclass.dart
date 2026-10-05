// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/viewclass/controller/viewclasscontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Viewclass extends GetView<Viewclasscontroller> {
  Viewclass({super.key});
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
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 402.h,
                    decoration: BoxDecoration(
                      color: Colorstheam.clusterwhite,
                    ),
                    child: Image.asset(
                      "asset/image/product2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -20.h,
                    left: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 13.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colorstheam.burntearth,
                      ),
                      child: Text(
                        "9th Nov",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screensize.height * 0.05),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Derry, NH",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Vip Ticket • 10AM-3PM",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screensize.height * 0.015,left: screensize.width * 0.04),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "asset/svg/location.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: screensize.width * 0.01),
                    IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Evolve Salon Systems",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            height: 1.h,
                            color: Colorstheam.nobelblack,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\$699.00",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.005),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colorstheam.green,
                          width: 3.7,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 6.w),
                    Text(
                      "Available in stock",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: AnimatedButton(
                  onTap: () {
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
                          "Grab Your Seat",
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
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Class Details",
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
                    "Every student receives all tools and supplies needed for class, including:",
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
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Butterfly + Flutter Luxe Kit",
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
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.005),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Full tool kit",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.001),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Practice weft",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.001),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Beads",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.001),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Velcro grippers",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.001),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Swag bag",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "What Students Must Bring",
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
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.005),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Mannequin head",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.005),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Mannequin tripod/stand",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  border: Border(
                    top: BorderSide(
                      color: Colorstheam.nobelblack,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Skills You'll Master",
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
                      child: Text(
                        "Learn the techniques, tools, and methods to deliver flawless extension installs with confidence.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01,),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "The full Malia Butterfly Method™ (rows in 15 minutes — yes, really!)",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01,),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Divider(height: 1,color: Colorstheam.arabiangrey,),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "All 3 Butterfly Wefts (Classic, Skinny and Luxe)",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Divider(height: 1,color: Colorstheam.arabiangrey,),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Proper sectioning, placement, and tension control",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Divider(height: 1,color: Colorstheam.arabiangrey,),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "How to create seamless, comfortable, long-lasting installs",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Divider(height: 1,color: Colorstheam.arabiangrey,),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Techniques to dramatically speed up install times",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Divider(height: 1,color: Colorstheam.arabiangrey,),
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset(
                              "asset/svg/verified.svg",
                              width: 19.02.w,
                              height: 19.02.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Hands-on practice with guidance from a certified malia educator",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.015),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Excellence in Every Session",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'asset/image/ig1.png',
                        width: 114.w,
                        height: 171.h,
                      ),
                    ),
                    SizedBox(width: screensize.width * 0.02),
                    Expanded(
                      child: Image.asset(
                        'asset/image/ig2.png',
                        width: 114.w,
                        height: 171.h,
                      ),
                    ),
                    SizedBox(width: screensize.width * 0.02),
                    Expanded(
                      child: Image.asset(
                        'asset/image/ig3.png',
                        width: 114.w,
                        height: 171.h,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.015),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Experience the Malia Difference",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "More than a new hairstyle, It's a transformation that reflects the best version of you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Obx(
                    () => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screensize.width * 0.04,
                  ),
                  child: SizedBox(
                    height: 347.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: controller.carouselController,
                          itemCount: controller.carouselImages.length,
                          onPageChanged: controller.onCarouselChanged,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                              ),
                              child: ClipRRect(
                                child: Image.asset(
                                  controller.carouselImages[index],
                                  width: double.infinity,
                                  height: 300.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 12.h,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.carouselImages.length,
                                  (index) {
                                final bool isActive =
                                    controller.currentCarouselIndex.value == index;

                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                  ),
                                  width: isActive ? 30.w : 6.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? Colorstheam.clusterwhite
                                        : Colorstheam.clusterwhite,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
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
