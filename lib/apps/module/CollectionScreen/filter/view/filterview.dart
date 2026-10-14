// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/controller/filtercontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Filterview extends GetView<Filtercontroller> {
  const Filterview({super.key});

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

        // ============================================================
        // APP BAR
        // ============================================================

        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Text(
              Apptext.filtertitle,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: screensize.width * 0.04,
                top: screensize.height * 0.01,
              ),
              child: _headerIcon(
                icon: "asset/svg/close.svg",
                onTap: () {
                  final bottomNav =
                  Get.find<Bottomnavigationcontroller>();

                  bottomNav.selectedIndex.value = 1;
                  bottomNav.currentPage.value =
                      PageType.collectionlist;
                },
              ),
            ),
          ],
        ),

        // ============================================================
        // BODY
        // ============================================================

        body: Column(
          children: <Widget>[
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: Colorstheam.clusterwhite,
            ),

            Expanded(
              child: Row(
                children: [

                  // ======================================================
                  // LEFT SIDE - CATEGORIES
                  // ======================================================

                  Container(
                    width: 120.w,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colorstheam.clusterwhite,
                          width: 1.w,
                        ),
                      ),
                    ),

                    child: Obx(
                          () {
                        final int selectedIndex =
                            controller.selectedCategoryIndex.value;

                        return ListView.builder(
                          itemCount: controller.categories.length,

                          itemBuilder: (
                              context,
                              index,
                              ) {
                            final category =
                            controller.categories[index];

                            final bool isSelected =
                                selectedIndex == index;

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,

                              onTap: () {
                                controller
                                    .selectedCategoryIndex
                                    .value = index;
                              },

                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 220,
                                ),
                                curve: Curves.easeOutCubic,

                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 16.w,
                                ),

                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colorstheam.nobelblack
                                      .withValues(alpha: 0.04)
                                      : Colors.transparent,

                                  border: Border(
                                    left: BorderSide(
                                      color: isSelected
                                          ? Colorstheam.nobelblack
                                          : Colors.transparent,
                                      width: 2.w,
                                    ),
                                  ),
                                ),

                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(
                                    milliseconds: 180,
                                  ),
                                  curve: Curves.easeOutCubic,

                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colorstheam.nobelblack
                                        : Colorstheam.nobelblack
                                        .withValues(alpha: 0.5),
                                  ),

                                  child: Text(
                                    category.title,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // ======================================================
                  // RIGHT SIDE - OPTIONS
                  // ======================================================

                  Expanded(
                    child: Obx(
                          () {
                        final int selectedIndex =
                            controller.selectedCategoryIndex.value;

                        final selectedCategory =
                        controller.categories[selectedIndex];

                        final options =
                            controller.filterOptions[
                            selectedCategory.type] ??
                                [];

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 16.w,
                          ),

                          itemCount: options.length,

                          itemBuilder: (
                              context,
                              index,
                              ) {
                            final option = options[index];

                            final bool isChecked =
                            controller.isOptionSelected(
                              selectedCategory.type,
                              option.id,
                            );

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,

                              onTap: () {
                                controller.toggleOption(
                                  selectedCategory.type,
                                  option.id,
                                );
                              },

                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 220,
                                ),
                                curve: Curves.easeOutCubic,

                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                ),

                                child: Row(
                                  children: [

                                    // ==================================
                                    // PREMIUM CHECKBOX
                                    // ==================================

                                    AnimatedScale(
                                      scale: isChecked ? 1.05 : 1.0,

                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),

                                      curve: Curves.easeOutBack,

                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 220,
                                        ),

                                        curve: Curves.easeOutCubic,

                                        width: 18.w,
                                        height: 18.w,

                                        decoration: BoxDecoration(
                                          color: isChecked
                                              ? Colorstheam.nobelblack
                                              : Colorstheam.white,

                                          border: Border.all(
                                            color:
                                            Colorstheam.nobelblack,
                                            width: 1.5,
                                          ),

                                          boxShadow: isChecked
                                              ? [
                                            BoxShadow(
                                              color: Colorstheam
                                                  .nobelblack
                                                  .withValues(alpha:
                                                0.15,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 0,
                                              offset:
                                              const Offset(
                                                0,
                                                3,
                                              ),
                                            ),
                                          ]
                                              : [],
                                        ),

                                        child: AnimatedSwitcher(
                                          duration: const Duration(
                                            milliseconds: 220,
                                          ),

                                          reverseDuration:
                                          const Duration(
                                            milliseconds: 120,
                                          ),

                                          switchInCurve:
                                          Curves.easeOutBack,

                                          switchOutCurve:
                                          Curves.easeIn,

                                          transitionBuilder: (
                                              Widget child,
                                              Animation<double>
                                              animation,
                                              ) {
                                            return ScaleTransition(
                                              scale: animation,
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              ),
                                            );
                                          },

                                          child: isChecked
                                              ? Center(
                                            key: const ValueKey(
                                              'checked',
                                            ),
                                            child:
                                            SvgPicture.asset(
                                              "asset/svg/checkright.svg",
                                              height: 7.5.h,
                                              width: 10.w,
                                            ),
                                          )
                                              : const SizedBox(
                                            key: ValueKey(
                                              'unchecked',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 12.w,
                                    ),

                                    // ==================================
                                    // LABEL
                                    // ==================================

                                    Expanded(
                                      child:
                                      AnimatedDefaultTextStyle(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),

                                        curve:
                                        Curves.easeOutCubic,

                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "DMSans",
                                          fontWeight:
                                          isChecked
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          color: Colorstheam
                                              .nobelblack,
                                        ),

                                        child: Text(
                                          option.label,
                                        ),
                                      ),
                                    ),

                                    // ==================================
                                    // COUNT
                                    // ==================================

                                    if (option.count != null)
                                      AnimatedDefaultTextStyle(
                                        duration:
                                        const Duration(
                                          milliseconds: 180,
                                        ),

                                        curve:
                                        Curves.easeOutCubic,

                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "DMSans",
                                          fontWeight:
                                          isChecked
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          color: Colorstheam
                                              .nobelblack,
                                        ),

                                        child: Text(
                                          '${option.count}',
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ============================================================
            // BOTTOM DIVIDER
            // ============================================================

            Divider(
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),

            // ============================================================
            // BOTTOM BUTTONS
            // ============================================================

            Padding(
              padding: EdgeInsets.all(16.w),

              child: Obx(
                    () => Row(
                  children: <Widget>[

                    // ====================================================
                    // RESET BUTTON
                    // ====================================================

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedButton.value = 0;

                          controller.resetFilters();
                        },

                        child: AnimatedScale(
                          scale:
                          controller.selectedButton.value == 0
                              ? 1.02
                              : 1.0,

                          duration: const Duration(
                            milliseconds: 180,
                          ),

                          curve: Curves.easeOutCubic,

                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 220,
                            ),

                            curve: Curves.easeOutCubic,

                            height: 40.h,

                            decoration: BoxDecoration(
                              color:
                              controller.selectedButton.value == 0
                                  ? Colorstheam.nobelblack
                                  : Colors.white,

                              border: Border.all(
                                color: Colorstheam.nobelblack,
                                width: 1.w,
                              ),

                              boxShadow:
                              controller.selectedButton.value == 0
                                  ? [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha:
                                    0.12,
                                  ),
                                  blurRadius: 12,
                                  spreadRadius: 0,
                                  offset: const Offset(
                                    0,
                                    5,
                                  ),
                                ),
                              ]
                                  : [],
                            ),

                            child: Center(
                              child:
                              AnimatedDefaultTextStyle(
                                duration: const Duration(
                                  milliseconds: 180,
                                ),

                                curve: Curves.easeOutCubic,

                                style: TextStyle(
                                  color: controller
                                      .selectedButton
                                      .value ==
                                      0
                                      ? Colors.white
                                      : Colorstheam.nobelblack,
                                  fontSize: 14.sp,
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                ),

                                child: const Text(
                                  'Reset',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 12.w,
                    ),

                    // ====================================================
                    // APPLY BUTTON
                    // ====================================================

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedButton.value = 1;

                          controller.applyFilters();
                        },

                        child: AnimatedScale(
                          scale:
                          controller.selectedButton.value == 1
                              ? 1.02
                              : 1.0,

                          duration: const Duration(
                            milliseconds: 180,
                          ),

                          curve: Curves.easeOutCubic,

                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 220,
                            ),

                            curve: Curves.easeOutCubic,

                            height: 40.h,

                            decoration: BoxDecoration(
                              color:
                              controller.selectedButton.value == 1
                                  ? Colorstheam.nobelblack
                                  : Colors.white,

                              border: Border.all(
                                color: Colorstheam.nobelblack,
                                width: 1.w,
                              ),

                              boxShadow:
                              controller.selectedButton.value == 1
                                  ? [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha:
                                    0.12,
                                  ),
                                  blurRadius: 12,
                                  spreadRadius: 0,
                                  offset: const Offset(
                                    0,
                                    5,
                                  ),
                                ),
                              ]
                                  : [],
                            ),

                            child: Center(
                              child:
                              AnimatedDefaultTextStyle(
                                duration: const Duration(
                                  milliseconds: 180,
                                ),

                                curve: Curves.easeOutCubic,

                                style: TextStyle(
                                  color: controller
                                      .selectedButton
                                      .value ==
                                      1
                                      ? Colors.white
                                      : Colorstheam.nobelblack,
                                  fontSize: 14.sp,
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                ),

                                child: const Text(
                                  'Apply',
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
          ],
        ),
      ),
    );
  }

  // ================================================================
  // HEADER ICON
  // ================================================================

  Widget _headerIcon({
    required String icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: onTap,

      child: SizedBox(
        width: 26.25.w,
        height: 26.25.w,

        child: SvgPicture.asset(
          icon,
          width: 26.25.w,
          height: 26.25.w,
        ),
      ),
    );
  }
}
