import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/controller/onlinetrainingviewclasscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Onlinetrainingviewclass extends GetView<Onlinetrainingviewclasscontroller>{

  final List<Map<String, String>> products = [
    {
      "image": "asset/image/image2.png",
      "name": "Online Education for The Freestyle It Method Tape Wefts",
      "Price": "\$299.00",
      "rating": "4.9",
    },
    {
      "image": "asset/image/ig4.png",
      "name": "Complete Starter Bundle (Online Education, Essentials Kit & Color Ring)",
      "Price": "\$150.00",
      "rating": "4.9",
    },
    {
      "image": "asset/image/image02.png",
      "name": "Online Education for The Freestyle It Method Tape Wefts",
      "Price": "\$299.00",
      "rating": "4.9",
    },
    {
      "image": "asset/image/image2.png",
      "name": "Complete Starter Bundle (Online Education, Essentials Kit & Color Ring)",
      "Price": "\$150.00",
      "rating": "4.9",
    },
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            children: <Widget>[
              SizedBox(
                height: 402.h,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        "asset/image/image02.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 16.h,
                      right: 16.w,
                      child: Obx(() {
                        final selected = controller.isWishlisted.value;

                        return GestureDetector(
                          onTap: controller.toggleWishlist,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colorstheam.nobelblack
                                  : Colors.black.withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: SvgPicture.asset(
                                  selected
                                      ? "asset/svg/heart_filled.svg"
                                      : "asset/svg/heart.svg",
                                  key: ValueKey(selected),
                                  width: 20.w,
                                  height: 20.w,
                                  colorFilter: ColorFilter.mode(
                                    Colorstheam.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screensize.height * 0.04,left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Online Education for The Butterfly Method",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 22.sp                                                                                                                                                                                                                                                                                                                                                                                                                                                                              .sp,
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      "asset/svg/star.svg",
                      width: 13.w,
                      height: 13.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "4.9",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Advanced • 2 Hours • Online Course • Lifetime Access",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.dimgrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                  child: Text(
                    "\$299.00",
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900,
                      color: Colorstheam.nobelblack,
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
                padding: EdgeInsets.only(
                  left: screensize.width * 0.04,
                  right: screensize.width * 0.04,
                  top: screensize.height * 0.02,
                ),
                child: Obx(
                      () => Row(
                    children: <Widget>[
                      Expanded(
                        child: AnimatedButton(
                          onTap: () {
                            controller.selectedAction.value = 0;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: controller.selectedAction.value == 0
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.white,
                              border: Border.all(
                                color: Colorstheam.nobelblack,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  "ADD TO CART",
                                  key: const ValueKey("add_to_cart"),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: controller.selectedAction.value == 0
                                        ? Colorstheam.white
                                        : Colorstheam.nobelblack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: AnimatedButton(
                          onTap: () {
                            controller.selectedAction.value = 1;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: controller.selectedAction.value == 1
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.white,
                              border: Border.all(
                                color: Colorstheam.nobelblack,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  "BUY NOW",
                                  key: const ValueKey("buy_now"),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                    color: controller.selectedAction.value == 1
                                        ? Colorstheam.white
                                        : Colorstheam.nobelblack,
                                  ),
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
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Divider(
                  height: 1,
                  color: Colorstheam.burntearth,
                ),
              ),
              Obx(() {
                final isExpanded = controller.isExpanded.value;
                return Padding(
                  padding: EdgeInsets.only(top: 0,left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colorstheam.white,
                    ),
                    child: Theme(
                      data: Theme.of(Get.context!).copyWith(
                        dividerColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 4.h,
                        ),
                        childrenPadding: EdgeInsets.zero,
                        shape: const Border(),
                        collapsedShape: const Border(),
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                        initiallyExpanded: false,
                        onExpansionChanged: (value) {
                          controller.isExpanded.value = value;
                        },
                        title: Text(
                          "About This Course",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        trailing: AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(
                            milliseconds: 250,
                          ),
                          child: SvgPicture.asset(
                            "asset/svg/plus.svg",
                            width: 18.w,
                            height: 18.h,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: screensize.height * 0.01),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Transform your craft and elevate your extension artistry with the Butterfly Method & Flutter Luxe Online Course - a complete start-to-finish education experience designed for stylists who want to work smarter, faster, and more luxuriously.",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.dimgrey,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screensize.height * 0.01),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "This immersive course walks you through every step of mastering The Butterfly Method - our exclusive 15-minute-per-row install technique - and introduces Flutter Luxe, the elevated hidden-bead weft designed for versatility, comfort, and seamless styling.",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.dimgrey,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screensize.height * 0.01),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Whether you’re brand-new to extensions or ready to refine your current method, this course breaks down every detail you need to know - from client consultation to maintenance and beyond.",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.dimgrey,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screensize.height * 0.01)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Image.asset(
                "asset/image/frame.png",
                height: 402.h,
                width: 402.w,
              ),
              Container(
                color: Colorstheam.clusterwhite,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01)                            ,
                        child: Text(
                          "What You'll Learn",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: "DMSans",
                            fontWeight:FontWeight.bold,
                            color: Colorstheam.nobelblack
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Text(
                          "In this comprehensive course, Maliá Founder and Extensions Expert Dimitra Louro walks you through everything Butterfly Weft Extensions. From preparation, to install, to pricing and maintenance. You'll walk away from this course feeling confident to add the Butterfly Weft to your services.",
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
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Preparing for the Install",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Tray setup, preparation, color matching, and how to utilize your Malia color ring for flawless shade selection.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Beads 101",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Choosing the right bead, placement strategy, and achieving a comfortable, damage-free foundation.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Client Management & Pricing",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Consultation expectations, paperwork, ideal client red flags, pricing structures, and how to confidently position your services.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Installation Mastery",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Complete step-by-step walkthroughs — from nape row to row one and the signature 3-point anchor method - all designed to speed up your installs without compromising quality.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Move-Ups & Maintenance",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Learn mini move-ups, dry-clean techniques, and best practices for long-term wear and client retention.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Tips, Tricks & Styling Secrets",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "Band blending, aftercare routines, creating client aftercare boxes, and styling techniques for photo-worthy results.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                      child: Divider(
                        height: 1,
                        color: Colorstheam.burntearth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                  "asset/svg/verified.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Flutter Luxe Install",
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                              top: 4.h,
                            ),
                            child: Text(
                              "A full introduction to Flutter Luxe vs. Butterfly Wefts, plus installation techniques for hidden-bead wefts and flawless ponytail styling.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DMSans",
                                color: Colorstheam.nobelblack,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Image.asset(
                  "asset/image/videoimage.png",
                  height: 242.h,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                  child: Text(
                    "Certification Perks!",
                    style: TextStyle(
                      fontSize: 22.sp,
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
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                  child: Text(
                    "Enjoy exclusive perks for being certified",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.dimgrey
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                  child: Text(
                    "While you don't need a certification to purchase our hair, a Malia Butterfly Method certification does give you access to some pretty amazing perks!",
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
                child: Container(
                  color: Colorstheam.clusterwhite,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screensize.width * 0.04,
                      right: screensize.width * 0.04,
                      top: screensize.height * 0.01,
                      bottom: screensize.height * 0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: SvgPicture.asset(
                                "asset/svg/verified.svg",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "5% Off All Butterfly Extensions",
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 32.w,
                            top: 4.h,
                          ),
                          child: Text(
                            "Save big and receive 5% off ALL Butterfly Weft Extensions.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "DMSans",
                              color: Colorstheam.nobelblack,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Container(
                  color: Colorstheam.clusterwhite,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                        bottom: screensize.height * 0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: SvgPicture.asset(
                                "asset/svg/verified.svg",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "Exclusive Flash Sales",
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 32.w,
                            top: 4.h,
                          ),
                          child: Text(
                            "Gain exclusive access to flash sales just for our certified stylists.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "DMSans",
                              color: Colorstheam.nobelblack,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Container(
                  color: Colorstheam.clusterwhite,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                        top: screensize.height * 0.01,
                        bottom: screensize.height * 0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: SvgPicture.asset(
                                "asset/svg/verified.svg",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "15% Off All Future Education",
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 32.w,
                            top: 4.h,
                          ),
                          child: Text(
                            "Enjoy 15% OFF all of our future online education and classes.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "DMSans",
                              color: Colorstheam.nobelblack,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.03),
                  child: Text(
                    "You May Also Like",
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
              SizedBox(
                height: 295.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SizedBox(
                        width: 176.w,
                        child: GestureDetector(
                          onTap: () {
                            final bottomNav =
                            Get.find<Bottomnavigationcontroller>();
                            bottomNav.selectedIndex.value = 1;
                            bottomNav.currentPage.value = PageType.productdetails;
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    child: Image.asset(
                                      product["image"]!,
                                      width: 176.w,
                                      height: 176.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Positioned(
                                    top: 10.h,
                                    right: 10.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Wishlist logic
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                        const Duration(milliseconds: 200),
                                        height: 34.h,
                                        width: 34.h,
                                        decoration: BoxDecoration(
                                          color: Colorstheam.nobelblack,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/heart.svg",
                                            height: 18.h,
                                            width: 18.w,
                                            color: Colorstheam.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                product["name"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),

                              SizedBox(height: 4.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product["Price"]!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.nobelblack,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "asset/svg/star.svg",
                                        height: 11.h,
                                        width: 12.w,
                                      ),
                                      SizedBox(width: screensize.width * 0.01),
                                      Text(
                                        product["rating"]!,
                                        style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.nobelblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 3;
        bottomNav.currentPage.value = PageType.onlinetraing;
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