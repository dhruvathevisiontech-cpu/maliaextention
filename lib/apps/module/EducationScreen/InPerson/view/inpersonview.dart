// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/controller/inpersoncontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';


class Inpersonview extends GetView<Inpersoncontroller> {
  const Inpersonview({super.key});

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
              children: <Widget>[
                _backButton(),
              ],
            ),
          ),
          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                HapticFeedback.heavyImpact();
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
          if (controller.isLoadingEducation.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.education.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    controller.educationError.value.isNotEmpty
                        ? controller.educationError.value
                        : "No education data found.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    onPressed: () {
                      controller.loadEducation();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          final classImage = controller.education['class_image']?.toString() ?? '';
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                    top: screensize.height * 0.02,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      controller.education['page_title']?.toString() ?? '',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.01),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      controller.education['page_description']?.toString() ?? '',
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
                  date: controller.education['class_date']?.toString() ?? '',
                  location: controller.education['class_location']?.toString() ?? '',
                  ticket: controller.education['ticket_details']?.toString() ?? '',
                  description: controller.education['class_description']?.toString() ?? '',
                  price: controller.education['class_price']?.toString() ?? '',
                  context: context,
                  onTap: () {},
                ),
                SizedBox(height: screensize.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      controller.education['coming_soon_title']?.toString() ?? '',
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
                      children: <Widget>[
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
                                controller.education['coming_soon_message']?.toString() ?? '',
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
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      controller.education['coming_soon_location']?.toString() ?? '',
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
                                      controller.education['coming_soon_description']?.toString() ?? '',
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
                  child: Image.network(
                    controller.education['class_image']?.toString() ?? '',
                  ),
                ),
                SizedBox(height: screensize.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      controller.education['host_title']?.toString() ?? '',
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
                      controller.education['host_description']?.toString() ?? '',
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
                      HapticFeedback.heavyImpact();
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
                          controller.education['host_button_text']?.toString() ?? '',
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
                    controller.education['gallery_title']?.toString() ?? '',
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
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                  ),
                  child: Row(
                    children: <Widget>[
                      for (int i = 0; i < 3; i++) ...[
                        if (i > 0)
                          SizedBox(width: screensize.width * 0.02),
                        Expanded(
                          child: Image.network(
                            controller.galleryImages[i],
                            width: 114.w,
                            height: 171.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: screensize.height * 0.015),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    controller.education['experience_title']?.toString() ?? '',
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
                    controller.education['experience_description']?.toString() ?? '',
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
                      child: controller.carouselImages.isEmpty
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Stack(
                        children: <Widget>[
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
                                  child: Image.network(
                                    controller.carouselImages[index],
                                    width: double.infinity,
                                    height: 300.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.broken_image),
                                      );
                                    },
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
                                          : Colorstheam.grey,
                                      borderRadius: BorderRadius.circular(10.r),
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
          );
        }),
      ),
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
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
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          HapticFeedback.heavyImpact();
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
