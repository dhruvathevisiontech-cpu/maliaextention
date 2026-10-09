import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Orderplaceview extends GetView<Orderplacecontroller> {
  const Orderplaceview({Key? key}) : super(key: key);

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
                  Apptext.orderplacedtitle,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "asset/svg/orderplaced.svg",
                height: 80.h,
                width: 80.w,
              ),
            ),
            SizedBox(height: screensize.height * 0.01),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "DMSans",
                  color: Colorstheam.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: screensize.height * 0.001),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Order has been placed successfully.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.nobelblack,
                ),
              ),
            )
          ],
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