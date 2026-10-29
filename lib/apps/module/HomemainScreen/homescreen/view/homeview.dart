// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/controller/homecontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Homeview extends GetView<Homecontroller> {
  Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: RefreshIndicator(
        color: Colorstheam.clusterwhite,
        backgroundColor: Colorstheam.nobelblack,
        onRefresh: () async {
          await controller.fetchHomePage();
        },
        child: Scaffold(
          backgroundColor: Colorstheam.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colorstheam.white,
            elevation: 0,
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.only(
                left: screensize.width * 0.04,
              ),
              child: SvgPicture.asset(
                "asset/svg/maliablacklogo.svg",
                height: 30.h,
                width: 138.74.w,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  final bottomNav =
                  Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.search;
                },
                child: SvgPicture.asset(
                  "asset/svg/search.svg",
                  height: 22.h,
                  width: 22.w,
                ),
              ),
              SizedBox(width: 16.w),
              Padding(
                padding: EdgeInsets.only(
                  right: screensize.width * 0.04,
                ),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    final bottomNav =
                    Get.find<Bottomnavigationcontroller>();
                    bottomNav.selectedIndex.value = 0;
                    bottomNav.currentPage.value = PageType.viewcart;
                  },
                  child: SvgPicture.asset(
                    "asset/svg/cart.svg",
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: controller.homeScrollController,
            primary: false,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: screensize.height * 0.01),

                // ---------------- HERO SECTION ----------------

                Padding(
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                  ),
                  child: Obx(() {
                    final heroImage =
                        controller.homeContent['hero_image']
                            ?.toString() ??
                            '';

                    final heroEyebrow =
                        controller.homeContent['hero_eyebrow']
                            ?.toString() ??
                            'NEW SEASON EDIT';

                    final heroTitle =
                        controller.homeContent['hero_title']
                            ?.toString() ??
                            'Premium Hair Extensions';

                    final heroDescription =
                        controller.homeContent['hero_description']
                            ?.toString() ??
                            'Crafted with high-quality hair, our wefts deliver a flawless transformation with a luxurious finish.';

                    final heroButtonLabel =
                        controller.homeContent['hero_button_label']
                            ?.toString() ??
                            'Shop Extensions';

                    return SizedBox(
                      height: 410.h,
                      width: 362.w,
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: heroImage.isNotEmpty
                                ? Image.network(
                              heroImage,
                              height: 410.h,
                              width: 362.w,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  "asset/image/image1.png",
                                  height: 410.h,
                                  width: 362.w,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                                : Image.asset(
                              "asset/image/image1.png",
                              height: 410.h,
                              width: 362.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            right: 20.w,
                            bottom: 25.h,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  heroEyebrow,
                                  style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  heroTitle,
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  heroDescription,
                                  style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colorstheam.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screensize.height * 0.02,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      HapticFeedback.heavyImpact();
                                      final bottomNav =
                                      Get.find<
                                          Bottomnavigationcontroller>();
                                      bottomNav.selectedIndex.value = 0;
                                      bottomNav.currentPage.value =
                                          PageType.collectionlist;
                                    },
                                    child: Container(
                                      height: 44.h,
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                        color:
                                        Colorstheam.clusterwhite,
                                      ),
                                      child: Center(
                                        child: Text(
                                          heroButtonLabel,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DMSans",
                                            color:
                                            Colorstheam.nobelblack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                SizedBox(height: screensize.height * 0.02),

                // ---------------- SHOP BY CATEGORY ----------------

                Padding(
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Obx(
                          () => Text(
                        controller.homeContent['shop_by_category_title']
                            ?.toString()
                            .trim()
                            .isNotEmpty ==
                            true
                            ? controller.homeContent['shop_by_category_title']
                            .toString()
                            .trim()
                            : "Shop By Category",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screensize.height * 0.02),

                Obx(() {
                  final categoryItems = controller.categories;

                  return SizedBox(
                    height: 175.h,
                    child: ListView.separated(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      itemCount: categoryItems.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final category = categoryItems[index];

                        final categoryTitle =
                            category['title']?.toString() ?? '';

                        final categoryImage =
                            category['image']?.toString() ?? '';

                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            final bottomNav =
                            Get.find<
                                Bottomnavigationcontroller>();

                            bottomNav.selectedIndex.value = 0;
                            bottomNav.currentPage.value =
                                PageType.collectionlist;
                          },
                          child: SizedBox(
                            width: 130.w,
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: categoryImage.isNotEmpty
                                      ? Image.network(
                                    categoryImage,
                                    height: 140.h,
                                    width: 130.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                        ) {
                                      return Container(
                                        height: 140.h,
                                        width: 130.w,
                                        color:
                                        Colorstheam.lightgrey,
                                      );
                                    },
                                  )
                                      : Container(
                                    height: 140.h,
                                    width: 130.w,
                                    color:
                                    Colorstheam.lightgrey,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  categoryTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),

                SizedBox(height: screensize.height * 0.02),

                // ---------------- FEATURED PRODUCTS ----------------
                Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                          left: screensize.width * 0.04,
                          right: screensize.width * 0.04,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                                              controller.homeContent['best_seller_title']?.toString().trim().isNotEmpty == true
                            ? controller.homeContent['best_seller_title'].toString().trim()
                            : 'Best Sellers',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack,
                            ),
                                            ),
                        ),
                      ),
                ),
                SizedBox(height: screensize.height * 0.02),
                Obx(() {
                  final products = controller.featuredProducts;

                  if (controller.isHomeLoading.value &&
                      products.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.h,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (products.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 20.h,
                      mainAxisExtent: 295.h,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final productImage = product['image']?.toString() ?? '';
                      final productName = product['name']?.toString() ?? '';
                      final productRating = product['rating']?.toString() ?? '4.9';
                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  child: productImage.isNotEmpty
                                      ? Image.network(
                                    productImage,
                                    width: double.infinity,
                                    height: 200.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                        ) {
                                      return Container(
                                        width: double.infinity,
                                        height: 200.h,
                                        color:
                                        Colorstheam.lightgrey,
                                      );
                                    },
                                  )
                                      : Container(
                                    width: double.infinity,
                                    height: 200.h,
                                    color:
                                    Colorstheam.lightgrey,
                                  ),
                                ),

                                // Wishlist
                                Positioned(
                                  top: 10.h,
                                  right: 10.w,
                                  child: Obx(() {
                                    final bool isWishlisted =
                                    controller.isWishlisted(index);

                                    return GestureDetector(
                                      onTap: () {
                                        HapticFeedback.heavyImpact();
                                        controller
                                            .toggleWishlist(index);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        height: 34.h,
                                        width: 34.h,
                                        decoration: BoxDecoration(
                                          color:
                                          Colorstheam.nobelblack,
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
                                                ? Colorstheam
                                                .clusterwhite
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
                                SizedBox(
                                  width: screensize.width * 0.01,
                                ),
                                Text(
                                  productRating,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                    },
                  );
                }),

                SizedBox(height: screensize.height * 0.02),

                // ---------------- SHOP BY LENGTH ----------------

                Padding(
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Obx(
                          () => Text(
                        controller.homeContent['shop_by_length_title']
                            ?.toString()
                            .trim()
                            .isNotEmpty ==
                            true
                            ? controller.homeContent['shop_by_length_title']
                            .toString()
                            .trim()
                            : "Shop By Length",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screensize.height * 0.02),

                Obx(() {
                  final lengths = controller.lengthOptions;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: screensize.width * 0.04,
                      right: screensize.width * 0.04,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: lengths.map((length) {
                        final bool isSelected =
                            controller.selectedLength.value ==
                                length;

                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            controller.selectLength(length);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            height: 52.w,
                            width: 52.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colorstheam.nobelblack
                                    : Colorstheam.clusterwhite,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$length"',
                                style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colorstheam.clusterwhite
                                      : Colorstheam.nobelblack,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),

                SizedBox(height: screensize.height * 0.02),

                // ---------------- EDUCATION SECTION ----------------

                Padding(
                  padding: EdgeInsets.only(
                    left: screensize.width * 0.04,
                    right: screensize.width * 0.04,
                  ),
                  child: Obx(() {
                    final educationImage =
                        controller.homeContent['education_image']
                            ?.toString() ??
                            '';

                    final educationTitle =
                        controller.homeContent['education_title']
                            ?.toString() ??
                            'CERTIFICATION PERKS!';

                    final educationDescription =
                        controller.homeContent[
                        'education_description']
                            ?.toString() ??
                            "While you don't need a certification to purchase our hair, a Malia Butterfly Method certification does give you access to some pretty amazing perks!";

                    final inPersonButtonLabel =
                        controller.homeContent[
                        'in_person_button_label']
                            ?.toString() ??
                            'In-Person Education';

                    final onlineButtonLabel =
                        controller.homeContent[
                        'online_button_label']
                            ?.toString() ??
                            'Online Education';

                    return SizedBox(
                      height: 410.h,
                      width: 362.w,
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: educationImage.isNotEmpty
                                ? Image.network(
                              educationImage,
                              height: 410.h,
                              width: 362.w,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  "asset/image/image2.png",
                                  height: 410.h,
                                  width: 362.w,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                                : Image.asset(
                              "asset/image/image2.png",
                              height: 410.h,
                              width: 362.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            right: 20.w,
                            bottom: 25.h,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  educationTitle,
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colorstheam.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  educationDescription,
                                  style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colorstheam.white,
                                  ),
                                ),

                                // Education buttons
                                Obx(() {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                          controller
                                              .selectEducation(0);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: screensize.height *
                                                0.02,
                                          ),
                                          child: Container(
                                            height: 44.h,
                                            width: 320.w,
                                            decoration: BoxDecoration(
                                              color: controller
                                                  .selectedEducation
                                                  .value ==
                                                  0
                                                  ? Colors.transparent
                                                  : Colorstheam
                                                  .clusterwhite,
                                              border: BoxBorder.all(
                                                color: Colorstheam
                                                    .clusterwhite,
                                                width: 2,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                inPersonButtonLabel,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily: "DMSans",
                                                  color: controller
                                                      .selectedEducation
                                                      .value ==
                                                      0
                                                      ? Colorstheam.white
                                                      : Colorstheam
                                                      .nobelblack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 12.h),

                                      GestureDetector(
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                          controller
                                              .selectEducation(1);
                                        },
                                        child: Container(
                                          height: 44.h,
                                          width: 320.w,
                                          decoration: BoxDecoration(
                                            color: controller
                                                .selectedEducation
                                                .value ==
                                                1
                                                ? Colors.transparent
                                                : Colorstheam
                                                .clusterwhite,
                                            border: BoxBorder.all(
                                              color: Colorstheam
                                                  .clusterwhite,
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              onlineButtonLabel,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily: "DMSans",
                                                color: controller
                                                    .selectedEducation
                                                    .value ==
                                                    1
                                                    ? Colorstheam.white
                                                    : Colorstheam
                                                    .nobelblack,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                SizedBox(height: screensize.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}