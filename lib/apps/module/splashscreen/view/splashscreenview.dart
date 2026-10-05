// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/splashscreen/controller/splashscreencontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colorstheam.clusterwhite,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: -screensize.width * 0.25,
              right: -screensize.width * 0.25,
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: controller.glowOpacity.value * 0.55,
                    child: Container(
                      height: screensize.width * 0.75,
                      width: screensize.width * 0.75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colorstheam.clusterwhite.withOpacity(0.0),
                            Colorstheam.clusterwhite.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: -screensize.width * 0.30,
              left: -screensize.width * 0.30,
              child: Container(
                height: screensize.width * 0.85,
                width: screensize.width * 0.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colorstheam.clusterwhite,
                ),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: controller.logoOpacity.value,
                    child: Transform.rotate(
                      angle: controller.logoRotation.value,
                      child: Transform.scale(
                        scale: controller.logoScale.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screensize.width * 0.12,
                  ),
                  child: SvgPicture.asset(
                    "asset/svg/maliablacklogo.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screensize.height * 0.075,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: controller.logoOpacity.value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        12 * (1 - controller.logoOpacity.value),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 42.w,
                      child: LinearProgressIndicator(
                        minHeight: 1.2,
                        backgroundColor: Colors.black.withOpacity(0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}