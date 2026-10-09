// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/controller/searchcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Searchview extends GetView<Searchdatacontroller> {
  Searchview({super.key});
  final List<String> recentSearches = [
    "Butterfly Weft",
    "Genius Weft",
    "K-Tips",
    "Tape Wefts",
  ];
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
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

            leadingWidth: 60.w,

            leading: Padding(
              padding: EdgeInsets.only(
                left: screensize.width * 0.04,
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                borderRadius: BorderRadius.circular(100.r),
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.home;
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colorstheam.black,
                    border: Border.all(
                      color: Colorstheam.black,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "asset/svg/arrowleft.svg",
                      width: 10.w,
                      height: 10.h,
                    ),
                  ),
                ),
              ),
            ),

            title: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(
                    (1 - value) * 30.w,
                    0,
                  ),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: screensize.width * 0.02,
                ),
                child: Container(
                  height: 46.h,
                  margin: EdgeInsets.only(
                    right: screensize.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      color: Colorstheam.clusterwhite
                    )
                  ),
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack,
                    ),
                    cursorColor: Colorstheam.nobelblack,
                    decoration: InputDecoration(
                      hintText: "Search hair extensions...",
                      hintStyle: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.lightgrey,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: 14.w,
                          right: 10.w,
                        ),
                        child: SvgPicture.asset(
                          "asset/svg/search.svg",
                          width: 18.w,
                          height: 18.h,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 42.w,
                        minHeight: 46.h,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: 14.w,
                          right: 10.w,
                        ),
                        child: SvgPicture.asset(
                          "asset/svg/mic.svg",
                          width: 18.w,
                          height: 18.h,
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 45.w,
                        minHeight: 46.h,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,top: screensize.height * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Serches".toUpperCase(),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "DMSans",
                        color: Colorstheam.arabiangrey
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: screensize.width * 0.04,
                  ),
                  itemCount: recentSearches.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colorstheam.clusterwhite
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            recentSearches[index],
                            style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}
