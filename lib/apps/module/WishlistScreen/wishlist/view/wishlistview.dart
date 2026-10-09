// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Wishlistview extends GetView<Wishlistcontroller> {
  const Wishlistview({super.key});

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
              children: [
                _backButton(),
                SizedBox(width: 12.w),
                Text(
                  Apptext.wishlisttitle,
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

          actions: [
            _headerIcon(
              icon: "asset/svg/search.svg",
              onTap: () {
                final bottomNav = Get.find<Bottomnavigationcontroller>();
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),

            SizedBox(width: 16.w),

            Padding(
              padding: EdgeInsets.only(
                right: screensize.width * 0.04,
              ),
              child: _headerIcon(
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: Obx(() {
          final products = controller.wishlistProducts;
          if (products.isEmpty) {
            return _buildEmptyWishlist();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  itemCount: products.length,
                  separatorBuilder: (_, __) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                      ),
                      child: Divider(
                        height: 1.h,
                        color: Colorstheam.clusterwhite,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _wishlistProductCard(
                      product: product,
                    );
                  },
                ),
              ),
              AnimatedButton(
                child: Padding(
                  padding: EdgeInsets.only(left: screensize.width*0.04,right: screensize.width * 0.04,bottom: screensize.height * 0.01),
                  child: Container(
                    height: 40.h,
                    color: Colorstheam.nobelblack,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Add All to Cart",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ],
          );
        }),
      ),
    );
  }
  Widget _buildEmptyWishlist() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30.h),
          Text(
            Apptext.wishlistemptytitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w600,
              color: Colorstheam.black,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            Apptext.wishlistemptysubtitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w300,
              color: Colorstheam.black.withOpacity(0.3),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 171.h,
                  width: 171.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100.h,
                        child: Row(
                          children: [
                            // Big box
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colorstheam.alabastergrey,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      color: Colorstheam.alabastergrey,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      color: Colorstheam.alabastergrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Saved Products",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "0 products",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 12.sp,
                          color: Colorstheam.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Container(
                  height: 171.h,
                  width: 171.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colorstheam.platinium,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "asset/svg/plus.svg",
                            height: 14.h,
                            width: 14.w,
                            color: Colorstheam.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Create New",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _wishlistProductCard({
    required Map product,
  }) {
    final image =
        product["image"]?.toString() ?? "";

    final name =
        product["name"]?.toString() ?? "";

    final variant =
        product["variant"]?.toString() ?? "";

    final price =
        product["price"]?.toString() ?? "";

    final rating =
        product["rating"]?.toString() ?? "";

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                image,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 120.w,
                    height: 120.h,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 6.h,
              left: 6.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTap: () {
                  final productId =
                  product["id"]?.toString();

                  if (productId == null ||
                      productId.isEmpty) {
                    return;
                  }

                  controller.removeFromWishlist(
                    productId,
                  );
                },

                child: Container(
                  padding: EdgeInsets.all(5.w),
                  height: 22.h,
                  width: 22.w,
                  decoration:  BoxDecoration(
                    color: Colorstheam.clusterwhite,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "asset/svg/bin.svg",
                    height: 10.5.h,
                    width: 10.5.w,
                  )
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "DMSans",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colorstheam.nobelblack,
                ),
              ),
              if (variant.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  variant,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w200,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
              if (price.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
              if (rating.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      "asset/svg/star.svg",
                      width: 12.w,
                      height: 12.h,
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      rating,
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        color: Colorstheam.grey,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 12.h),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Move to Bag",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 1.h,
                        color: Colorstheam.nobelblack,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      onTap: () {
        final bottomNav =
        Get.find<Bottomnavigationcontroller>();

        bottomNav.selectedIndex.value = 0;
        bottomNav.currentPage.value =
            PageType.home;
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
          height: 22.h,
        ),
      ),
    );
  }
}
