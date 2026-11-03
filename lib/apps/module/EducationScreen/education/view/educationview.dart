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
import 'package:marquee/marquee.dart';

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
          title: Padding(padding: EdgeInsets.only(left: screensize.width * 0.04),
            child: Row(
              children: <Widget>[
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
                HapticFeedback.heavyImpact();
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),
            SizedBox(width: 20.w),
            Padding(padding: EdgeInsets.only(right: screensize.width * 0.04),
              child: _headerIcon(
                onTap: (){
                  HapticFeedback.heavyImpact();
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: Obx(() {
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
          return SingleChildScrollView(
            physics:  ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  controller.getImage('hero_image'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                _sectionTitle(
                  controller.getText('method_title'),
                  screensize,
                ),
                _bodyText(
                  controller.getText('method_subtitle'),
                  screensize,
                  maxLines: 1,
                ),
                _bodyText(
                  controller.getText('method_description'),
                  screensize,
                  maxLines: 4,
                ),
                _bodyText(
                  controller.getText('method_additional_description'),
                  screensize,
                  maxLines: 3,
                ),
                SizedBox(height: 8.h),
                Obx(() {
                  final benefits = controller.getList('benefits');
                  return Column(
                    children: [
                      for (int i = 0; i < benefits.length; i++) ...[
                        _divider(screensize),
                        _benefitItem(
                          number: benefits[i]['number']?.toString() ?? '',
                          text: benefits[i]['text']?.toString() ?? '',
                          screensize: screensize,
                        ),
                      ],
                      if (benefits.isNotEmpty)
                        _divider(screensize),
                    ],
                  );
                }),
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
                Obx(() {
                  return _educationCard(
                    image: controller.getImage('in_person_image'),
                    title: controller.getText('in_person_title'),
                    bullets: controller.getList('in_person_bullets')
                        .map((item) => item.toString())
                        .toList(),
                    buttonText: controller.getText('in_person_button_text'),
                    screensize: screensize,
                  );
                }),
                SizedBox(height: 16.h),
                Obx(() {
                  return _educationCard1(
                    image: controller.getImage('online_image'),
                    title: controller.getText('online_title'),
                    bullets: controller.getList('online_bullets')
                        .map((item) => item.toString())
                        .toList(),
                    buttonText: controller.getText('online_button_text'),
                    screensize: screensize,
                  );
                }),
                SizedBox(height: 15.h),
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
                            controller.getText('why_malia_title'),
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
                            controller.getText('founder_description'),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                        ),
                        SizedBox(height: screensize.height * 0.005),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            controller.getText('founder_name'),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                        ),
                        SizedBox(height: screensize.height * 0.005),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "We don’t just sell wefts and wish you luck. We help stylists build successful hair extension businesses through:",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                        ),
                        Obx(() {
                          final founderBenefits = controller.getList('founder_benefits');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              founderBenefits.length, (index) {
                                final item = founderBenefits[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: screensize.height * 0.02,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "asset/svg/verified.svg",
                                        width: 30.w,
                                        height: 30.w,
                                        colorFilter: ColorFilter.mode(
                                          Colorstheam.clusterwhite,
                                          BlendMode.srcIn,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Text(
                                          item['title']?.toString() ?? '',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w600,
                                            color: Colorstheam.clusterwhite,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    )
                ),
                Container(
                  height: 45.h,
                  color: Colorstheam.clusterwhite,
                  child: Marquee(
                    text: controller.getText('marquee_text'),
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colorstheam.nobelblack,
                    ),
                    velocity: 40,
                    blankSpace: 15,
                    startPadding: 0,
                    pauseAfterRound: Duration.zero,
                    showFadingOnlyWhenScrolling: true,
                  ),
                ),
                Obx(() {
                  final proBenefits = controller.getList('pro_benefits');
                  return Container(
                    width: double.infinity,
                    color: Colorstheam.nobelblack,
                    padding: EdgeInsets.symmetric(
                      horizontal: screensize.width * 0.04,
                      vertical: 24.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            controller.getText(
                              'become_pro_title',
                              fallback: 'Become a Malia Pro',
                            ),
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
                            controller.getText('become_pro_description'),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500,
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...proBenefits.map((item) {
                          final String title = item['title']?.toString() ?? '';
                          final String description = item['description']?.toString() ?? '';
                          final String icon = item['icon']?.toString() ?? '';
                          return Padding(padding: EdgeInsets.only(top: screensize.height * 0.02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5F2ED),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'asset/svg/$icon',
                                    width: 18.w,
                                    height: 18.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        title,
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
                                        description,
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
                          );
                        }),
                        Padding(padding: EdgeInsets.only(left: screensize.width * 0.01,right: screensize.width * 0.01,top: screensize.height * 0.02),
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
                                  controller.getText(
                                    'pro_button_text',
                                    fallback: 'Unlock your free pro account',
                                  ),
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
                        SizedBox(height: screensize.height * 0.01),
                        Align(
                          alignment: Alignment.center,
                          child: Obx(
                                () => Container(
                              padding: EdgeInsets.only(bottom: 2),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colorstheam.clusterwhite,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                controller.getText(
                                  'license_text',
                                  fallback: 'Malia is only available to licensed stylist',
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.clusterwhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        })

      ),
    );
  }
  Widget _sectionTitle(
      String title,
      Size screensize,
      ) {
    return Padding(padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
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
    return Padding(padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.015,),
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
    return Padding(padding: EdgeInsets.only(left: screensize.width * 0.04, right: screensize.width * 0.04, top: 12.h,),
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
    return Padding(padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04, top: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
    return Container(margin: EdgeInsets.symmetric(horizontal: screensize.width * 0.04),
      padding: EdgeInsets.only(bottom: 20.h),
      color: Colorstheam.clusterwhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
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
                children: <Widget>[
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
              HapticFeedback.heavyImpact();
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
      margin: EdgeInsets.symmetric(horizontal: screensize.width * 0.04),
      padding: EdgeInsets.only(bottom: 20.h),
      color: Colorstheam.clusterwhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            image,
            width: double.infinity,
            height: 190.h,
            fit: BoxFit.cover,
          ),
          Padding(padding: EdgeInsets.only(left: screensize.width * 0.04, right: screensize.width * 0.04, top: 16.h),
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
              padding: EdgeInsets.only(left: screensize.width * 0.07,right: screensize.width * 0.04,top: 7.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
              HapticFeedback.heavyImpact();
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
    return Padding(padding: EdgeInsets.symmetric(horizontal: screensize.width * 0.04),
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
        HapticFeedback.heavyImpact();
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