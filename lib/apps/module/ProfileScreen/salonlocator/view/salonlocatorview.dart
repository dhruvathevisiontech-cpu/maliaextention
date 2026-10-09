import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/controller/salonlocatorcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Salonlocatorview extends GetView<Salonlocatorcontroller> {
  const Salonlocatorview({Key? key}) : super(key: key);
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
                  Apptext.salonlocatortitle,
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
          children: <Widget>[

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