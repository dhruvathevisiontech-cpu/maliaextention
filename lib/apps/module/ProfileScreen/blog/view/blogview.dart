// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/blog/controller/blogcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Blogview extends GetView<Blogcontroller> {
  const Blogview({super.key});

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
                SizedBox(width: 12.w),
                Text(
                  Apptext.blogtitle,
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: screensize.height * 0.02,left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    "How to Wash Hair Extensions in 5 Easy Steps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
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
                    "So, your roots feel oily by day three, but your extensions still look perfect. You then wash everything, and your install pays the price. Sound familiar? Most extension wearers fall into this cycle at some point. The good news is there's a simple fix.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
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
                    "Here's how often to wash hair extensions and how crown washing keeps your roots fresh. You'll also learn how it helps your install last longer.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
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
                    "How Often Should I Wash My Hair Extensions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "DMSans",
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
                    "Most stylists recommend washing once or twice a week. Extensions don't get natural oils from your scalp, so they dry out faster. Every full wash strips a little more moisture from your lengths. Over time, that can lead to frizz, tangles, and a dull finish.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
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
                    "Your scalp, though, may need refreshing every day or two. It keeps producing oil, sweat, and product buildup no matter what. That's where the problem starts. Your roots want a wash, but your extensions don't. Crown washing fills that gap.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
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
                    "Always follow your stylist's guidance for your installation method. Tape-ins, wefts, and other methods can each have their own care needs.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
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
                    "Signs It's Time To Refresh Your Roots",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "DMSans",
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
                    "Not sure when to crown wash? Your scalp usually tells you. Watch for these signs:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w500,
                    ),
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
        final Bottomnavigationcontroller bottomNav =
        Get.find<Bottomnavigationcontroller>();

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
}
