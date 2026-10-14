// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/controller/collectioncontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Collectionview extends GetView<Collectioncontroller> {
  Collectionview({super.key});

  final List<String> mainCategories = [
    "Hair Extensions",
    "Hair Care",
    "Accessories",
    "The Length Club ",
  ];

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
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: screensize.width * 0.02),
                Text(
                    "Collections",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack
                  ),
                ),
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
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),

                  padding: EdgeInsets.only(
                    left: screensize.width * 0.055,
                    right: screensize.width * 0.055,
                    bottom: 40.h,
                  ),

                  itemCount: mainCategories.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 24.h,

                    // Image + text underneath
                    childAspectRatio: 0.72,
                  ),

                  itemBuilder: (context, index) {
                    return _gridCategory(
                      title: mainCategories[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ============================================================
  // EDITORIAL CATEGORY
  // ============================================================
  Widget _gridCategory({
    required String title,
    required int index,
  }) {
    final List<String> categoryImages = [
      "asset/image/collectionone.png",
      "asset/image/collection2.png",
      "asset/image/collection3.png",
      "asset/image/collection4.png",
    ];

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: 1,
      ),
      duration: Duration(
        milliseconds: 400 + (index * 100),
      ),
      curve: Curves.easeOutCubic,

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0,
            20.h * (1 - value),
          ),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },

      child: Obx(() {
        final bool selected =
            controller.selectedCollection.value == index;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,

          onTap: () {
            controller.selectCollection(index);

            final bottomNav =
            Get.find<Bottomnavigationcontroller>();

            bottomNav.selectedCollectionIndex.value = index;
            bottomNav.selectedCollectionName.value = title;

            bottomNav.selectedIndex.value = 1;
            bottomNav.currentPage.value =
                PageType.collectionlist;
          },

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ------------------------------------------
              // IMAGE
              // ------------------------------------------

              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colorstheam.nobelblack.withValues(
                      alpha: 0.04,
                    ),
                    border: Border.all(
                      color: selected
                          ? Colorstheam.nobelblack
                          : Colorstheam.nobelblack.withValues(
                        alpha: 0.10,
                      ),
                      width: selected ? 1.2 : 1,
                    ),
                  ),
                  child: Image.asset(
                    categoryImages[index],
                    width: 171.w,
                    height: 171.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 11.h),

              // ------------------------------------------
              // CATEGORY TEXT
              // ------------------------------------------

              Text(
                title.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 17.sp,
                  height: 1.05,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4,
                  color: Colorstheam.nobelblack,
                ),
              ),

              SizedBox(height: 5.h),

              // Minimal line
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                width: selected ? 32.w : 18.w,
                height: selected ? 2 : 1,
                color: Colorstheam.nobelblack.withValues(
                  alpha: selected ? 0.8 : 0.25,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  // ============================================================
  // BACK BUTTON
  // ============================================================

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: () {
        final bottomNav =
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