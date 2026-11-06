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
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colorstheam.nobelblack,
                ),
              );
            }
            if (controller.blog.isEmpty) {
              return const Center(
                child: Text("No blog content available"),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: screensize.height * 0.02,left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        controller.getBlogText('wash_hair'),
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
                        controller.getBlogText('your_roots'),
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
                        controller.getBlogText('how_often'),
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
                        controller.getBlogText('should_i_wash'),
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
                        controller.getBlogText('most_stylist'),
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
                        controller.getBlogText('your_scalp'),
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
                        controller.getBlogText('always_follow'),
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
                        controller.getBlogText('signs'),
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
                        controller.getBlogText('not_sures'),
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
            );
          }),
        ),
      ),
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
        final Bottomnavigationcontroller bottomNav = Get.find<Bottomnavigationcontroller>();
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
