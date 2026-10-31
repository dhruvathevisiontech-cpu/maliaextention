// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/controller/privacypolicycontroller.dart';

class Privacypolicyview extends GetView<Privacypolicycontroller> {
  const Privacypolicyview({super.key});

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
                SizedBox(width: screensize.width * 0.02),
                Text(
                  Apptext.privacypolicy,
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 05.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colorstheam.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        'YOUR PRIVACY MATTERS',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10.sp,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w800,
                          color: Colorstheam.burntearth,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 28.sp,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Learn how we collect, use, and protect your personal information.',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        height: 1.6,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(controller.errorMessage.value),
                  );
                }

                if (controller.policyBody.value.isEmpty) {
                  return const Center(
                    child: Text('Privacy policy is not available.'),
                  );
                }
                return HtmlWidget(
                  controller.policyBody.value,
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    height: 1.6,
                    color: Colorstheam.black,
                  ),
                );
              })
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
        HapticFeedback.heavyImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.policy;
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


