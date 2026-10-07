// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/InPerson/controller/inpersoncontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/hostclass/controller/hostclasscontroller.dart';
import 'package:maliaextention/apps/module/profile/controller/profilecontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Profileview extends GetView<Profilecontroller> {
  const Profileview({super.key});

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
                  Apptext.profileappbartitle,
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
          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                final bottomNav = Get.find<Bottomnavigationcontroller>();
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
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                  child: Text(
                    Apptext.profilewelcome,
                    style:  TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: 0),
                  child: Text(
                    Apptext.profilewelcomesubtitle,
                    style:  TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: AnimatedButton(
                    onTap: () {
                    },
                    child: Container(
                      height: 40.h,
                      width: 160.w,
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
                            Apptext.profilebtntext,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.03),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colorstheam.clusterwhite)
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 08.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.w,
                              child: SvgPicture.asset(
                                "asset/svg/profile.svg",
                                height:   13.33.h,
                                width: 13.33.w,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Profile Details",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                color: Colorstheam.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 08.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.w,
                              child: SvgPicture.asset(
                                "asset/svg/cource.svg",
                                height: 12.5.h,
                                width: 15.w,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "My Courses",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                color: Colorstheam.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          final bottomNav = Get.find<Bottomnavigationcontroller>();
                          bottomNav.selectedIndex.value = 4;
                          bottomNav.currentPage.value = PageType.orderhistory;
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 08.h,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                  "asset/svg/orders.svg",
                                  height:  16.h,
                                  width: 16.w,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                "Orders",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          final bottomNav = Get.find<Bottomnavigationcontroller>();
                          bottomNav.selectedIndex.value = 4;
                          bottomNav.currentPage.value = PageType.addresslist;
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 08.h,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(
                                  "asset/svg/address.svg",
                                  height: 16.h,
                                  width: 16.w,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                "Address",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 08.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.w,
                              child: SvgPicture.asset(
                                "asset/svg/salonlocator.svg",
                                height: 16.67.h,
                                width: 13.33.w,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Salon Locators",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                color: Colorstheam.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      Obx(
                            () => Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                controller.isProfileExpanded.value =
                                !controller.isProfileExpanded.value;
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      child: SvgPicture.asset(
                                        "asset/svg/information.svg",
                                        height: 20.h,
                                        width: 20.w,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),

                                    SizedBox(width: 12.w),

                                    Expanded(
                                      child: Text(
                                        "Information",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "DMSans",
                                          color: Colorstheam.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    AnimatedRotation(
                                      turns: controller.isProfileExpanded.value ? 0.5 : 0,
                                      duration: const Duration(milliseconds: 200),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 22.sp,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.08,right: screensize.width * 0.08),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "About Us",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "DMSans",
                                              color: Colorstheam.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ),
                                      SizedBox(height: screensize.height * 0.01),
                                      Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "FAQ’s",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                      ),
                                      SizedBox(height: screensize.height * 0.01),
                                      Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Policies",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                      ),
                                      SizedBox(height: screensize.height * 0.01),
                                      Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Contact us",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ),
                              crossFadeState: controller.isProfileExpanded.value
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 250),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 08.h,
                        ),
                        child: Text(
                          "Delete Account",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            color: Colorstheam.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Divider(
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 08.h,
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            color: Colorstheam.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        bottomNav.selectedIndex.value = 0;
        bottomNav.currentPage.value = PageType.home;
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
