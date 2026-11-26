import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/HomemainScreen/checkoutwebview.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/animation/textselect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/HomemainScreen/viewcart/controller/viewcartcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:url_launcher/url_launcher.dart';

class Viewcart extends GetView<Viewcartcontroller> {
  const Viewcart({super.key});

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
          toolbarHeight: 58.h,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 12.w),
                Text(
                  Apptext.viewcarttitle,
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
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
                HapticFeedback.heavyImpact();
                final bottomNav = Get.find<Bottomnavigationcontroller>();
                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value = PageType.search;
              },
            ),
            SizedBox(width: 20.w),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: _headerIcon(
                icon: "asset/svg/wishlist.svg",
                onTap: () {
                  HapticFeedback.heavyImpact();
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
          return _buildCartList(cartItems, context);
        }),
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
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
            onTap: (){
              HapticFeedback.heavyImpact();
              final bottomNav = Get.find<Bottomnavigationcontroller>();
              bottomNav.selectedIndex.value = 1;
              bottomNav.currentPage.value = PageType.collection;
            },
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
          Obx(() {
            final cartController = controller.cartController;
            final products = cartController.recommendedProducts;
            if (cartController.isLoadingRecommendations.value &&
                products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (products.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
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
                SizedBox(height: 12.h),
                _buildHorizontalProductList1(context),
              ],
            );
          }),
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
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
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
          Padding(
            padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
            child: Divider(
              height: 1,
              color: Colorstheam.clusterwhite,
            ),
          ),
          SizedBox(height: 16.h),
          _buildOrderNoteSection(context),
          SizedBox(height: 24.h),
          _buildDiscountCouponSection(context),
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
  Widget _buildOrderNoteSection(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screensize.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Note",
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w700,
              color: Colorstheam.nobelblack,
            ),
          ),

          SizedBox(height: 5.h),

          Text(
            "Add any special instructions for your order.",
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w400,
              color: Colorstheam.dimgrey,
            ),
          ),

          SizedBox(height: 12.h),

          TextFormField(
            minLines: 3,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            cursorColor: Colorstheam.nobelblack,
            selectionControls: Textselect(),
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w500,
              color: Colorstheam.nobelblack,
            ),
            decoration: InputDecoration(
              hintText: "Write your note here...",
              hintStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: "DMSans",
                fontWeight: FontWeight.w400,
                color: Colorstheam.lightgrey,
              ),
              filled: true,
              fillColor: Colorstheam.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colorstheam.clusterwhite,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colorstheam.nobelblack,
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colorstheam.errorColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colorstheam.errorColor,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDiscountCouponSection(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screensize.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discount Coupon",
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w700,
              color: Colorstheam.nobelblack,
            ),
          ),

          SizedBox(height: 5.h),

          Text(
            "Have a promo code? Apply it here.",
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "DMSans",
              fontWeight: FontWeight.w400,
              color: Colorstheam.dimgrey,
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46.h,
                  child: TextFormField(
                    controller: controller.promoCodeController,
                    cursorColor: Colorstheam.nobelblack,
                    textCapitalization: TextCapitalization.characters,
                    selectionControls: Textselect(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter promo code",
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.lightgrey,
                      ),
                      filled: true,
                      fillColor: Colorstheam.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 13.w,
                        vertical: 12.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colorstheam.clusterwhite,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colorstheam.nobelblack,
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colorstheam.errorColor,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colorstheam.errorColor,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              AnimatedButton(
                onTap: controller.isApplyingPromoCode.value
                    ? null
                    : controller.applyPromoCode,
                child: controller.isApplyingPromoCode.value ? Container(
                  height: 46.h,
                  width: 105.w,
                  color: Colorstheam.grey,
                  alignment: Alignment.center,
                  child: Text(
                    "Processing...",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                ):
                Container(
                  height: 46.h,
                  width: 105.w,
                  color: Colorstheam.nobelblack,
                  alignment: Alignment.center,
                  child: Text(
                    "APPLY",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colorstheam.clusterwhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildDeliveryAddressSection(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colorstheam.white,
          border: Border.all(
            color: Colorstheam.clusterwhite,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18.sp,
                      color: Colorstheam.nobelblack,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      Apptext.deliveryto,
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
                Text(
                  "DELIVERY ADDRESS",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colorstheam.dimgrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Jems",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 13.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    child: Text(
                      "EDIT",
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 9.h),
            Text(
              "Home Name, Street Name, Area,\n"
                  "City, State, Country - Zip Code.\n"
                  "+1 12345 67890",
              style: TextStyle(
                fontFamily: "DMSans",
                fontSize: 12.sp,
                height: 1.6,
                fontWeight: FontWeight.w500,
                color: Colorstheam.dimgrey,
              ),
            ),
            SizedBox(height: 14.h),
            Divider(
              height: 1,
              color: Colorstheam.clusterwhite,
            ),
            SizedBox(height: 12.h),
            Obx(() {
              final selected = controller.isAddressSelected.value;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.selectionClick();
                  controller.isAddressSelected.value = !selected;
                },
                child: Row(
                  children: [
                    Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected
                              ? Colorstheam.nobelblack
                              : Colorstheam.grey,
                          width: 1.3,
                        ),
                      ),
                      child: selected
                          ? Center(
                        child: Icon(
                          Icons.check,
                          size: 13.sp,
                          color: Colorstheam.nobelblack,
                        ),
                      )
                          : null,
                    ),
                    SizedBox(width: 9.w),
                    Expanded(
                      child: Text(
                        "Use this address for delivery",
                        style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.dimgrey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: AnimatedButton(
                onTap: () {
                  HapticFeedback.heavyImpact();
                },
                child: Container(
                  color: Colorstheam.nobelblack,
                  alignment: Alignment.center,
                  child: Text(
                    Apptext.addnewaddress,
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.white,
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


  Widget _buildCartItemCard(
      Map item,
      int index,
      BuildContext context,
      ) {

    final price = double.tryParse(
      item["price"]?.toString() ?? "0",
    ) ?? 0.0;

    final currencyCode = item["currencyCode"]?.toString() ?? "USD";

    final imageUrl = (
        item["image"] ??
            item["featuredImage"]?["url"] ??
            ""
    ).toString().trim();

    final isValidImage = imageUrl.startsWith("https://") ||
        imageUrl.startsWith("http://");

    debugPrint("CART ITEM DATA: $item");
    debugPrint("PRODUCT PRICE: $price");
    debugPrint("CURRENCY: $currencyCode");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: isValidImage
                    ? Image.network(
                  imageUrl,
                  width: 112.w,
                  height: 126.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      _buildImagePlaceholder(),
                )
                    : _buildImagePlaceholder(),
              ),

              Positioned(
                top: 6.h,
                left: 6.w,
                child: GestureDetector(
                  onTap: () async {
                    HapticFeedback.heavyImpact();
                    await controller.removeItem(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    color: Colorstheam.white,
                    child: SvgPicture.asset(
                      "asset/svg/bin.svg",
                      width: 12.w,
                      height: 12.w,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 13.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"]?.toString() ??
                      item["title"]?.toString() ??
                      "Product Name",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: Colorstheam.nobelblack,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  '$currencyCode ${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 14.h),
                Obx(() {
                  final currentItem = controller.cartController.cartItems[index];
                  final quantity = int.tryParse(currentItem["quantity"]?.toString() ?? "1",) ?? 1;
                  final lineId = currentItem["lineId"]?.toString() ?? '';
                  final isUpdating = controller.cartController.isUpdating.value;
                  final isThisItemAnimating = controller.animatingLineId.value == lineId;
                  return AnimatedScale(
                    scale: isThisItemAnimating ? 0.94 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    child: Container(
                      height: 30.h,
                      width: 88.w,
                      decoration: BoxDecoration(
                        color: Colorstheam.white,
                        border: Border.all(
                          color: Colorstheam.nobelblack,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Decrease
                          Expanded(
                            child: _buildQuantityAction(
                              icon: "asset/svg/minimize.svg",
                              enabled: !isUpdating,
                              onTap: () => controller.decrementQuantity(index),
                            ),
                          ),
                          Container(
                            width: 28.w,
                            height: double.infinity,
                            color: Colorstheam.white,
                            alignment: Alignment.center,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                quantity.toString(),
                                key: ValueKey('$lineId-$quantity'),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: _buildQuantityAction(
                              icon: "asset/svg/plus.svg",
                              enabled: !isUpdating,
                              onTap: () => controller.incrementQuantity(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildQuantityAction({
    required String icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colorstheam.white,
      child: InkWell(
        onTap: enabled ? onTap : null,
        splashColor: Colorstheam.clusterwhite,
        highlightColor: Colorstheam.clusterwhite,
        child: SizedBox.expand(
          child: Center(
            child: SvgPicture.asset(
              icon
            )
          ),
        ),
      ),
    );
  }
  Widget _buildImagePlaceholder() {
    return Container(
      width: 120.w,
      height: 120.h,
      color: Colorstheam.lightgrey,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: Colorstheam.grey,
      ),
    );
  }
  Widget _buildHorizontalProductList(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final cartController = controller.cartController;

    return Obx(() {
      final products = cartController.recommendedProducts;

      if (cartController.isLoadingRecommendations.value) {
        return SizedBox(
          height: 250.h,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (products.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: 250.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: screensize.width * 0.04,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          separatorBuilder: (_, _) => SizedBox(width: 14.w),
          itemBuilder: (context, index) {
            final item = products[index];

            final name =
            (item['name'] ?? item['title'] ?? '').toString();

            final image = (item['image'] ?? '').toString();

            final price = double.tryParse(
              (item['price'] ?? '0').toString(),
            ) ??
                0.0;

            return SizedBox(
              width: 170.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Stack(
                    children: [
                      Container(
                        height: 155.h,
                        width: 170.w,
                        color: Colorstheam.lightgrey,
                        child: image.isNotEmpty
                            ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) {
                            return Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 32.sp,
                                color: Colorstheam.grey,
                              ),
                            );
                          },
                        )
                            : Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 32.sp,
                            color: Colorstheam.grey,
                          ),
                        ),
                      ),

                      // Wishlist Icon
                      Positioned(
                        top: 9.h,
                        right: 9.w,
                        child: Container(
                          height: 30.w,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colorstheam.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.favorite_border,
                            size: 16.sp,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 9.h),

                  // Product Name
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                    ),
                  ),

                  SizedBox(height: 7.h),

                  // Price and Add Button
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${price.toStringAsFixed(2)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w800,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),

                      SizedBox(width: 5.w),

                      GestureDetector(
                        onTap: () {
                          cartController.addRecommendedProduct(item);
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 13.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colorstheam.nobelblack,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: Colorstheam.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
  Widget _buildHorizontalProductList1(BuildContext context) {
    final cartController = controller.cartController;
    return Obx(() {
      final products = cartController.recommendedProducts;
      if (products.isEmpty) {
        return const SizedBox.shrink();
      }
      return SizedBox(
        height: 228.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          separatorBuilder: (_, _) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final product = products[index];
            final name = product['name']?.toString() ?? product['title']?.toString() ?? 'Product';
            final imageUrl = product['image']?.toString().isNotEmpty == true ? product['image'].toString() : product['featuredImage']?['url']?.toString() ?? '';
            final price = product['price']?.toString() ?? product['priceRange']?['minVariantPrice']?['amount']?.toString() ?? '0.00';
            final currencyCode = product['currencyCode']?.toString() ?? product['priceRange']?['minVariantPrice']?['currencyCode']?.toString() ??'USD';
            return SizedBox(
              width: 176.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 176.h,
                        width: 176.w,
                        color: Colorstheam.clusterwhite,
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                          const Center(
                            child: Icon(Icons.image),
                          ),
                        )
                            : const Center(
                          child: Icon(Icons.image),
                        ),
                      ),
                      Positioned(
                        top: 6.w,
                        right: 6.w,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colorstheam.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.sp,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 6.w,
                        right: 6.w,
                        child: GestureDetector(
                          onTap: () {
                            cartController.addRecommendedProduct(product);
                          },
                          child: Container(
                            padding: EdgeInsets.all(7.w),
                            decoration: BoxDecoration(
                              color: Colorstheam.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18.sp,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w600,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '$currencyCode $price',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }


  Widget _buildPriceDetailsSection(BuildContext context) {
    final cartController = controller.cartController;

    // Your current free-shipping threshold.
    const double freeShippingThreshold = 500.00;

    return Obx(() {
      final double subtotal = cartController.subtotal;
      final double total = cartController.total;
      final int quantity = cartController.totalQuantity;

      // Dynamic free-shipping calculation.
      final double remaining =
      (freeShippingThreshold - subtotal).clamp(0.0, freeShippingThreshold);

      final double progress =
      (subtotal / freeShippingThreshold).clamp(0.0, 1.0);

      final bool freeShippingUnlocked =
          subtotal >= freeShippingThreshold;

      // Read actual Shopify shipping charges from delivery groups.
      double shippingCharges = 0.0;
      bool hasShippingOption = false;

      for (final group in cartController.deliveryGroups) {
        final selectedOption =
        group['selectedDeliveryOption'] as Map?;

        if (selectedOption != null) {
          final estimatedCost =
          selectedOption['estimatedCost'] as Map?;

          if (estimatedCost != null) {
            shippingCharges += double.tryParse(
              estimatedCost['amount']?.toString() ?? '0',
            ) ??
                0.0;

            hasShippingOption = true;
          }
        }
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FREE SHIPPING MESSAGE - KEEPING YOUR EXPANDED VIEW
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colorstheam.clusterwhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 20.sp,
                        color: Colorstheam.nobelblack,
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: Text(
                          freeShippingUnlocked
                              ? "You've unlocked free shipping!"
                              : "Spend \$${remaining.toStringAsFixed(2)} more to reach free shipping!",
                          style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 7.h,
                      width: double.infinity,
                      color: Colorstheam.white,
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 22.h),

            Text(
              "Price Details",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: Colorstheam.nobelblack,
              ),
            ),

            SizedBox(height: 14.h),

            // SUBTOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal ($quantity ${quantity == 1 ? 'item' : 'items'})",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 13.sp,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                Text(
                  "\$${subtotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // SHIPPING CHARGES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Charges",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 13.sp,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                Text(
                  !hasShippingOption
                      ? "Calculated after address"
                      : shippingCharges == 0
                      ? "FREE"
                      : "\$${shippingCharges.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Divider(
              height: 1,
              color: Colorstheam.clusterwhite,
            ),

            SizedBox(height: 14.h),

            // ESTIMATED TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estimated total",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)} USD",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),

            SizedBox(height: 7.h),

            _buildCheckoutPlusSection(),

            SizedBox(height: 12.h),

            Text(
              "Taxes and final shipping charges may be confirmed at checkout.",
              style: TextStyle(
                fontFamily: "DMSans",
                fontSize: 11.sp,
                color: Colorstheam.dimgrey,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCheckoutPlusSection() {
    final cartController = controller.cartController;

    return Obx(() {
      final isAdded = cartController.isCheckoutPlusAdded;
      final isUpdating = cartController.isUpdating.value;

      // Show the actual cart-line price after Checkout+ is added.
      // Before adding, $2.98 is the provisional test price.
      Map? checkoutItem;

      for (final item in cartController.cartItems) {
        if (item['variantId'] == Cartcontroller.checkoutPlusVariantId) {
          checkoutItem = item;
          break;
        }
      }

      final price = double.tryParse(
        checkoutItem?['price']?.toString() ?? '',
      ) ??
          2.98;

      final currencyCode =
          checkoutItem?['currencyCode']?.toString() ?? 'USD';

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 18.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colorstheam.white,
          border: Border.all(
            color: Colorstheam.clusterwhite,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Checkout+",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                Text(
                  "$currencyCode ${price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),

            SizedBox(height: 7.h),

            Text(
              "Unlock free returns",
              style: TextStyle(
                fontFamily: "DMSans",
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colorstheam.dimgrey,
              ),
            ),

            SizedBox(height: 14.h),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colorstheam.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          title: Text(
                            "Checkout+",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          content: Text(
                            "Unlock free returns with Checkout+. "
                                "Add Checkout+ to your order to enjoy "
                                "this benefit.",
                            style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              height: 1.5,
                              color: Colorstheam.dimgrey,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                "CLOSE",
                                style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w700,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Learn more about Checkout+",
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                GestureDetector(
                  onTap: isUpdating
                      ? null
                      : () async {
                    HapticFeedback.selectionClick();

                    if (isAdded) {
                      await cartController.removeCheckoutPlus();
                    } else {
                      await cartController.addCheckoutPlus();
                    }
                  },
                  child: Container(
                    width: 94.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    color: isUpdating
                        ? Colorstheam.grey
                        : Colorstheam.nobelblack,
                    child: isUpdating
                        ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(
                          Colorstheam.white,
                        ),
                      ),
                    )
                        : Text(
                      isAdded ? "REMOVE" : "ADD",
                      style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                        color: Colorstheam.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomCheckoutBar() {
    final cartController = controller.cartController;
    return Obx(() {
      final total = cartController.total;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colorstheam.white,
          border: Border(
            top: BorderSide(
              color: Colorstheam.clusterwhite,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL AMOUNT",
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: Colorstheam.dimgrey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Obx(() {
                final isLoading = controller.isCheckoutLoading.value;

                return AnimatedButton(
                  onTap: () async {
                    HapticFeedback.heavyImpact();

                    if (isLoading) return;

                    if (cartController.cartItems.isEmpty) return;

                    controller.isCheckoutLoading.value = true;

                    try {
                      final checkoutUrl = cartController.checkoutUrl.value.trim();

                      if (checkoutUrl.isEmpty) {
                        debugPrint("CHECKOUT URL IS EMPTY");
                        return;
                      }

                      final uri = Uri.tryParse(checkoutUrl);

                      if (uri == null ||
                          !uri.hasScheme ||
                          !uri.hasAuthority ||
                          uri.scheme != "https") {
                        debugPrint("INVALID CHECKOUT URL: $checkoutUrl");
                        return;
                      }

                      Get.to(
                            () => CheckoutWebView(
                          checkoutUrl: checkoutUrl,
                        ),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    } catch (e) {
                      debugPrint("CHECKOUT ERROR: $e");
                    } finally {
                      controller.isCheckoutLoading.value = false;
                    }
                  },
                  child: Container(
                    height: 46.h,
                    color: Colorstheam.nobelblack,
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: isLoading
                          ? Row(
                        key: const ValueKey("loading"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 15.w,
                            height: 15.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colorstheam.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Flexible(
                            child: Text(
                              "Preparing Checkout...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.white,
                              ),
                            ),
                          ),
                        ],
                      )
                          : Row(
                        key: const ValueKey("checkout"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Proceed to Pay",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colorstheam.white,
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 16.sp,
                            color: Colorstheam.white,
                          ),
                        ],
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