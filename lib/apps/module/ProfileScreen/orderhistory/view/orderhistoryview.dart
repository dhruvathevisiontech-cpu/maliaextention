import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/controller/orderhistorycontroller.dart';

class Orderhistoryview extends GetView<Orderhistorycontroller> {
  const Orderhistoryview({Key? key}) : super(key: key);

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
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.orderhistorytitle,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
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
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR PURCHASES',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    color: Colorstheam.grey,
                  ),
                ),

                SizedBox(height: 12.h),

                Text(
                  'August 2026',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),

                SizedBox(height: 26.h),

                _timelineOrder(
                  productName: 'The Classic Butterfly Weft',
                  orderNumber: 'ORDER #001',
                  date: '26 Aug',
                  time: '02:23 PM',
                  price: '\$245.00',
                  imagePath: 'asset/image/product1.png',
                ),

                SizedBox(height: 24.h),

                _timelineOrder(
                  productName: 'Genius Weft',
                  orderNumber: 'ORDER #002',
                  date: '26 Aug',
                  time: '02:23 PM',
                  price: '\$245.00',
                  imagePath: 'asset/image/product2.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timelineOrder({
    required String productName,
    required String orderNumber,
    required String date,
    required String time,
    required String price,
    required String imagePath,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline
          SizedBox(
            width: 20.w,
            child: Column(
              children: [
                Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: Colorstheam.burntearth,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Container(
                    width: 1.w,
                    color: Colorstheam.clusterwhite,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Order content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date  ·  $time',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Colorstheam.grey,
                  ),
                ),

                SizedBox(height: 12.h),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _openOrderDetails,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100.w,
                        height: 118.h,
                        color: Colorstheam.lightgrey.withOpacity(0.15),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 26.sp,
                                color: Colorstheam.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              orderNumber,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: Colorstheam.grey,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              price,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View order',
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 13.sp,
                                  color: Colorstheam.nobelblack,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openOrderDetails() {
    HapticFeedback.selectionClick();
    final bottomNav = Get.find<Bottomnavigationcontroller>();
    bottomNav.selectedIndex.value = 4;
    bottomNav.currentPage.value = PageType.vieworder;
  }

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
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