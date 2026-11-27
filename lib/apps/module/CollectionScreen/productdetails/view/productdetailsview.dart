import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/utils/malia_product_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/controller/productdetailscontroller.dart';
class Productdetailsview extends GetView<Productdetailscontroller> {
  const Productdetailsview({super.key});
  void _selectOptionValue(String optionName, String value) {
    final currentVariant = controller.selectedVariant.value;
    final currentOptions = <String, String>{};
    final selectedOptions = currentVariant?['selectedOptions'] as List? ?? [];
    for (final option in selectedOptions) {
      if (option is Map) {
        final name = option['name']?.toString() ?? '';
        final optionValue = option['value']?.toString() ?? '';
        if (name.isNotEmpty && optionValue.isNotEmpty) {
          currentOptions[name] = optionValue;
        }
      }
    }
    currentOptions[optionName] = value;
    Map<String, dynamic>? matchingVariant;
    for (final variant in controller.variants) {
      final options = variant['selectedOptions'] as List? ?? [];
      var matches = true;
      for (final entry in currentOptions.entries) {
        final found = options.any((option) => option is Map && option['name']?.toString() == entry.key && option['value']?.toString() == entry.value);
        if (!found) {
          matches = false;
          break;
        }
      }
      if (matches) {
        matchingVariant = variant;
        if (variant['availableForSale'] == true) {
          break;
        }
      }
    }
    if (matchingVariant != null) {
      controller.selectVariant(matchingVariant);
    }
  }
  void _showWishlistPicker() {
    final wishlistController = controller.wishlistController;
    if (controller.currentProductId.isEmpty) {
      AppSnackbar.error('Please wait until the product has loaded.',);
      return;
    }
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: Colorstheam.white,
        ),
        child: SafeArea(
          top: false,
          child: Obx(() {
            final lists = wishlistController.wishlists.toList();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colorstheam.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Save to wishlist',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Choose a collection for this product.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 13.sp,
                    color: Colorstheam.grey,
                  ),
                ),
                SizedBox(height: 16.h),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    separatorBuilder: (_, _) => Divider(color: Colorstheam.clusterwhite),
                    itemBuilder: (context, index) {
                      final wishlist = lists[index];
                      final id = wishlist['id'].toString();
                      final name = wishlist['name']?.toString() ?? 'Wishlist';
                      final products = wishlist['products'];
                      final count = products is List ? products.length : 0;
                      final alreadyAdded = wishlistController.isProductInWishlist(id,controller.currentProductId);
                      return Container(
                        decoration: BoxDecoration(color: Colorstheam.white),
                        child: Material(
                          color: Colorstheam.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              name,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            subtitle: Text(
                              '$count ${count == 1 ? 'item' : 'items'}',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 12.sp,
                                color: Colorstheam.grey,
                              ),
                            ),
                            trailing: Icon(
                              alreadyAdded
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: Colorstheam.nobelblack,
                              size: 23.w,
                            ),
                            onTap: () {
                              if (alreadyAdded) {
                                Get.back();
                                AppSnackbar.error('This product is already in "$name".',);
                                return;
                              }
                              controller.addCurrentProductToWishlist(id);
                              Get.back();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.lightImpact();
                final bottomNav = Get.find<Bottomnavigationcontroller>();
                bottomNav.selectedIndex.value = 1;
                bottomNav.currentPage.value = PageType.collectionlist;
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
            ),
          ),
          actions: [
            _headerIcon(
              icon: 'asset/svg/search.svg',
              onTap: () {
                HapticFeedback.lightImpact();
                final bottomNav = Get.find<Bottomnavigationcontroller>();
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
                  HapticFeedback.lightImpact();

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
        body: Obx(() {
          if (controller.isLoadingProduct.value) {
            return const MaliaProductLoader();
          }
          if (controller.productError.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      controller.productError.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14.sp,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: controller.fetchProductDetails,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        color: Colorstheam.nobelblack,
                        child: Text(
                          'Retry',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 14.sp,
                            color: Colorstheam.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (controller.productDetails.isEmpty) {
            return Center(
              child: Text(
                'Product details not available.',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14.sp,
                  color: Colorstheam.nobelblack,
                ),
              ),
            );
          }
          return RefreshIndicator(
            color: Colorstheam.clusterwhite,
            backgroundColor: Colorstheam.nobelblack,
            onRefresh: controller.fetchProductDetails,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildProductGallery(),
                    Transform.translate(
                      offset: Offset(0, -24.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 15.h, bottom: 30.h),
                        decoration: BoxDecoration(
                          color: Colorstheam.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                            bottom: Radius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildProductHeading(screenSize),
                            SizedBox(height: screenSize.height * 0.01),
                            controller.isLoggedIn == true ?
                                Column(
                                  children: <Widget>[
                                    _buildPriceAndAvailability(screenSize),
                                    _buildVariantOptions(screenSize),
                                    _buildQuantityAndCart(screenSize),
                                    _buildBuyNow(screenSize),
                                  ],
                                ):
                                Padding(
                                  padding: EdgeInsets.only(left: screenSize.width * 0.04,right: screenSize.width * 0.04),
                                  child: Container(
                                    color: Colorstheam.clusterwhite,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: screenSize.height * 0.015),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Pro Account Required",
                                            style: TextStyle(
                                              fontSize: 22.sp,
                                              fontFamily: "Urbanist",
                                              fontWeight: FontWeight.bold,
                                              color: Colorstheam.nobelblack
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenSize.height * 0.01),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Maliá products are available exclusively to licensed hair stylists. Create your free pro account to access professional pricing, malia education and to place orders.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "DMSans",
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.nobelblack
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenSize.height * 0.01),
                                        AnimatedButton(
                                          onTap: (){
                                            HapticFeedback.lightImpact();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: screenSize.width * 0.04,right: screenSize.width * 0.04),
                                            child: Container(
                                              height: 40.h,
                                              color: Colorstheam.nobelblack,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Pro Stylist Registration",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily: "DMSans",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colorstheam.clusterwhite
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenSize.height * 0.01),
                                        AnimatedButton(
                                          onTap: (){
                                            HapticFeedback.lightImpact();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: screenSize.width * 0.04,right: screenSize.width * 0.04),
                                            child: Container(
                                              height: 40.h,
                                              color: Colorstheam.nobelblack,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: "DMSans",
                                                      fontWeight: FontWeight.bold,
                                                      color: Colorstheam.clusterwhite
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenSize.height * 0.01),
                                        IntrinsicWidth(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "Locate Certified Maliá Stylists Near You",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "DMSans",
                                                  fontWeight: FontWeight.w500,
                                                  color: Colorstheam.nobelblack,
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Container(
                                                height: 1.h,
                                                width: double.infinity,
                                                color: Colorstheam.nobelblack,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: screenSize.height * 0.015),
                                      ],
                                    ),
                                  ),
                                ),
                            SizedBox(height: screenSize.height * 0.02),
                            _buildProductDetails(screenSize),
                            _buildShippingInfo(screenSize),
                            _buildWarrantyInfo(screenSize),
                            Obx(() {
                              if (controller.isLoadingRecommendations.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (controller.recommendedProducts.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Text(
                                        'You May Also Like',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.bold,
                                          color: Colorstheam.nobelblack
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    SizedBox(
                                      height: 245.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        itemCount: controller.recommendedProducts.length,
                                        separatorBuilder: (_, _) => SizedBox(width: 12.w),
                                        itemBuilder: (context, index) {
                                          final item = controller.recommendedProducts[index];
                                          final imageUrl = item['featuredImage']?['url']?.toString() ?? '';
                                          final title = item['title']?.toString() ?? '';
                                          final amount = item['priceRange']?['minVariantPrice']?['amount']?.toString() ?? '0.00';
                                          final currency = item['priceRange']?['minVariantPrice']?['currencyCode']?.toString() ?? 'USD';
                                          return SizedBox(
                                            width: 176.w,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ClipRRect(
                                                  child: SizedBox(
                                                    width: 176.w,
                                                    height: 176.h,
                                                    child: imageUrl.isEmpty
                                                        ? const SizedBox.shrink()
                                                        : Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (_, _, _) =>
                                                      const SizedBox.shrink(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  title,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: 'DMSans',
                                                    color: Colorstheam.grey,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '$currency $amount',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: 'DMSans',
                                                    color: Colorstheam.nobelblack,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  Widget _buildProductGallery() {
    return SizedBox(
      height: 402.h,
      width: double.infinity,
      child: Stack(
        children: [
          Obx(() {
            final images = controller.productImages.toList();
            if (images.isEmpty) {
              return Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 40.w,
                  color: Colorstheam.grey,
                ),
              );
            }
            return CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40.w,
                          color: Colorstheam.grey,
                        ),
                      );
                    },
                  ),
                );
              },
              options: CarouselOptions(
                height: 402.h,
                viewportFraction: 1,
                autoPlay: images.length > 1,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 700),
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
              ),
            );
          }),
          Positioned(
            bottom: 35.h,
            left: 16.w,
            right: 16.w,
            child: Obx(() {
              final images = controller.productImages.toList();
              final selectedIndex = controller.currentIndex.value;
              if (images.isEmpty) {
                return const SizedBox.shrink();
              }
              return SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final selected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        controller.carouselController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        controller.currentIndex.value = index;
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colorstheam.white,
                          border: Border.all(
                            color: selected
                                ? Colorstheam.nobelblack
                                : Colorstheam.white,
                            width: selected ? 1.5 : 0,
                          ),
                        ),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported_outlined,
                              color: Colorstheam.grey,
                              size: 20.w,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Positioned(
            top: 16.h,
            right: 16.w,
            child: Obx(() {
              final selected = controller.isWishlisted.value;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showWishlistPicker();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colorstheam.nobelblack
                        : Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      selected
                          ? 'asset/svg/heart_filled.svg'
                          : 'asset/svg/heart.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter: ColorFilter.mode(
                        Colorstheam.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  Widget _buildProductHeading(Size screenSize) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.04,
        right: screenSize.width * 0.04,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              controller.productName,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Obx(() {
            if (controller.productReviewCount.value == 0) {
              return const SizedBox.shrink();
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'asset/svg/star.svg',
                  width: 12.w,
                  height: 12.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  controller.formattedRating,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.grey,
                    height: 1.0,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
  Widget _buildPriceAndAvailability(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 1.h),
          Text(
            '45 Minutes',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colorstheam.burntearth,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _formattedPrice(),
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
              Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                color: Colorstheam.nobelblack,
                child: Center(
                  child: Text(
                    'PRO PRICING',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: <Widget>[
              Container(
                width: 12.w,
                height: 12.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isAvailable
                      ? Colorstheam.green
                      : Colorstheam.grey,
                ),
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colorstheam.white,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(controller.isAvailable ? 'Available in stock' : 'Currently unavailable',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'DMSans',
                  color: controller.isAvailable ? Colorstheam.green : Colorstheam.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String _formattedPrice() {
    final amount = double.tryParse(controller.price);
    if (amount == null) {
      return '${controller.currencyCode} ${controller.price}';
    }
    final currency = controller.currencyCode;
    if (currency == 'USD') {
      return '\$${amount.toStringAsFixed(2)}';
    }
    return '$currency ${amount.toStringAsFixed(2)}';
  }
  Widget  _buildVariantOptions(Size screenSize) {
    return Obx(() {
      final definitions = controller.optionDefinitions.where((definition) {
        final name = definition['name']?.toString().trim().toLowerCase() ?? '';
        final values = definition['values'] as List? ?? [];
        if (name == 'title' &&
            values.length == 1 &&
            values.first.toString().trim().toLowerCase() == 'default title') {
          return false;
        }

        return values.isNotEmpty;
      }).toList();
      final selectedVariant = controller.selectedVariant.value;
      final selectedOptions = selectedVariant?['selectedOptions'] as List? ?? [];
      if (definitions.isEmpty) {return const SizedBox.shrink();}
      return Padding(padding: EdgeInsets.only(left: screenSize.width * 0.04, right: screenSize.width * 0.04, top: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: definitions.map((definition) {
            final name = definition['name']?.toString() ?? '';
            final values = definition['values'] as List? ?? [];
            var selectedValue = '';
            for (final option in selectedOptions) {
              if (option is Map && option['name']?.toString() == name) {
                selectedValue = option['value']?.toString() ?? '';
                break;
              }
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$name: $selectedValue',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'DMSans',
                        color: Colorstheam.nobelblack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (name.toLowerCase().contains('shade'))...[
                    SizedBox(height: 12.h),
                    Obx(() {
                      final currentVariant = controller.selectedVariant.value;
                      final currentOptions = currentVariant?['selectedOptions'] as List? ?? [];
                      final currentOption = currentOptions.cast<Map>().firstWhere((option) =>
                        option['name'].toString().toLowerCase() == name.toLowerCase(),
                        orElse: () => <String, dynamic>{},
                      );
                      final currentValue = currentOption['value']?.toString() ?? selectedValue;
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 8.w,
                          runSpacing: 10.h,
                          children: values.map((rawValue) {
                            final value = rawValue.toString();
                            final selected = value == currentValue;
                            final imageUrl = controller.getShadeImage(value);
                            return GestureDetector(
                              onTap: () => _selectOptionValue(name, value),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: EdgeInsets.all(selected ? 2.w : 0),
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selected
                                        ? Colorstheam.burntearth
                                        : Colors.transparent,
                                    width: selected ? 2.w : 0,
                                  ),
                                ),
                                child: imageUrl == null
                                    ? Center(
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ) : ClipRRect(
                                  child: Image.network(
                                    imageUrl,
                                    width: 48.w,
                                    height: 48.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 9.sp),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ]
                  else ...[
                    Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: values.map((rawValue) {
                        final value = rawValue.toString();
                        final selected = selectedValue == value;
                        return GestureDetector(
                          onTap: () => _selectOptionValue(name, value),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? Colorstheam.nobelblack : Colorstheam.white,
                              border: Border.all(
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: selected ? Colorstheam.clusterwhite : Colorstheam.nobelblack,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ]
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
  Widget _buildQuantityAndCart(Size screenSize) {
    return Obx(() {
      final quantity = controller.quantity.value;
      final available = controller.isAvailable;
      return Padding(padding: EdgeInsets.only(left: screenSize.width * 0.04, right: screenSize.width * 0.04, top: 8.h,),
        child: Row(
          children: <Widget>[
            Container(
              width: 116.w,
              height: 40.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colorstheam.nobelblack,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: quantity > 1 ? controller.decreaseQty : null,
                      child: Center(
                        child: SvgPicture.asset(
                          'asset/svg/minimize.svg',
                          width: 16.w,
                          height: 16.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 38.w,
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: controller.increaseQty,
                      child: Center(
                        child: SvgPicture.asset(
                          'asset/svg/plus.svg',
                          width: 16.w,
                          height: 16.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Obx(() {
                final cartController = Get.find<Cartcontroller>();
                final available = controller.isAvailable;
                final isAdding = cartController.isUpdating.value;

                return AnimatedButton(
                  onTap: () {
                    if (!available || isAdding) return;

                    controller.addCurrentProductToCart();
                  },
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colorstheam.nobelblack,
                      ),
                      color: available && !isAdding
                          ? Colorstheam.white
                          : Colorstheam.clusterwhite,
                    ),
                    child: Center(
                      child: Text(
                        !available
                            ? 'UNAVAILABLE'
                            : isAdding
                            ? 'ADDING...'
                            : 'ADD TO CART',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w700,
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
      );
    });
  }
  Widget _buildBuyNow(Size screenSize) {
    return Padding(padding: EdgeInsets.only(left: screenSize.width * 0.04, right: screenSize.width * 0.04, top: 9.h,),
      child: AnimatedButton(
        onTap: () {},
        child: Container(
          height: 40.h,
          color: Colorstheam.nobelblack,
          child: Center(
            child: Text(
              'BUY NOW',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w700,
                color: Colorstheam.clusterwhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildProductDetails(Size screenSize) {
    return _buildInfoTile(
      screenSize: screenSize,
      title: 'Product Details',
      child: Obx(() {
        final description = controller.description;
        if (description.trim().isEmpty) {return const SizedBox.shrink();}
        final formattedDescription = controller.formatProductDescription(description);
        return Text(
          formattedDescription,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'DMSans',
            color: Colorstheam.dimgrey,
            height: 1.7,
          ),
        );
      }),
    );
  }
  Widget _buildShippingInfo(Size screenSize) {
    return _buildInfoTile(
      screenSize: screenSize,
      title: 'Shipping Info',
      child: Obx(() {
        final description = controller.shippingDescription.value;
        if (description.trim().isEmpty) {
          return const Text('Shipping information is currently unavailable.');
        }
        return HtmlWidget(
          description,
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'DMSans',
            color: Colorstheam.dimgrey,
            height: 1.5,
          ),
        );
      }),
    );
  }
  Widget _buildWarrantyInfo(Size screenSize) {
    return _buildInfoTile(
      screenSize: screenSize,
      title: 'Warranty Info',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _infoText(
            'At Malia Extensions, each piece of hair is inspected before it leaves our warehouse.',
          ),
          SizedBox(height: 12.h),
          _infoText(
            'Satisfaction Guaranteed:',
            bold: true,
            color: Colorstheam.nobelblack,
          ),
          _infoText(
            'If your product does not meet our quality promise, please notify us within 7 days of delivery.',
          ),
          SizedBox(height: 12.h),
          _infoText(
            'Exclusions:',
            bold: true,
            color: Colorstheam.nobelblack,
          ),
          _infoText(
            'The warranty does not cover custom coloring, lightening or perming, improper installation, or incorrect at-home care.',
          ),
          SizedBox(height: 12.h),
          _infoText(
            'Follow Malia’s aftercare guidelines and use professional, stylist-approved installation and maintenance methods.',
          ),
        ],
      ),
    );
  }
  Widget _buildInfoTile({
    required Size screenSize,
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: screenSize.width * 0.04, right: screenSize.width * 0.04),
      child: Container(
        decoration: BoxDecoration(
          color: Colorstheam.white,
          border: Border(
            top: BorderSide(
              color: Colorstheam.clusterwhite,
              width: 3.w,
            ),
          ),
        ),
        child: Material(
          color: Colorstheam.white,
          child: Theme(
            data: Theme.of(Get.context!).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 4.h,
              ),
              childrenPadding: EdgeInsets.only(
                bottom: 16.h,
              ),
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w600,
                  color: Colorstheam.nobelblack,
                ),
              ),
              trailing: SvgPicture.asset(
                'asset/svg/plus.svg',
                width: 18.w,
                height: 18.h,
              ),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _infoText(String text, {bool bold = false,Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
          fontFamily: 'DMSans',
          color: color ?? Colorstheam.dimgrey,
          height: 1.5,
        ),
      ),
    );
  }
  Widget _headerIcon({required String icon,VoidCallback? onTap,}) {
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