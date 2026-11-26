
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/utils/malia_product_loader.dart';

class Collectionlistview extends GetView<Collectionlistcontroller> {
  const Collectionlistview({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bottomNav = Get.find<Bottomnavigationcontroller>();
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
            padding: EdgeInsets.only(left: screenSize.width * 0.04),
            child: Row(
              children: <Widget>[
                _backButton(),
                SizedBox(width: screenSize.width * 0.02),
                Expanded(
                  child: Obx(
                        () => Text(
                      bottomNav.selectedCollectionName.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            _headerIcon(
              icon: 'asset/svg/Filter.svg',
              onTap: () {
                HapticFeedback.heavyImpact();
                bottomNav.selectedIndex.value = 1;
                bottomNav.currentPage.value = PageType.filter;
              },
            ),
            SizedBox(width: 20.w),
            _headerIcon(
              icon: 'asset/svg/search.svg',
              onTap: () {
                HapticFeedback.heavyImpact();
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),
            SizedBox(width: 20.w),
            Padding(
              padding: EdgeInsets.only(
                right: screenSize.width * 0.04,
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
                    children: [
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
          child: Obx(() {
            if (controller.isLoadingCollections.value) {
              return const MaliaProductLoader();
            }
            if (controller.metaobjectCollections.isEmpty) {
              return _emptyState(
                controller.errorMessage.value.isNotEmpty
                    ? controller.errorMessage.value
                    : 'No collections available.',
              );
            }
            final collectionName = bottomNav.selectedCollectionName.value;
            final matchingParent = controller.metaobjectCollections.firstWhereOrNull((item) =>
              item['title'].toString().toLowerCase() == collectionName.toLowerCase(),
            );
            if (matchingParent == null) {
              return _emptyState(
                'No Shopify collection matches "$collectionName".',
              );
            }
            controller.loadSubCollectionsForParent(collectionName);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15.h),
                Expanded(
                  child: _productsSection(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
  Widget _productsSection() {
    return Obx(() {
      if (controller.isLoadingProducts.value) {
        return const MaliaProductLoader();
      }

      final products = controller.products;

      if (products.isEmpty) {
        return _emptyState("No products found in this collection.");
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 1.h,
                      color: Colorstheam.nobelblack,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'CURATED FOR YOU',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 9.sp,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Find Your Perfect Match',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colorstheam.nobelblack,
                          height: 1.15,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colorstheam.clusterwhite,
                        border: Border.all(
                          color: Colorstheam.lightgrey,
                          width: 0.6,
                        ),
                      ),
                      child: Text(
                        '${products.length.toString().padLeft(2, '0')} ITEMS',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 9.sp,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 7.h),

                Text(
                  'Explore our collection and discover your signature look.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 11.sp,
                    height: 1.5,
                    color: Colorstheam.dimgrey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 25.h),
              physics: const BouncingScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13.w,
                mainAxisSpacing: 23.h,
                mainAxisExtent: 320.h,
              ),
              itemBuilder: (context, index) {
                return _productCard(products[index], index);
              },
            ),
          ),
        ],
      );
    });
  }
  Widget _productCard(Map<String, String> product, int index) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 1;
        bottomNav.openProductDetails(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: 190.h,
                width: double.infinity,
                color: Colorstheam.clusterwhite,
                child: product['image'] != null &&
                    product['image']!.isNotEmpty
                    ? Image.network(
                  product['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return _imagePlaceholder();
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return _imagePlaceholder();
                  },
                )
                    : _imagePlaceholder(),
              ),

              // WISHLIST BUTTON
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Obx(() {
                  final isWishlisted =
                  controller.isWishlisted(product);

                  return Material(
                    color: Colorstheam.white,
                    shape: const CircleBorder(),
                    elevation: 1,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        controller.toggleWishlist(product);
                      },
                      child: SizedBox(
                        width: 35.w,
                        height: 35.w,
                        child: Center(
                          child: SvgPicture.asset(
                            isWishlisted
                                ? 'asset/svg/heart_filled.svg'
                                : 'asset/svg/heart.svg',
                            width: 17.w,
                            height: 17.w,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          SizedBox(height: 11.h),

          // PRODUCT NAME
          Text(
            product['name'] ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: Colorstheam.nobelblack,
            ),
          ),

          SizedBox(height: 7.h),

          // PRODUCT LABEL
          Row(
            children: [
              SvgPicture.asset(
                'asset/svg/star.svg',
                height: 12.w,
                width: 12.w,
                color: Colorstheam.dimgrey,
              ),
              SizedBox(width: 5.w),
              Text(
                (product['rating'] ?? '').isNotEmpty
                    ? product['rating']!
                    : 'New Arrival',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.dimgrey,
                ),
              ),
            ],
          ),

          const Spacer(),

          // BOTTOM ACTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colorstheam.lightgrey,
                  width: 0.7,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'LOGIN TO SEE PRICE',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 9.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w700,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),

                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16.sp,
                  color: Colorstheam.nobelblack,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colorstheam.clusterwhite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 28.sp,
              color: Colorstheam.grey,
            ),
            SizedBox(height: 6.h),
            Text(
              'IMAGE UNAVAILABLE',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 8.sp,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
                color: Colorstheam.dimgrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 14.sp,
            color: Colorstheam.grey,
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
            'asset/svg/arrowleft.svg',
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