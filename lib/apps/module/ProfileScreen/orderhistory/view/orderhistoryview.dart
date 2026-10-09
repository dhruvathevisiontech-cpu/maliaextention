import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/controller/orderhistorycontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Orderhistoryview extends GetView<Orderhistorycontroller> {
  const Orderhistoryview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return AnnotatedRegion(
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
            padding: EdgeInsets.only(left: screensize.width * 0.04),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 12.w),
                Text(
                  Apptext.orderhistorytitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 4;
                  bottomNav.currentPage.value = PageType.vieworder;
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colorstheam.lightgrey.withOpacity(0.15),
                        ),
                        child: Image.asset(
                          "asset/image/product1.png",
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: SizedBox(
                          height: 120.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "The Classic Butterfly Weft",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),

                              SizedBox(height: 7.h),

                              Text(
                                "26 Aug 2026 | 02:23 PM",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w300,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 7.h),

                              Text(
                                "\$245",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 4;
                  bottomNav.currentPage.value = PageType.vieworder;
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colorstheam.lightgrey.withOpacity(0.15),
                        ),
                        child: Image.asset(
                          "asset/image/product2.png",
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: SizedBox(
                          height: 120.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Genius Weft",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Text(
                                "26 Aug 2026 | 02:23 PM",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w300,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Text(
                                "\$245",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
        bottomNav.selectedIndex.value = 0;
        bottomNav.currentPage.value = PageType.viewcart;
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