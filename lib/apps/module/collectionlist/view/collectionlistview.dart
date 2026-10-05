// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Collectionlistview extends GetView<Collectionlistcontroller> {
  final List<Map<String, String>> products = [
    {
      "id": "product_1",
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "id": "product_2",
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
    {
      "id": "product_3",
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "id": "product_4",
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final bottomNav = Get.find<Bottomnavigationcontroller>();
    final collectionIndex = bottomNav.selectedCollectionIndex.value;
    final collectionName = bottomNav.selectedCollectionName.value;
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
          title: Padding(
            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: screensize.width * 0.02),
                Text(
                  collectionName,
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
              child: _headerIcon(
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              _subCollectionSelector(
                collectionIndex: collectionIndex,
                context: context
              ),
              SizedBox(height: 25.h),
              // --------------------------------------------------------
              // PRODUCTS
              // --------------------------------------------------------

              Expanded(
                child: _productsSection(
                  collectionIndex: collectionIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _subCollectionSelector({
    required int collectionIndex,
    required BuildContext context,
  }) {
    final subCollections = controller.getSubCollections(collectionIndex);
    Size screensize = MediaQuery.of(context).size;
    return SizedBox(
      height: 44.h,
      child: Obx(
            () {
          final selectedIndex = controller.selectedSubCollection.value;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.only(
              left: screensize.width * 0.04,
              right: screensize.width * 0.04,
            ),

            itemCount: subCollections.length,

            separatorBuilder: (_, __) {
              return SizedBox(width: 10.w);
            },

            itemBuilder: (context, index) {
              final bool selected =
                  selectedIndex == index;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTap: () {
                  controller.selectSubCollection(index);
                },

                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),

                  curve: Curves.easeOutCubic,

                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),

                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: selected
                        ? Colorstheam.nobelblack
                        : Colorstheam.white,

                    border: Border.all(
                      color: selected
                          ? Colorstheam.nobelblack
                          : Colorstheam.nobelblack
                          .withValues(alpha: 0.18),
                    ),
                  ),

                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(
                      milliseconds: 200,
                    ),

                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 14.sp,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: selected
                          ? Colorstheam.white
                          : Colorstheam.nobelblack,
                    ),

                    child: Text(
                      subCollections[index],
                      maxLines: 1,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  Widget _productsSection({
    required int collectionIndex,
  }) {
    return Obx(() {
      final subCollections = controller.getSubCollections(collectionIndex);
      if (subCollections.isEmpty) {
        return Center(
          child: Text(
            "No products available",
            style: TextStyle(
              fontFamily: "DMSans",
              fontSize: 14.sp,
              color: Colorstheam.grey,
            ),
          ),
        );
      }

      final selectedIndex =
          controller.selectedSubCollection.value;

      final safeIndex = selectedIndex >= subCollections.length
          ? 0
          : selectedIndex;

      final selectedSubCollection =
      subCollections[safeIndex];

      return GridView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 20.h,
          mainAxisExtent: 295.h,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index % products.length];
          return _productCard(
            product: product,
            subCollectionName: selectedSubCollection,
            index: index,
            context: context,
          );
        },
      );
    });
  }
  Widget _productCard({
    required Map<String, String> product,
    required String subCollectionName,
    required int index,
    required BuildContext context,
  }) {
    Size screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();

        bottomNav.selectedIndex.value = 1;

        bottomNav.openProductDetails(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                child: Image.asset(
                  product["image"]!,
                  width: 176.w,
                  height: 176.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Obx(() {
                  final bool isWishlisted =
                  controller.isWishlisted(product);

                  return GestureDetector(
                    onTap: () {
                      controller.toggleWishlist(product);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 34.h,
                      width: 34.h,
                      decoration: BoxDecoration(
                        color: Colorstheam.nobelblack,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          isWishlisted
                              ? "asset/svg/heart_filled.svg"
                              : "asset/svg/heart.svg",
                          height: 18.h,
                          width: 18.w,
                          color: isWishlisted
                              ? Colorstheam.clusterwhite
                              : Colorstheam.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            product["name"]!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "DMSans",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colorstheam.nobelblack,
            ),
          ),
          SizedBox(height: 4.h),

          Row(
            children: [
              SvgPicture.asset(
                "asset/svg/star.svg",
                height: 11.h,
                width: 12.w,
              ),
              SizedBox(width: screensize.width * 0.01),
              Text(
                product["rating"]!,
                style: TextStyle(
                  fontFamily: "DMSans",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "LOGIN TO SEE PRICE",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w600,
                  color: Colorstheam.nobelblack,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 1.h,
                width: 120.w,
                color: Colorstheam.nobelblack,
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ============================================================
  // BACK BUTTON
  // ============================================================

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 1;
        bottomNav.currentPage.value = PageType.collection;
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

  // ============================================================
  // HEADER ICON
  // ============================================================

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