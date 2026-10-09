// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/controller/productdetailscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Productdetailsview extends GetView<Productdetailscontroller> {
  Productdetailsview({super.key});
  final List<Map<String, String>> products = [
    {
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    final images = [
      "asset/image/product1.png",
      "asset/image/product2.png",
      "asset/image/product1.png",
      "asset/image/product2.png",
      "asset/image/product1.png",
      "asset/image/product2.png",
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: RefreshIndicator(
        color: Colorstheam.clusterwhite,
        backgroundColor: Colorstheam.nobelblack,
        onRefresh: () async{
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
        },
        child: Scaffold(
          backgroundColor: Colorstheam.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colorstheam.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.only(
                left: screensize.width * 0.04,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 1;
                  bottomNav.currentPage.value = PageType.collectionlist;
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
              )
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 402.h,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        CarouselSlider.builder(
                          carouselController: controller.carouselController,
                          itemCount: images.length,
                          itemBuilder: (
                              context,
                              index,
                              realIndex,
                              ) {
                            return SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 402.h,
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 700),
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              controller.currentIndex.value = index;
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 20.h,
                          left: 0,
                          right: 0,
                          child: Obx(() {
                            final currentIndex = controller.currentIndex.value;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Center(
                                child: Container(
                                  height: 60.h,
                                  color: Colorstheam.white,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: images.length,
                                    itemBuilder: (context, index) {
                                      final selected = currentIndex == index;
                                      return GestureDetector(
                                        onTap: () {
                                          controller.carouselController.animateToPage(
                                            index,
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            curve: Curves.easeInOut,
                                          );

                                          controller.currentIndex.value = index;
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          width: 60.w,
                                          height: 60.w,
                                          padding: EdgeInsets.all(2.w),
                                          decoration: BoxDecoration(
                                            color: Colorstheam.white,
                                          ),
                                          child: Image.asset(
                                            images[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
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
                                      : Colors.black.withValues(
                                    alpha: 0.35,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    transitionBuilder:
                                        (child, animation) {
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
                        )
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -24.h),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colorstheam.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: screensize.height * 0.03,left: screensize.width * 0.04,right: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Genius Weft",
                                        style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 24.sp,
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
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "45 Minutes",
                                    style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Colorstheam.burntearth,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "\$265.00",
                                      style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 20.h,
                                      width: 99.w,
                                      color: Colorstheam.nobelblack,
                                      child: Center(
                                        child: Text(
                                          "PRO PRICING",
                                          style: TextStyle(
                                            fontFamily: "DMSans",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colorstheam.clusterwhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                              Obx(() {
                                final selectedIndex = controller.selectedLength.value;
                                return Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Length: ",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.nobelblack,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text: controller.lengths[selectedIndex],
                                              style: TextStyle(
                                                fontFamily: "DMSans",
                                                fontSize: 14.sp,
                                                color: Colorstheam.arabiangrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10.h),

                                      Row(
                                        children: List.generate(
                                          controller.lengths.length,
                                              (index) {
                                            final selected = selectedIndex == index;

                                            return Padding(
                                              padding: EdgeInsets.only(right: 8.w),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.selectedLength.value = index;
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 200),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 18.w,
                                                    vertical: 11.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: selected
                                                        ? Colorstheam.nobelblack
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    controller.lengths[index],
                                                    style: TextStyle(
                                                      fontFamily: "DMSans",
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: selected
                                                          ? Colorstheam.clusterwhite
                                                          : Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      final selectedIndex = controller.selectedShade.value;

                                      return RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Shades: ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.nobelblack,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text: controller.shadeNames[selectedIndex],
                                              style: TextStyle(
                                                fontFamily: "DMSans",
                                                fontSize: 14.sp,
                                                color: Colorstheam.arabiangrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 12.h),
                                    Obx(() {
                                      final selectedIndex = controller.selectedShade.value;

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: controller.shades.length,

                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6,
                                          crossAxisSpacing: 8.w,
                                          mainAxisSpacing: 10.h,
                                          childAspectRatio: 1,
                                        ),

                                        itemBuilder: (context, index) {
                                          final selected = selectedIndex == index;
                                          return SizedBox(
                                            width: 52.w,
                                            height: 52.h,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.selectedShade.value = index;
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 180),
                                                width: 52.w,
                                                height: 52.h,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: selected
                                                        ? Colorstheam.burntearth
                                                        : Colors.transparent,
                                                    width: selected ? 6.w : 0,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  controller.shades[index],
                                                  width: 52.w,
                                                  height: 52.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Obx(() {
                                final selectedIndex = controller.selectedhairlength.value;
                                return Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Length: ",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontFamily: "DMSans",
                                                color: Colorstheam.nobelblack,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text: controller.hairlength[selectedIndex],
                                              style: TextStyle(
                                                fontFamily: "DMSans",
                                                fontSize: 14.sp,
                                                color: Colorstheam.arabiangrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: List.generate(
                                          controller.hairlength.length,
                                              (index) {
                                            final selected = selectedIndex == index;
                                            return Padding(
                                              padding: EdgeInsets.only(right: 8.w),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.selectedhairlength.value = index;
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 200),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 18.w,
                                                    vertical: 11.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: selected
                                                        ? Colorstheam.nobelblack
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    controller.hairlength[index],
                                                    style: TextStyle(
                                                      fontFamily: "DMSans",
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: selected
                                                          ? Colorstheam.clusterwhite
                                                          : Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Obx(() {
                                return Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.02),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 116.w,
                                        height: 40.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colorstheam.nobelblack,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              // Minus
                                              Expanded(
                                                child: InkWell(
                                                  onTap: controller.quantity.value > 1
                                                      ? controller.decreaseQty
                                                      : null,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      "asset/svg/minimize.svg",
                                                      width: 16.w,
                                                      height: 16.h,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Quantity
                                              SizedBox(
                                                width: 38.w,
                                                child: Center(
                                                  child: Text(
                                                    controller.quantity.value.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily: "DMSans",
                                                      fontWeight: FontWeight.w600,
                                                      color: Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Plus
                                              Expanded(
                                                child: InkWell(
                                                  onTap: controller.increaseQty,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      "asset/svg/plus.svg",
                                                      width: 16.w,
                                                      height: 16.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: AnimatedButton(
                                          onTap:controller.addToCart,
                                          child: Container(
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                                border: BoxBorder.all(
                                                    color: Colorstheam.clusterwhite,
                                                    width: 1
                                                )
                                            ),
                                            child: Center(
                                              child: AnimatedSwitcher(
                                                duration: const Duration(milliseconds: 250),
                                                child: Text(
                                                  "Add to cart".toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: "DMSans",
                                                    fontWeight: FontWeight.w700,
                                                    color: Colorstheam.nobelblack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.009),
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
                                          "buy now".toUpperCase(),
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
                              Obx(() {
                                final isExpanded = controller.isExpanded.value;
                                return Padding(
                                  padding: EdgeInsets.only(top: screensize.height * 0.02,left: screensize.width * 0.04,right: screensize.width * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colorstheam.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                        bottom: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                      ),
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
                                          "Product Details",
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
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 16.h,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "With the same quality hair as our Butterfly Wefts you’ve grown to love, Maliá is now offering Genius wefts. Wefts can be cut to customize to clients head, with zero return hair.",
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
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Each pack contains 2 wefts.",
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
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "18” is 20g Per Weft = 40g",
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
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "22” is 25g Per Weft = 50g",
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
                              Obx(() {
                                final isExpanded = controller.isExpanded.value;
                                return Padding(
                                  padding: EdgeInsets.only(top: screensize.height * 0.02,left: screensize.width * 0.04,right: screensize.width * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colorstheam.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                        bottom: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                      ),
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
                                          "Shipping Info",
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
                                            padding: EdgeInsets.only(
                                              bottom: 16.h,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Packages ordered M-F before 3 PM are shipped out the same day they are ordered. All Saturday packages and Sunday packages are shipped out on Monday.",
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
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "United States Shipping:",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.nobelblack,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "If you place your order before 3 PM, it will ship out the same day. All packages are shipped via UPS Ground or Next Day Air, and delivery times may vary depending on your location. Since we ship from Massachusetts, it can take up to 10 days to receive your package. 📦",
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
                                          SizedBox(height: screensize.height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "East Coast - 2-3 Days",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "Midwest- 2-5 Days",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "Rocky Mountains- 5-10 Days",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "West Coast- 5-8 Days",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: screensize.height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "International Shipping:",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.nobelblack,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "All International packages are shipped via DHL Express Worldwide and will arrive between 3-5 Days.",
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
                                          SizedBox(height: screensize.height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "If you have any issues with shipping, please email info@maliaextensions.com with your order number and shipping issue!",
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
                              Obx(() {
                                final isExpanded = controller.isExpanded.value;
                                return Padding(
                                  padding: EdgeInsets.only(top: screensize.height * 0.02,left: screensize.width * 0.04,right: screensize.width * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colorstheam.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                        bottom: BorderSide(
                                          color: Colorstheam.clusterwhite,
                                          width: 3.w,
                                        ),
                                      ),
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
                                          "Warranty Info",
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
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 16.h,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "At Malia Extensions, we stand behind the quality of every strand. Each piece of hair is carefully inspected in our warehouse before it leaves, ensuring it meets our premium standards.",
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
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Satisfaction Guaranteed:",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.nobelblack,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "If you receive hair that does not meet our quality promise, please notify us within 7 days of delivery for assistance.",
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
                                          SizedBox(height: screensize.height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Exclusions:",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "DMSans",
                                                  color: Colorstheam.nobelblack,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Our warranty does not cover issues that arise from:",
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
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "Custom coloring, lightening, or perming",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "Improper installation methods",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "DMSans",
                                                    color: Colorstheam.dimgrey,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    "Incorrect at-home care or use of non-recommended products",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "DMSans",
                                                      color: Colorstheam.dimgrey,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "To maintain your warranty, always follow Malia’s aftercare guidelines and use only professional, stylist-approved methods of installation and maintenance.",
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
                              SizedBox(
                                height: screensize.height * 0.01,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                                  child: Text(
                                    "Customer Reviews:",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "DMSans",
                                      color: Colorstheam.black
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01,),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                        "asset/svg/star.svg",
                                        width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                        "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                        "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                        "asset/svg/halfstar.svg",
                                        width: 20.w,
                                        height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Text(
                                      "4.9 out of 5",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                                  child: Text(
                                    "Based on 39 reviews",
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
                                  padding: EdgeInsets.only(left: screensize.width * 0.04),
                                  child: Text(
                                    "Collected by Judge.me",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "DMSans",
                                        color: Colorstheam.black,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Container(
                                      width: 156.w,
                                      height: 18.h,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              color: Colorstheam.yellow,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colorstheam.globalgrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screensize.width * 0.10),
                                    Text(
                                      "36",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        color: Colorstheam.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Container(
                                      width: 156.w,
                                      height: 18.h,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: Colorstheam.yellow,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              color: Colorstheam.globalgrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screensize.width * 0.10),
                                    Text(
                                      "3",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Container(
                                      width: 156.w,
                                      height: 18.h,
                                      color: Colorstheam.globalgrey,
                                    ),
                                    SizedBox(width: screensize.width * 0.10),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Container(
                                      width: 156.w,
                                      height: 18.h,
                                      color: Colorstheam.globalgrey,
                                    ),
                                    SizedBox(width: screensize.width * 0.10),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "asset/svg/star.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.015),
                                    SvgPicture.asset(
                                      "asset/svg/unfillstar.svg",
                                      width: 20.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: screensize.width * 0.02),
                                    Container(
                                      width: 156.w,
                                      height: 18.h,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: Colorstheam.yellow,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              color: Colorstheam.globalgrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screensize.width * 0.10),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w500,
                                          color: Colorstheam.black
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screensize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,top: screensize.height * 0.009),
                                child: AnimatedButton(
                                  onTap: () {
                                  },
                                  child: Container(
                                    height: 44.h,
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
                                          "Write a Review",
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
                                            bottomNav.currentPage.value =
                                                PageType.productdetails;
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
                                                      color: Colorstheam.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 4.h),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "LOGIN TO SEE PRICE",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontFamily: "DMSans",
                                                      fontWeight: FontWeight.w600,
                                                      color: Colorstheam.nobelblack,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Container(
                                                    height: 1.h,
                                                    width: 120.w,
                                                    color: Colorstheam.nobelblack,
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
                          )
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
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
