import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/gallary/controller/gallarycontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Gallaryview extends GetView<Gallarycontroller> {
  const Gallaryview({Key? key}) : super(key: key);

  static const List<String> galleryImages = [
    'asset/image/sliderimage.png',
    'asset/image/image2.jpg',
    'asset/image/image3.jpg',
    'asset/image/sliderimage.png',
  ];

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _galleryCard(
                            image: galleryImages[0],
                            height: 285.h,
                            label: '',
                            index: 0,
                          ),
                          SizedBox(height: 12.h),
                          _galleryCard(
                            image: galleryImages[1],
                            height: 215.h,
                            label: '',
                            index: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 44.h),
                          _galleryCard(
                            image: galleryImages[2],
                            height: 250.h,
                            label: '',
                            index: 2,
                          ),
                          SizedBox(height: 12.h),
                          _galleryCard(
                            image: galleryImages[3],
                            height: 250.h,
                            label: '',
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => _GalleryPreview(
            images: galleryImages,
            initialIndex: index,
          ),
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
              Image.asset(
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

              // Subtle bottom gradient
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
                left: 12.w,
                right: 10.w,
                bottom: 13.h,
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: Colorstheam.white,
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
              child: Image.asset(
                widget.images[index],
                fit: BoxFit.contain,
                width: double.infinity,
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