// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/controller/collectioncontroller.dart';
import 'package:maliaextention/utils/malia_product_loader.dart';
class Collectionview extends GetView<Collectioncontroller> {
  Collectionview({super.key});
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              width: double.infinity,
              color: Colorstheam.clusterwhite,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Row(
              children: <Widget>[
                _backButton(),
                SizedBox(width: screensize.width * 0.02),
                Text(
                    "Collections",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack
                  ),
                ),
              ],
            ),
          ),
          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                HapticFeedback.heavyImpact();
                final bottomNav = Get.find<Bottomnavigationcontroller>();
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),
            SizedBox(width: 20.w),

            Padding(
              padding: EdgeInsets.only(
                right: screensize.width * 0.04,
              ),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();

                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
                child: Obx(() {
                  if (!Get.isRegistered<Cartcontroller>()) {
                    Get.put(Cartcontroller());
                  }
                  final cartController = Get.find<Cartcontroller>();
                  final quantity = cartController.totalQuantity;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      SvgPicture.asset(
                        "asset/svg/cart.svg",
                        height: 22.h,
                        width: 22.w,
                      ),

                      if (quantity > 0)
                        Positioned(
                          right: -9.w,
                          top: -8.h,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 17.w,
                              minHeight: 17.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colorstheam.nobelblack,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              quantity > 99 ? '99+' : quantity.toString(),
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),

          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 22.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "THE MALIA EXPERIENCE",
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: Colorstheam.dimgrey,
                      ),
                    ),

                    SizedBox(height: 7.h),

                    Text(
                      "Explore Collections",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                        color: Colorstheam.nobelblack,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      "Discover the perfect pieces to elevate your hair.",
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const MaliaProductLoader();
                  }

                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Text(
                          'Unable to load collections.\n'
                              '${controller.errorMessage.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14.sp,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    );
                  }

                  final categories = controller.collections;

                  if (categories.isEmpty) {
                    return Center(
                      child: Text(
                        'No collections available.',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 15.sp,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 35.h,
                    ),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      return _gridCategory(
                        category: categories[index],
                        index: index,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridCategory({
    required Map<String, dynamic> category,
    required int index,
  }) {
    final String title = category['title']?.toString() ?? '';
    final String imageUrl = category['imageUrl']?.toString() ?? '';

    final List<String> fallbackImages = [
      'asset/image/collectionone.png',
      'asset/image/collection2.png',
      'asset/image/collection3.png',
      'asset/image/collection4.png',
    ];

    return Obx(() {
      final bool selected =
          controller.selectedCollection.value == index;

      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 400 + index * 100),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 16.h * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.heavyImpact();

            final collectionTitle =
                category['title']?.toString().trim() ?? '';

            if (collectionTitle.isEmpty) {
              AppSnackbar.error('This collection has no title.');
              return;
            }

            final bottomNav =
            Get.find<Bottomnavigationcontroller>();

            controller.selectedCollection.value = index;
            bottomNav.selectedCollectionName.value = collectionTitle;
            bottomNav.selectedIndex.value = 1;
            bottomNav.currentPage.value = PageType.collectionlist;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              border: Border.all(
                color: selected
                    ? Colorstheam.nobelblack
                    : Colorstheam.clusterwhite,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (imageUrl.isNotEmpty)
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Image.asset(
                        fallbackImages[index % fallbackImages.length],
                        fit: BoxFit.cover,
                      );
                    },
                  )
                else
                  Image.asset(
                    fallbackImages[index % fallbackImages.length],
                    fit: BoxFit.cover,
                  ),

                // Dark overlay at the bottom
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.35, 1],
                        colors: [
                          Colorstheam.nobelblack.withValues(alpha: 0),
                          Colorstheam.nobelblack.withValues(alpha: 0.78),
                        ],
                      ),
                    ),
                  ),
                ),

                // Collection information
                Positioned(
                  left: 12.w,
                  right: 12.w,
                  bottom: 10.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          letterSpacing: 0.3,
                          color: Colorstheam.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selected indicator
                if (selected)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      color: Colorstheam.white,
                      child: Text(
                        "SELECTED",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 0;
        bottomNav.currentPage.value = PageType.home;
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
  Widget _headerIcon({
    required String icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 22.w,
        height: 22.w,
        child: SvgPicture.asset(
          icon,
          width: 22.w,
          height: 22.w,
        ),
      ),
    );
  }
}