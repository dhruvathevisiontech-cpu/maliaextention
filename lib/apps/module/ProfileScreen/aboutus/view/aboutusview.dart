import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/aboutus/controller/aboutuscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Aboutusview extends GetView<Aboutuscontroller> {
  const Aboutusview({super.key});
  @override
  Widget build(BuildContext context) {
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
          toolbarHeight: 62.h,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.aboutustitle,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
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
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colorstheam.nobelblack,
              ),
            );
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(controller.errorMessage.value),
            );
          }
          if (controller.aboutData.isEmpty) {
            return const Center(
              child: Text('No About Us content available'),
            );
          }
          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 28.h),
                    decoration: BoxDecoration(
                      color: Colorstheam.clusterwhite,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _eyebrow(controller.text('hero_eyebrow')),
                        SizedBox(height: 22.h),
                        Text(
                          controller.text('hero_title'),
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 29.sp,
                            height: 1.18,
                            fontWeight: FontWeight.w800,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  _buildTextSection(
                    eyebrow: controller.text('about_eyebrow'),
                    title: controller.text('about_title'),
                    paragraphs: controller.stringList('about_paragraphs'),
                  ),
                  SizedBox(height: 30.h),
                  _buildTextSection(
                    eyebrow: controller.text('story_eyebrow'),
                    title: controller.text('story_title'),
                    paragraphs: controller.stringList('story_paragraphs'),
                  ),
                  SizedBox(height: 22.h),
                  _buildImage(
                    controller.text('about_image'),
                    aspectRatio: 0.9,
                  ),
                  SizedBox(height: 36.h),
                  _buildTextSection(
                    eyebrow: '',
                    title: controller.text('vision_title'),
                    paragraphs: [
                      controller.text('vision_description'),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  _buildTextSection(
                    eyebrow: '',
                    title: controller.text('mission_title'),
                    paragraphs: controller.stringList('mission_paragraphs'),
                  ),
                  SizedBox(height: 36.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _eyebrow('FOUNDER'),

                      SizedBox(height: 12.h),

                      Text(
                        controller.text('founder_name'),
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 29.sp,
                          fontWeight: FontWeight.w800,
                          color: Colorstheam.nobelblack,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      _buildImage(
                        controller.text('founder_image'),
                        aspectRatio: 0.9,
                      ),

                      SizedBox(height: 18.h),

                      ...controller.stringList('founder_paragraphs').map(
                            (paragraph) => Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Text(
                            paragraph,
                            style: _bodyStyle(),
                          ),
                        ),
                      ),

                      SizedBox(height: 6.h),

                      _buildImage(
                        controller.text('team_image'),
                        aspectRatio: 0.95,
                      ),

                      SizedBox(height: 20.h),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(18.w),
                        decoration: BoxDecoration(
                          color: Colorstheam.clusterwhite,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Fun Fact: ',
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontWeight: FontWeight.w700,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              TextSpan(
                                text: controller.text('founder_fun_fact'),
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontWeight: FontWeight.w400,
                                  color: Colorstheam.dimgrey,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            fontSize: 13.sp,
                            height: 1.85,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _eyebrow(
                        controller.text('quality_section_eyebrow'),
                      ),
                      SizedBox(height: 18.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: controller.stringList('quality_tags').map(
                              (tag) => _qualityTag(tag),
                        ).toList(),
                      ),
                      SizedBox(height: 24.h),
                      ...controller.objectList('quality_features').map(
                            (feature) => Padding(
                          padding: EdgeInsets.only(bottom: 28.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildImage(
                                feature['image']?.toString() ?? '',
                                aspectRatio: 0.95,
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                feature['number']?.toString() ?? '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colorstheam.dimgrey,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Text(
                                feature['title']?.toString() ?? '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18.sp,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 9.h),
                              Text(
                                feature['description']?.toString() ?? '',
                                style: _bodyStyle(),
                              ),
                              SizedBox(height: 18.h),
                              Container(
                                height: 1.h,
                                color: Colorstheam.clusterwhite,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(23.w),
                    decoration: BoxDecoration(
                      color: Colorstheam.nobelblack,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.text('why_malia_title'),
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: Colorstheam.white,
                          ),
                        ),

                        SizedBox(height: 19.h),

                        Text(
                          controller.text('why_malia_headline'),
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 25.sp,
                            height: 1.35,
                            fontWeight: FontWeight.w500,
                            color: Colorstheam.white,
                          ),
                        ),

                        SizedBox(height: 19.h),

                        Container(
                          width: 40.w,
                          height: 2.h,
                          color: Colorstheam.white,
                        ),

                        SizedBox(height: 18.h),

                        Text(
                          controller.text('why_malia_description'),
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13.sp,
                            height: 1.9,
                            color: Colorstheam.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildImage(
                    controller.text('class_image'),
                    aspectRatio: 0.9,
                  ),
                  SizedBox(height: 38.h),
                  _buildChallengeSection(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
  Widget _buildChallengeSection() {
    final priorities = controller.stringList('challenge_priorities');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow(
          controller.text('challenge_eyebrow'),
        ),

        SizedBox(height: 12.h),

        Text(
          controller.text('challenge_title'),
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 29.sp,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),

        SizedBox(height: 22.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 17.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colorstheam.clusterwhite,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            children: priorities.map((priority) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'asset/svg/verified.svg',
                      width: 22.w,
                      height: 22.w,
                    ),

                    SizedBox(width: 13.w),

                    Expanded(
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 13.sp,
                          height: 1.65,
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.burntearth,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  Widget _buildTextSection({
    required String eyebrow,
    required String title,
    required List<String> paragraphs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow.isNotEmpty) ...[
          _eyebrow(eyebrow),
          SizedBox(height: 12.h),
        ],
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 27.sp,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 15.h),
        ...paragraphs.map(
              (paragraph) => Padding(
            padding: EdgeInsets.only(bottom: 13.h),
            child: Text(
              paragraph,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 13.5.sp,
                height: 1.85,
                fontWeight: FontWeight.w400,
                color: Colorstheam.dimgrey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _qualityTag(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 9.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colorstheam.clusterwhite),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Colorstheam.nobelblack,
        ),
      ),
    );
  }


  // Shared image widget
  Widget _buildImage(
      String url, {
        required double aspectRatio,
      }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image.network(
          url,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;

            return Container(
              color: Colorstheam.clusterwhite,
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colorstheam.nobelblack,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colorstheam.clusterwhite,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_outlined,
                size: 30.sp,
                color: Colorstheam.dimgrey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _eyebrow(String title) {
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 1.5.h,
          color: Colorstheam.nobelblack,
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Colorstheam.dimgrey,
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _bodyStyle() {
    return TextStyle(
      fontFamily: 'DMSans',
      fontSize: 13.5.sp,
      height: 1.85,
      fontWeight: FontWeight.w400,
      color: Colorstheam.dimgrey,
    );
  }

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 12.w,
            height: 12.w,
            colorFilter: ColorFilter.mode(
              Colorstheam.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}