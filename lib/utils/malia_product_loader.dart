  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:maliaextention/color/colorstheam.dart';
  class MaliaProductLoader extends StatefulWidget {
    const MaliaProductLoader({super.key});
    @override
    State<MaliaProductLoader> createState() => _MaliaProductLoaderState();
  }
  class _MaliaProductLoaderState extends State<MaliaProductLoader> {
    static const List<String> _icons = [
      'asset/svg/loader/loader_scissors.svg',
      'asset/svg/loader/loader_hair.svg',
      'asset/svg/loader/loader_droplet.svg',
      'asset/svg/loader/loader_sparkles.svg',
      'asset/svg/loader/loader_ruler.svg',
      'asset/svg/loader/loader_gem.svg',
    ];
    static const int _initialPage = 10000;
    late final PageController _pageController;
    Timer? _scrollTimer;
    @override
    void initState() {
      super.initState();
      _pageController = PageController(
        initialPage: _initialPage,
        viewportFraction: 0.24,
      );
      _startIconAnimation();
    }
    void _startIconAnimation() {
      _scrollTimer = Timer.periodic(const Duration(milliseconds: 1250), (timer) {
          if (!mounted || !_pageController.hasClients) return;
          final currentPage = (_pageController.page ?? _initialPage.toDouble()).round();
          _pageController.animateToPage(
            currentPage + 1,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          );
        },
      );
    }
    @override
    void dispose() {
      _scrollTimer?.cancel();
      _pageController.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colorstheam.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final iconPath = _icons[index % _icons.length];
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            final currentPage = _pageController.hasClients ? (_pageController.page ?? _initialPage.toDouble()) : _initialPage.toDouble();
                            final distance = (currentPage - index).abs();
                            final scale = (1.0 - distance * 0.15).clamp(0.82, 1.0);
                            final opacity = (1.0 - distance * 0.30).clamp(0.35, 1.0);
                            final isCenter = distance < 0.45;
                            return Center(
                              child: Opacity(
                                opacity: opacity,
                                child: Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    width: 44.w,
                                    height: 44.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isCenter
                                          ? Colorstheam.nobelblack
                                          .withOpacity(0.07)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      iconPath,
                                      width: 25.w,
                                      height: 25.w,
                                      colorFilter: ColorFilter.mode(
                                        isCenter
                                            ? Colorstheam.nobelblack
                                            : Colorstheam.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'Preparing your experience...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    'Just a moment',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      color: Colorstheam.dimgrey,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: SizedBox(
                      height: 3.h,
                      child: LinearProgressIndicator(
                        backgroundColor: Colorstheam.lightgrey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }