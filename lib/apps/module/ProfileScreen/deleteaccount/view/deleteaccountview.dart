import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/ProfileScreen/deleteaccount/controller/deleteaccountcontroller.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Deleteaccountview extends GetView<Deleteaccountcontroller> {
  Deleteaccountview({super.key});
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
                    Apptext.deleteaccounttitle,
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: screensize.width * 0.03,
                  right: screensize.width * 0.03,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w300,
                        color: Colorstheam.black,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text:
                          "If you would like to permanently delete your PTJ Shoes account and associated personal data, please send an email to ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.black
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              //controller.openEmail();
                            },
                            child: Text(
                              "info@maliaextensions.com",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: "DMSans",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colorstheam.grey,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text:
                          " with the subject ""Delete My Account"".",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w300,
                              color: Colorstheam.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.03,right: screensize.width * 0.03,top: screensize.height * 0.005),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Once we receive your request, we will verify your account and process the deletion within 7 business days",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w300,
                        color: Colorstheam.black
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.03,right: screensize.width * 0.03,top: screensize.height * 0.005),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "After your request has been processed, your PTJ Shoes account and all associated personal data will be permanently deleted and cannot be recovered.",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w300,
                        color: Colorstheam.black
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.015),

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
