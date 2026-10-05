// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/homescreen/controller/homecontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Homeview extends GetView<Homecontroller> {
  final List<Map<String, String>> products = [
    {
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product1.png",
      "name": "The Classic Butterfly Weft",
      "rating": "4.9",
    },
    {
      "image": "asset/image/product2.png",
      "name": "The Skinny Butterfly Weft",
      "rating": "4.9",
    },
  ];
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
        onRefresh: () async{
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
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
                  onTap: (){
                    final bottomNav = Get.find<Bottomnavigationcontroller>();
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
                  child: SvgPicture.asset(
                    "asset/svg/cart.svg",
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
                controller: controller.homeScrollController,
                primary: false,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screensize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: SizedBox(
                        height: 410.h,
                        width: 362.w,
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.asset(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NEW SEASON EDIT",
                                    style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.white,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Premium Hair Extensions",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.white,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Crafted with high-quality hair, our wefts deliver a flawless transformation with a luxurious finish.",
                                    style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colorstheam.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: screensize.height * 0.02),
                                    child: Container(
                                      height: 44.h,
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                          color: Colorstheam.clusterwhite
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Shop Extensions",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DMSans",
                                            color: Colorstheam.nobelblack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Shop By Category",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    Container(
                      height: 175.h,
                      child: ListView.separated(
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        itemCount: 4,
                        separatorBuilder: (_, __) => SizedBox(width: 12.w),
                        itemBuilder: (context, index) {
                          final List<String> categories = [
                            "COLLECTIONS",
                            "HAIR EXTENSIONS",
                            "ACCESSORIES",
                            "HAIR CARE",
                          ];
                          final List<String> categoryImages = [
                            "asset/image/butterflycollection.png",
                            "asset/image/geniuscollection.png",
                            "asset/image/ktipcollection.png",
                            "asset/image/FreestyleTape-incollection.png",
                          ];
                          return SizedBox(
                            width: 130.w,
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    categoryImages[index],
                                    height: 140.h,
                                    width: 130.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 6.h),

                                Text(
                                  categories[index],
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
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 20.h,
                        mainAxisExtent: 295.h,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return GestureDetector(
                          onTap: () {
                            // Product details
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    child: Image.asset(
                                      product["image"]!,
                                      width: double.infinity,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // ❤️ Wishlist
                                  Positioned(
                                    top: 10.h,
                                    right: 10.w,
                                    child: Obx(() {
                                      final bool isWishlisted =
                                      controller.isWishlisted(index);

                                      return GestureDetector(
                                        onTap: () {
                                          controller.toggleWishlist(index);
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
                      },
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Shop By Length",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    Obx(() {
                      final lengths = [
                        "14",
                        "16",
                        "18",
                        "20",
                        "22",
                        "24",
                      ];
                      return Padding(
                        padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: lengths.map((length) {
                            final bool isSelected =
                                controller.selectedLength.value == length;

                            return GestureDetector(
                              onTap: () {
                                controller.selectLength(length);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: SizedBox(
                        height: 410.h,
                        width: 362.w,
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Image.asset(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CERTIFICATION PERKS!",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colorstheam.white,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "While you don't need a certification to purchase our hair, a Malia Butterfly Method certification does give you access to some pretty amazing perks!",
                                    style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colorstheam.white,
                                    ),
                                  ),
                                  Obx(() {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectEducation(0);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(top: screensize.height * 0.02),
                                            child: Container(
                                              height: 44.h,
                                              width: 320.w,
                                              decoration: BoxDecoration(
                                                  color: controller.selectedEducation.value == 0
                                                      ? Colors.transparent
                                                      : Colorstheam.clusterwhite,
                                                  border: BoxBorder.all(
                                                      color: controller.selectedEducation.value == 0
                                                          ? Colorstheam.clusterwhite
                                                          : Colorstheam.clusterwhite,
                                                      width: 2
                                                  )
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "In-Person Education",
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "DMSans",
                                                    color: controller.selectedEducation.value == 0
                                                        ? Colorstheam.white
                                                        : Colorstheam.nobelblack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 12.h),

                                        GestureDetector(
                                          onTap: () {
                                            controller.selectEducation(1);
                                          },
                                          child: Container(
                                            height: 44.h,
                                            width: 320.w,
                                            decoration: BoxDecoration(
                                                color: controller.selectedEducation.value == 1
                                                    ? Colors.transparent
                                                    : Colorstheam.clusterwhite,
                                                border: BoxBorder.all(
                                                    color: controller.selectedEducation.value == 1
                                                        ? Colorstheam.clusterwhite
                                                        : Colorstheam.clusterwhite,
                                                    width: 2
                                                )
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Online Education",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "DMSans",
                                                  color: controller.selectedEducation.value == 1
                                                      ? Colorstheam.white
                                                      : Colorstheam.nobelblack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                  ],
                )
            )
        ),
      )
    );
  }
}
