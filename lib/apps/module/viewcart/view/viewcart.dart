import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';

class Viewcart extends GetView<Viewcartcontroller> {
  const Viewcart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;

    return AnnotatedRegion(
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
            padding: EdgeInsets.only(left: screensize.width * 0.04),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 12.w),
                Text(
                  Apptext.viewcarttitle,
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
              padding: EdgeInsets.only(right: screensize.width * 0.04),
              child: _headerIcon(
                icon: "asset/svg/wishlist.svg",
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 2;
                  bottomNav.currentPage.value = PageType.wishlist;
                },
              ),
            ),
          ],
        ),
        body: Obx(() {
          final cartItems = controller.cartController.cartItems;

          if (cartItems.isEmpty) {
            return _buildEmptyCartView(context);
          }

          return _buildCartList(cartItems,context);
        }),
      ),
    );
  }
  Widget _buildEmptyCartView(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          Text(
            "Your Cart is empty!",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "DMSans",
              color: Colorstheam.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            "Add your favorite items to bag.",
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w500,
              color: Colorstheam.nobelblack,
            ),
          ),
          SizedBox(height: 16.h),
          AnimatedButton(
            child: Container(
              height: 44.h,
              width: 171.w,
              color: Colorstheam.nobelblack,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Shop Best Sellers",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.clusterwhite,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 36.h),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screensize.width * 0.02),
              child: Text(
                "You May Also Like",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _buildHorizontalProductList1(context),
        ],
      ),
    );
  }
  Widget _buildCartList(List cartItems,BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screensize.height * 0.02),
          _buildDeliveryAddressSection(context),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return _buildCartItemCard(cartItems[index], index,context);
            },
          ),
          SizedBox(height: 16.h),
          AnimatedButton(
            child: Padding(
              padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
              child: Container(
                height: 40.h,
                color: Colorstheam.nobelblack,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Add More Items",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Divider(
              color: Colorstheam.clusterwhite,
              height: 1,
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
              child: Text(
                "Pair Well With",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _buildHorizontalProductList(context),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Divider(
              height: 1,
              color: Colorstheam.clusterwhite,
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
              child: Text(
                "Order Note:",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: TextFormField(
              minLines: 1,
              maxLines: null,
              cursorErrorColor: Colorstheam.errorColor,
              cursorColor: Colorstheam.nobelblack,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Notes",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.lightgrey,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.clusterwhite,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.errorColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.clusterwhite,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.clusterwhite,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colorstheam.clusterwhite,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
              child: Text(
                "Discount Coupon",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    child: TextFormField(
                      cursorErrorColor: Colorstheam.errorColor,
                      cursorColor: Colorstheam.nobelblack,
                      decoration: InputDecoration(
                        hintText: "Promo Code",
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.lightgrey
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.errorColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.errorColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedButton(
                  child: Container(
                    height: 40.h,
                    width: 124.w,
                    color: Colorstheam.nobelblack,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.clusterwhite
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          _buildPriceDetailsSection(context),
          SizedBox(height: 20.h),
          Obx(() {
            if (controller.cartController.cartItems.isEmpty) {
              return const SizedBox.shrink();
            }
            return _buildBottomCheckoutBar();
          }),
        ],
      ),
    );
  }
  Widget _buildDeliveryAddressSection(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screensize.width * 0.04,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 14.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colorstheam.clusterwhite,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Apptext.deliveryto,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "DMSans",
                fontWeight: FontWeight.w500,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Jems",
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "DMSans",
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => GestureDetector(
                    onTap: () {
                      controller.isAddressSelected.value =
                      !controller.isAddressSelected.value;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h),
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: Colorstheam.white,
                        border: Border.all(
                          color: controller.isAddressSelected.value
                              ? Colorstheam.nobelblack
                              : Colors.grey.shade500,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(5.5.r),
                      ),
                      child: controller.isAddressSelected.value
                          ? Center(
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: Colorstheam.nobelblack,
                            borderRadius: BorderRadius.circular(2.5.r),
                          ),
                        ),
                      )
                          : null,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Home Name, Street Name, Area,\n"
                        "City, State, Country - Zip Code.\n"
                        "+1 12345 67890",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedButton(
                  child: Container(
                    height: 28.h,
                    width: 68.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colorstheam.nobelblack,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      Apptext.btn,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: AnimatedButton(
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  color: Colorstheam.nobelblack,
                  alignment: Alignment.center,
                  child: Text(
                    Apptext.addnewaddress,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCartItemCard(Map item, int index,BuildContext context) {
    final product = item["product"] as Map? ?? {};
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.asset(
                    product["image"] ?? "",
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 120.w,
                      height: 120.h,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
                Positioned(
                  top: 6.h,
                  left: 6.w,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product["name"] ?? "Product Name",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "\$${product["price"] ?? '245'}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 80.w,
                    height: 30.h,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colorstheam.nobelblack,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () => controller.decrementQuantity(index),
                              child: Center(
                                child: SvgPicture.asset(
                                  "asset/svg/minimize.svg",
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
                                "${item["quantity"] ?? 1}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => controller.incrementQuantity(index),
                              child: Center(
                                child: SvgPicture.asset(
                                  "asset/svg/plus.svg",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildHorizontalProductList(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
      child: SizedBox (
        height: 228.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 176.h,
                        width: 176.w,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                      Positioned(
                        top: 6.w,
                        right: 6.w,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite_border, size: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    index == 0 ? "Genius Weft" : "Keratin Bond Tips(K-Tip)",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    index == 0 ? "\$160.00" : "\$85.00",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildHorizontalProductList1(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screensize.width * 0.02,right: screensize.width * 0.02),
      child: SizedBox (
        height: 228.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 176.h,
                        width: 176.w,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                      Positioned(
                        top: 6.w,
                        right: 6.w,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite_border, size: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    index == 0 ? "Genius Weft" : "Keratin Bond Tips(K-Tip)",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    index == 0 ? "\$160.00" : "\$85.00",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.nobelblack
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildPriceDetailsSection(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        shape: Border(
          top: BorderSide(
            color: Colorstheam.clusterwhite,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colorstheam.clusterwhite,
            width: 1,
          ),
          right: BorderSide(
            color: Colorstheam.clusterwhite,
            width: 1
          ),
          left: BorderSide(
            color: Colorstheam.clusterwhite,
            width: 1
          )
        ),
        collapsedIconColor: Colorstheam.nobelblack,
        iconColor: Colorstheam.nobelblack,
        trailing: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 22.sp,
            color: Colorstheam.nobelblack,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: screensize.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Price Details",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack
                ),
              ),
              Text(
                "\$490.00",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Bag Amount (2 items)",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack
                    )
                ),
                Text("\$490.00",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: screensize.height * 0.01),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    "Shipping",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack
                    )
                ),
                Row(
                  children: [
                    Text("\$30.00 ",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            color: Colorstheam.nobelblack,
                            decoration: TextDecoration.lineThrough,
                        )
                    ),
                    Text("Free",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            color: Colorstheam.seagreen,
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screensize.height * 0.01),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Divider(
              color: Colorstheam.clusterwhite,
              height: 1,
            ),
          ),
          SizedBox(height: screensize.height * 0.01),
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("You Pay",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    )
                ),
                Text("\$490.00",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: screensize.height * 0.01),
        ],
      ),
    );
  }
  Widget _buildBottomCheckoutBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\$490.00",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack
                  )
              ),
              Text("Total",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack
                  )
              ),
            ],
          ),
          AnimatedButton(
            onTap: (){
              final bottomNav = Get.find<Bottomnavigationcontroller>();
              bottomNav.selectedIndex.value = 0;
              bottomNav.currentPage.value = PageType.orderplace;
            },
            child: Container(
              height: 40.h,
              width: 171.w,
              color: Colorstheam.nobelblack,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    fontSize: 16.h,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.clusterwhite
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
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

  Widget _headerIcon({required String icon, VoidCallback? onTap}) {
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