// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/controller/inpersoncontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Inpersonview extends GetView<Inpersoncontroller> {
  const Inpersonview({super.key});

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
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Master Hair Extensions In Person",
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
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Reserve your place in an upcoming class to learn, practice, and build confidence through immersive, hands-on training.",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.03,),
              _classCard(
                date: "9th Nov",
                location: "Derry, NH",
                ticket: "Vip Ticket • 10AM–3PM",
                description: "Students will learn everything from foundational installation to technique refinement, taught step-by-step by a certified Malia Extensions Educator.",
                price: "\$699.00",
                context: context,
                onTap: () {

                },
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: SizedBox(
                  height: 152.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colorstheam.nobelblack.withValues(alpha: 0.4),
                            border: Border.all(
                              width: 0.6,
                              color: Colorstheam.nobelblack.withValues(alpha: 0.4),
                            )
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Registration Will Coming Soon - Join the Notification List Below",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600,
                                color: Colorstheam.clusterwhite
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: Colorstheam.clusterwhite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Derry, NH",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.nobelblack.withValues(alpha: 0.4)
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w500,
                                      color: Colorstheam.nobelblack.withValues(alpha: 0.4)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.03),
                child: Image.asset(
                  "asset/image/image03.png"
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Host a class in your city.",
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
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "We partner with select salons to host Butterfly Method education experiences across the country. These classes are designed for stylists who value elevated education, intentional growth, and modern extension techniques that prioritize efficiency, comfort, and results.",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screensize.width * 0.04,
                ),
                child: AnimatedButton(
                  onTap: (){
                    final bottomNav = Get.find<Bottomnavigationcontroller>();
                    bottomNav.selectedIndex.value = 3;
                    bottomNav.currentPage.value = PageType.hostclass;
                  },
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
                        "Submit Request",
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
              ),
              SizedBox(height: screensize.height * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Divider(
                  height: 2,
                  color: Colorstheam.nobelblack,
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
  Widget _classCard({
    required String date,
    required String location,
    required String ticket,
    required String description,
    required String price,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          // ============================================================
          // MAIN CARD
          // ============================================================
          Container(
            margin: EdgeInsets.only(top: 25.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F0EA),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screensize.height * 0.055),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
                SizedBox(height: screensize.height * 0.005),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    ticket,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
                SizedBox(height: screensize.height * 0.005),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w400,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
                SizedBox(height: screensize.height * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          final bottomNav = Get.find<Bottomnavigationcontroller>();
                          bottomNav.selectedIndex.value = 3;
                          bottomNav.currentPage.value = PageType.viewclass;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: screensize.width * 0.04),
                          child: Container(
                            height: 40.h,
                            width: 175.w,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFF242426),
                            ),
                            child: Text(
                              "View Class Details",
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
                    ),
                    SizedBox(width: 20.w),
                    Padding(
                      padding: EdgeInsets.only(right: screensize.width * 0.04),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child:  Text(
                          price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screensize.height * 0.02),
              ],
            ),
          ),

          // ============================================================
          // DATE BADGE
          // ============================================================
          Positioned(
            top: 0,
            left: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 13.h,
              ),
              decoration:  BoxDecoration(
                color: Colorstheam.burntearth,
              ),
              child: Text(
                date,
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
    );
  }
  // ============================================================
  // HEADER ICON
  // ============================================================

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
