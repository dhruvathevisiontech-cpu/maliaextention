
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

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
                bottomNav.selectedIndex.value = 1;
                bottomNav.currentPage.value = PageType.filter;
              },
            ),
            SizedBox(width: 20.w),
            _headerIcon(
              icon: 'asset/svg/search.svg',
              onTap: () {
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),
            SizedBox(width: 20.w),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.04),
              child: _headerIcon(
                icon: 'asset/svg/cart.svg',
                onTap: () {
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Obx(() {
            if (controller.isLoadingCollections.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colorstheam.nobelblack,
                ),
              );
            }

            if (controller.metaobjectCollections.isEmpty) {
              return _emptyState(
                controller.errorMessage.value.isNotEmpty
                    ? controller.errorMessage.value
                    : 'No collections available.',
              );
            }

            final collectionName =
                bottomNav.selectedCollectionName.value;

            // This matches the navigation title with the Shopify
            // metaobject title, ignoring letter case.
            final matchingParent =
            controller.metaobjectCollections.firstWhereOrNull(
                  (item) =>
              item['title'].toString().toLowerCase() ==
                  collectionName.toLowerCase(),
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

  Widget _subCollectionSelector() {
    return SizedBox(
      height: 44.h,
      child: Obx(() {
        if (controller.isLoadingSubCollections.value) {
          return const SizedBox.shrink();
        }

        final items = controller.subCollections;

        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        final selectedIndex =
            controller.selectedSubCollection.value;

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = selectedIndex == index;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => controller.selectSubCollection(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? Colorstheam.nobelblack
                      : Colorstheam.white,
                  border: Border.all(
                    color: selected
                        ? Colorstheam.nobelblack
                        : Colorstheam.nobelblack.withValues(alpha: 0.18),
                  ),
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14.sp,
                    fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected
                        ? Colorstheam.white
                        : Colorstheam.nobelblack,
                  ),
                  child: Text(
                    item['title']?.toString() ?? '',
                    maxLines: 1,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _productsSection() {
    return Obx(() {
      if (controller.isLoadingProducts.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Colorstheam.nobelblack,
          ),
        );
      }

      if (controller.products.isEmpty) {
        return _emptyState(
          controller.errorMessage.value.isNotEmpty
              ? controller.errorMessage.value
              : 'No products available in this collection.',
        );
      }

      final products = controller.products;

      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 20.h,
          mainAxisExtent: 295.h,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _productCard(products[index], context);
        },
      );
    });
  }

  Widget _productCard(
      Map<String, String> product,
      BuildContext context,
      ) {
    final screenSize = MediaQuery.of(context).size;
    final imageUrl = product['image'] ?? '';
    final productName = product['name'] ?? '';

    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 1;
        bottomNav.openProductDetails(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                child: SizedBox(
                  width: double.infinity,
                  height: 176.h,
                  child: imageUrl.isEmpty
                      ? _imagePlaceholder()
                      : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _imagePlaceholder(),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;

                      return Container(
                        color: Colorstheam.lightgrey,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colorstheam.nobelblack,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Obx(() {
                  final isWishlisted =
                  controller.isWishlisted(product);

                  return GestureDetector(
                    onTap: () => controller.toggleWishlist(product),
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
                              ? 'asset/svg/heart_filled.svg'
                              : 'asset/svg/heart.svg',
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
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colorstheam.nobelblack,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: <Widget>[
              SvgPicture.asset(
                'asset/svg/star.svg',
                height: 11.h,
                width: 12.w,
              ),
              SizedBox(width: screenSize.width * 0.01),
              Text(
                (product['rating']?.isNotEmpty ?? false)
                    ? product['rating']!
                    : '—',
                style: TextStyle(
                  fontFamily: 'DMSans',
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
            children: <Widget>[
              Text(
                'LOGIN TO SEE PRICE',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'DMSans',
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

  Widget _imagePlaceholder() {
    return Container(
      color: Colorstheam.lightgrey,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: 32.sp,
        color: Colorstheam.grey,
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
