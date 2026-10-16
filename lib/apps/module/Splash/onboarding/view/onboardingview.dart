// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/Splash/onboarding/controller/onboardingcontroller.dart';

class Onboardingview extends GetView<Onboardingcontroller> {
  Onboardingview({super.key});
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
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Apptext.MainText,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist",
                      color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Apptext.onboardingsubtitle,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "DMSans",
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Obx(
                      () => AnimatedButton(
                    onTap: () async{
                      HapticFeedback.lightImpact();
                      controller.selectButton(0);
                      await Future.delayed(const Duration(milliseconds: 200));
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Container(
                      height: 44.h,
                      width: 362.w,
                      decoration: BoxDecoration(
                        color: controller.selectedButton.value == 0
                            ? Colorstheam.nobelblack
                            : Colorstheam.white,
                        border: Border.all(
                          color: Colorstheam.nobelblack,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Apptext.login,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: controller.selectedButton.value == 0
                                ? Colorstheam.white
                                : Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(height: screensize.height * 0.01,),
              Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                child: Obx(
                      () => AnimatedButton(
                    onTap: () async{
                      HapticFeedback.lightImpact();
                      controller.selectButton(1);
                      await Future.delayed(const Duration(milliseconds: 200));
                      Get.offAllNamed(Routes.ACCOUNTOPTION);
                    },
                    child: Container(
                      height: 44.h,
                      width: 362.w,
                      decoration: BoxDecoration(
                        color: controller.selectedButton.value == 1
                            ? Colorstheam.nobelblack
                            : Colorstheam.white,
                        border: Border.all(
                          color: Colorstheam.nobelblack,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Apptext.signup,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: controller.selectedButton.value == 1
                                ? Colorstheam.white
                                : Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.03,),
              GestureDetector(
                onTap: (){},
                child: RichText(
                  text: TextSpan(
                    text: 'Continue as ',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colorstheam.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Guest User',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screensize.height * 0.03),
            ],
          )
      ),
    );
  }
}
