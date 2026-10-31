import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/gallary/controller/gallarycontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
class Gallaryview extends GetView<Gallarycontroller> {
  const Gallaryview({super.key});

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
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 64.h,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 15.w),
                Text(
                  Apptext.gallerytitle,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                    letterSpacing: -0.4,
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPERIENCE THE MALIA DIFFERENCE',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        letterSpacing: -0.8,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      'More than a new hairstyle, It\'s a transformation that reflects the best version of you.',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 13.sp,
                        height: 1.6,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Obx(() {
                final images = controller.galleryImages;

                if (controller.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colorstheam.dimgrey,
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                }

                if (images.isEmpty) {
                  return Center(
                    child: Text(
                      'No gallery images available',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colorstheam.dimgrey,
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 0; i < images.length; i += 2)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _galleryCard(
                                  image: images[i],
                                  height: i == 0 ? 285.h : 215.h,
                                  label: '',
                                  index: i,
                                  images: images,
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // RIGHT COLUMN
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 44.h),

                            for (int i = 1; i < images.length; i += 2)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _galleryCard(
                                  image: images[i],
                                  height: i == 1 ? 250.h : 215.h,
                                  label: '',
                                  index: i,
                                  images: images,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }


  Widget _galleryCard({
    required String image,
    required double height,
    required String label,
    required int index,
    required List<String> images,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();

        Get.to(
              () => _GalleryPreview(
            images: images,
            initialIndex: index,
          ),
          transition: Transition.fadeIn,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colorstheam.lightgrey,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      size: 30.sp,
                      color: Colorstheam.dimgrey,
                    ),
                  );
                },
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 95.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colorstheam.black.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: Colorstheam.white.withValues(alpha: 0.90),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.open_in_full_rounded,
                    size: 13.sp,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
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
        bottomNav.currentPage.value = PageType.profile;
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


class _GalleryPreview extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _GalleryPreview({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_GalleryPreview> createState() => _GalleryPreviewState();
}

class _GalleryPreviewState extends State<_GalleryPreview> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;

    _pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorstheam.black,
      appBar: AppBar(
        backgroundColor: Colorstheam.black,
        foregroundColor: Colorstheam.white,
        elevation: 0,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 13.sp,
            color: Colorstheam.white,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Center(
              child: Image.network(
                widget.images[index],
                fit: BoxFit.contain,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colorstheam.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported_outlined,
                    size: 45.sp,
                    color: Colorstheam.white,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
