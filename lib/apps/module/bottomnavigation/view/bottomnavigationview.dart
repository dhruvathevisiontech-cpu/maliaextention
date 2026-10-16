import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/color/colorstheam.dart';
import '../controller/bottomnavigationcontroller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Bottomnavigationview extends GetView<Bottomnavigationcontroller> {
  const Bottomnavigationview({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
        },
        child: Scaffold(
          backgroundColor: Colorstheam.white,
          body: Obx(() {
            return IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                controller.currentHomePage,
                controller.currentCollectionPage,
                controller.currentWishlist,
                controller.currentEducationPage,
                controller.currentPofile,
              ],
            );
          }),
          bottomNavigationBar: Obx(() {
            return Container(
              height: 72.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              color: Colorstheam.nobelblack,
              child: Row(
                children: [
                  _navItem(
                    "asset/svg/bottomnavigation/home.svg",
                    "Home",
                    0,
                  ),
                  _navItem(
                    "asset/svg/bottomnavigation/collection.svg",
                    "Collection",
                    1,
                  ),
                  _navItem(
                    "asset/svg/bottomnavigation/wishlist.svg",
                    "Wishlist",
                    2,
                  ),
                  _navItem(
                    "asset/svg/bottomnavigation/education.svg",
                    "Education",
                    3,
                  ),
                  _navItem(
                    "asset/svg/bottomnavigation/profile.svg",
                    "Profile",
                    4,
                  ),
                ],
              ),
            );
          }),
        )
    );
  }
  Widget _navItem(
      String iconPath,
      String label,
      int index,
      ) {
    final bool isSelected =
        controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedIndex.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 72.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: SvgPicture.asset(
                  iconPath,
                  height: 21.h,
                  width: 21.w,
                  color: isSelected
                      ? Colorstheam.clusterwhite
                      : Colorstheam.clusterwhite.withValues(
                    alpha: 0.45,
                  ),
                ),
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: isSelected
                    ? Column(
                  children: [
                    SizedBox(height: 3.h),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.clusterwhite,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      width: 18.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: Colorstheam.clusterwhite,
                        borderRadius:
                        BorderRadius.circular(10.r),
                      ),
                    ),
                  ],
                )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class NavigationService {
  static int? redirectTabIndex;
  static PageType? redirectPage;
}