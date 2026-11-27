
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/controller/faqlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Faqlistview extends GetView<Faqlistcontroller> {
  Faqlistview({super.key});

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

        // APP BAR
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          toolbarHeight: 60.h,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screensize.width * 0.045,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.faqlisttitle,
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
        ),

        // BODY
        body: SafeArea(
          top: false,
          child: Obx(() {
            // LOADING
            if (controller.isLoading.value &&
                controller.faqList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // ERROR
            if (controller.errorMessage.value.isNotEmpty &&
                controller.faqList.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 42.sp,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Unable to load FAQs',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      TextButton(
                        onPressed: controller.fetchFaqs,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // FAQ CONTENT
            return RefreshIndicator(
              onRefresh: controller.refreshFaqs,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  26.h,
                  20.w,
                  28.h,
                ),
                children: [

                  // INTRODUCTION
                  Text(
                    'WE’RE HERE TO HELP',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      color: Colorstheam.Racingred,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    "EVERYTHING YOU NEED TO KNOW",
                    style: TextStyle(
                      fontSize: 31.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      height: 1.13,
                      letterSpacing: -0.8,
                      color: Colorstheam.nobelblack,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Everything you need to know, all in one place. Explore our FAQs for quick and helpful answers.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      height: 1.65,
                      color: Colorstheam.nobelblack,
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // SECTION HEADER
                  Row(
                    children: [
                      Text(
                        'General Questions',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: Colorstheam.nobelblack,
                        ),
                      ),

                      const Spacer(),

                      Obx(() {
                        final count =
                            controller.filteredFaqs.length;

                        return Text(
                          '$count ARTICLES',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Colors.grey.shade500,
                          ),
                        );
                      }),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  // DYNAMIC FAQ LIST
                  _faqList(context),

                  SizedBox(height: 18.h),

                  // CONTACT CARD
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colorstheam.clusterwhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DISCOVER MORE IN FAQ’S?",
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            color: Colorstheam.nobelblack,
                          ),
                        ),

                        SizedBox(height: 7.h),

                        Text(
                          "Have more questions? Feel free to contact us at info@maliaextensions.com",
                          style: TextStyle(
                            height: 1.6,
                            fontSize: 13.sp,
                            color: Colorstheam.nobelblack,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 17.h),

                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: AnimatedButton(
                            onTap: () {
                              AppSnackbar.error(
                                'Connect your Contact Us page here.',
                              );
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colorstheam.nobelblack,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'CONTACT US',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    letterSpacing: 1.2,
                                    fontFamily: 'Urbanist',
                                    color: Colorstheam.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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


  Widget _faqList(BuildContext context) {
    return Obx(() {
      final faqs = controller.filteredFaqs;

      if (faqs.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 45.h),
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 42.sp,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 12.h),
              Text(
                'No questions found',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: List.generate(faqs.length, (index) {
          final faq = faqs[index];
          final bool isExpanded =
              controller.expandedIndex.value == index;

          return _faqItem(
            question: faq['question'] ?? '',
            answer: faq['answer'] ?? '',
            index: index,
            isExpanded: isExpanded,
          );
        }),
      );
    });
  }

  Widget _faqItem({
    required String question,
    required String answer,
    required int index,
    required bool isExpanded,
  }) {
    const BorderRadius borderRadius = BorderRadius.zero;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isExpanded
            ? Colorstheam.clusterwhite.withValues(alpha: 0.35)
            : Colorstheam.white,
        borderRadius: borderRadius,
        border: Border.all(
          color: isExpanded
              ? Colorstheam.nobelblack.withValues(alpha: 0.30)
              : const Color(0xFFEAEAEA),
          width: isExpanded ? 1.1 : 0.8,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              // QUESTION ROW
              InkWell(
                splashColor: Colorstheam.nobelblack.withValues(
                  alpha: 0.04,
                ),
                highlightColor: Colors.transparent,
                onTap: () {
                  HapticFeedback.lightImpact();

                  controller.expandedIndex.value =
                  isExpanded ? -1 : index;
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 19.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14.sp,
                            fontWeight: isExpanded
                                ? FontWeight.w800
                                : FontWeight.w700,
                            height: 1.4,
                            color: Colorstheam.nobelblack,
                          ),
                          child: Text(question),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // ANIMATED ARROW
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        width: 29.w,
                        height: 29.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isExpanded
                              ? Colorstheam.nobelblack
                              : Colorstheam.clusterwhite,
                        ),
                        child: Center(
                          child: AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutBack,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20.sp,
                              color: isExpanded
                                  ? Colorstheam.white
                                  : Colorstheam.nobelblack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ANIMATED ANSWER
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                reverseDuration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slideAnimation = Tween<Offset>(
                    begin: const Offset(0, -0.08),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return ClipRect(
                    child: SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1,
                      child: FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: isExpanded
                    ? Container(
                  key: ValueKey('answer_$index'),
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    0,
                    16.w,
                    19.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34.w,
                        height: 1.5.h,
                        margin: EdgeInsets.only(bottom: 13.h),
                        color: Colorstheam.Racingred.withValues(
                          alpha: 0.75,
                        ),
                      ),
                      Text(
                        answer,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 13.sp,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
                    : const SizedBox.shrink(
                  key: ValueKey('empty_answer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BACK BUTTON
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();

        final bottomNav =
        Get.find<Bottomnavigationcontroller>();

        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 11.w,
            height: 11.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
