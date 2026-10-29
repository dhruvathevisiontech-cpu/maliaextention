// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Wishlistview extends GetView<Wishlistcontroller> {
  const Wishlistview({super.key});

  void _showCreateWishlistSheet() {
    Get.bottomSheet(
      _CreateWishlistSheet(
        onCreate: (name) {
          controller.createWishlist(name);
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }
  void _confirmDeleteWishlist(String id, String name) {
    Get.dialog(
      Dialog(
        backgroundColor: Colorstheam.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REMOVE WISHLIST',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: Colorstheam.grey,
                ),
              ),

              SizedBox(height: 14.h),

              Text(
                'Delete "$name"?',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                'This wishlist will be permanently removed. '
                    'Products in this collection will no longer be saved here.',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 13.sp,
                  height: 1.6,
                  color: Colorstheam.grey,
                ),
              ),

              SizedBox(height: 24.h),

              Container(
                height: 1.h,
                color: Colorstheam.clusterwhite,
              ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colorstheam.nobelblack,
                          side: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.deleteWishlist(id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colorstheam.nobelblack,
                          foregroundColor: Colorstheam.white,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  void _showRenameWishlistDialog(String id, String currentName) {
    Get.dialog<void>(
      RenameWishlistDialog(
        id: id,
        currentName: currentName,
        controller: controller,
      ),
      barrierDismissible: true,
    );
  }

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
                HapticFeedback.heavyImpact();
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
                onTap: (){
                  HapticFeedback.heavyImpact();
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
                icon: "asset/svg/cart.svg",
              ),
            ),
          ],
        ),
        body: Obx(() {
          final wishlists = controller.wishlists;
          final products = controller.wishlistProducts;
          if (products.isEmpty) {
            return _buildWishlistCollections(controller.wishlists);
          }
          final activeWishlist = controller.wishlists.firstWhereOrNull((wishlist) =>
            wishlist['id'].toString() == controller.activeWishlistId.value,
          );
          final wishlistName = activeWishlist?['name']?.toString() ?? 'My Wishlist';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wishlistName.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 14.sp,
                                color: Colorstheam.grey,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'Private',
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 13.sp,
                                  color: Colorstheam.grey,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${products.length} products',
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 13.sp,
                                  color: Colorstheam.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.shareWishlist(),
                      icon: Icon(
                        Icons.ios_share,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colorstheam.nobelblack,
                      ),
                      onSelected: (value) {
                        final id = activeWishlist?['id']?.toString();
                        if (id == null) return;

                        switch (value) {
                          case 'rename':
                            _showRenameWishlistDialog(id, wishlistName);
                            break;
                          case 'delete':
                            _confirmDeleteWishlist(id, wishlistName);
                            break;
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'rename',
                          child: Text('Rename'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete wishlist'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 0.48,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return _wishlistProductCard(
                      product: products[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colorstheam.nobelblack,
                      foregroundColor: Colorstheam.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'Add All to Cart',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  Widget _buildWishlistCollections(
      List<Map<String, dynamic>> wishlists,
      ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (wishlists.isEmpty) ...[
            Text(
              Apptext.wishlistemptytitle,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w600,
                color: Colorstheam.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              Apptext.wishlistemptysubtitle,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w300,
                color: Colorstheam.black.withValues(alpha: 0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MY WISHLISTS',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),
          ],
          SizedBox(height: 24.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wishlists.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              mainAxisExtent: 230.h,
            ),
            itemBuilder: (context, index) {
              if (index == wishlists.length) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _showCreateWishlistSheet,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colorstheam.clusterwhite,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              'asset/svg/plus.svg',
                              height: 14.h,
                              width: 14.w,
                              color: Colorstheam.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Create New',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final wishlist = wishlists[index];
              final id = wishlist['id'].toString();
              final name = wishlist['name']?.toString() ?? 'Wishlist';
              final savedProducts = wishlist['products'] as List? ?? [];
              final isSelected = controller.activeWishlistId.value == id;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.selectWishlist(id);
                },
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Colorstheam.nobelblack
                          : Colorstheam.clusterwhite,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 130.h,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                child: SizedBox.expand(
                                  child: savedProducts.isNotEmpty &&
                                      (savedProducts.first['image']?.toString().trim().isNotEmpty ?? false)
                                      ? Image.network(
                                    savedProducts.first['image'].toString().trim(),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        color: Colorstheam.alabastergrey,
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 18.w,
                                          height: 18.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colorstheam.nobelblack,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colorstheam.alabastergrey,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colorstheam.grey,
                                          size: 22.sp,
                                        ),
                                      );
                                    },
                                  )
                                      : Container(
                                    color: Colorstheam.alabastergrey,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colorstheam.grey,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
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
                      SizedBox(height: 4.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                          ),

                          PopupMenuButton<String>(
                            tooltip: 'Wishlist options',
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              minWidth: 230.w,
                              maxWidth: 255.w,
                            ),
                            color: Colorstheam.white,
                            elevation: 10,
                            shadowColor: Colorstheam.black.withValues(alpha: 0.12),
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                              side: BorderSide(
                                color: Colorstheam.clusterwhite,
                                width: 0.8,
                              ),
                            ),
                            icon: SizedBox(
                              width: 28.w,
                              height: 32.h,
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/svg/menu.svg',
                                  width: 17.w,
                                  height: 17.h,
                                ),
                              ),
                            ),
                            onSelected: (value) {
                              switch (value) {
                                case 'share':
                                  controller.shareWishlist();
                                  break;
                                case 'rename':
                                  _showRenameWishlistDialog(id, name);
                                  break;
                                case 'delete':
                                  _confirmDeleteWishlist(id, name);
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem<String>(
                                enabled: false,
                                height: 65.h,
                                padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 8.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'YOUR COLLECTION',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.1,
                                              color: Colorstheam.grey,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'Wishlist options',
                                            style: TextStyle(
                                              fontFamily: 'DMSans',
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colorstheam.nobelblack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 34.w,
                                      height: 34.h,
                                      decoration: BoxDecoration(
                                        color: Colorstheam.clusterwhite,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Icon(
                                        Icons.favorite_border_rounded,
                                        size: 18.sp,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              PopupMenuItem<String>(
                                value: 'share',
                                height: 64.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: _wishlistActionTile(
                                  icon: Icons.share_outlined,
                                  title: 'Share wishlist',
                                  subtitle: 'Share your favorite styles',
                                  iconColor: Colorstheam.nobelblack,
                                  iconBackground: Colorstheam.clusterwhite,
                                  showArrow: true,
                                ),
                              ),

                              PopupMenuItem<String>(
                                value: 'rename',
                                height: 64.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: _wishlistActionTile(
                                  icon: Icons.edit_outlined,
                                  title: 'Rename wishlist',
                                  subtitle: 'Give it a new name',
                                  iconColor: Colorstheam.nobelblack,
                                  iconBackground: Colorstheam.clusterwhite,
                                  showArrow: true,
                                ),
                              ),

                              PopupMenuItem<String>(
                                enabled: false,
                                height: 9.h,
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Divider(
                                  height: 1,
                                  thickness: 0.7,
                                  color: Colorstheam.clusterwhite,
                                ),
                              ),

                              PopupMenuItem<String>(
                                value: 'delete',
                                height: 64.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: _wishlistActionTile(
                                  icon: Icons.delete_outline_rounded,
                                  title: 'Delete wishlist',
                                  subtitle: 'Permanently remove this list',
                                  iconColor: Colorstheam.Racingred,
                                  iconBackground: Colorstheam.clusterwhite,
                                  titleColor: Colorstheam.Racingred,
                                  showArrow: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${savedProducts.length} products',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'DMSans',
                          color: Colorstheam.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _wishlistActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBackground,
    Color? titleColor,
    required bool showArrow,
  }) {
    return Row(
      children: [
        Container(
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(11.r),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 18.sp,
            color: iconColor,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colorstheam.nobelblack,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colorstheam.grey,
                ),
              ),
            ],
          ),
        ),
        if (showArrow) ...[
          SizedBox(width: 4.w),
          Icon(
            Icons.chevron_right_rounded,
            size: 17.sp,
            color: Colorstheam.grey,
          ),
        ],
      ],
    );
  }


  Widget _wishlistProductCard({
    required Map product,
  }) {
    final image = product["image"]?.toString() ?? "";
    final name = product["name"]?.toString() ?? "";
    final variant = product["variant"]?.toString() ?? "";
    final price = product["price"]?.toString() ?? "";
    final rating = product["rating"]?.toString() ?? "";
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.72,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colorstheam.white,
                  border: Border.all(
                    color: Colorstheam.clusterwhite,
                    width: 1.w,
                  ),
                ),
                child: ClipRRect(
                  child: image.isEmpty
                      ? Container(
                    color: Colorstheam.clusterwhite,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colorstheam.grey,
                      size: 24.sp,
                    ),
                  )
                      : Image.network(
                    image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
              
                      return Container(
                        color: Colorstheam.clusterwhite,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colorstheam.nobelblack,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colorstheam.clusterwhite,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colorstheam.grey,
                          size: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6.h,
              right: 6.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  final productId = product["id"]?.toString();
                  if (productId == null || productId.isEmpty) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/svg/star.svg",
                    width: 12.w,
                    height: 12.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "DMSans",
                      color: Colorstheam.grey,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 12.h),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.heavyImpact();
              },
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
      ],
    );
  }

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
        if (controller.wishlistProducts.isNotEmpty) {
          controller.activeWishlistId.value = '';
          controller.wishlistProducts.clear();
          return;
        }
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
          height: 22.h,
        ),
      ),
    );
  }
}


class _CreateWishlistSheet extends StatefulWidget {
  final ValueChanged<String> onCreate;

  const _CreateWishlistSheet({
    required this.onCreate,
  });

  @override
  State<_CreateWishlistSheet> createState() =>
      _CreateWishlistSheetState();
}

class _CreateWishlistSheetState
    extends State<_CreateWishlistSheet> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _createWishlist() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.error('Please enter a wishlist name.',);
      return;
    }

    widget.onCreate(name);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            20.w,
            12.h,
            20.w,
            24.h,
          ),
          decoration: BoxDecoration(
            color: Colorstheam.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colorstheam.grey,
                    borderRadius:
                    BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Create New Wishlist',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Give your wishlist a name to organize '
                    'your favorite products.',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14.sp,
                  color: Colorstheam.grey,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _nameController,
                autofocus: true,
                textCapitalization:
                TextCapitalization.words,
                maxLength: 40,
                cursorErrorColor: Colorstheam.nobelblack,
                cursorColor: Colorstheam.nobelblack,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _createWishlist(),
                decoration: InputDecoration(
                  hintText: 'e.g. Summer Favorites',
                  counterText: '',
                  hintStyle: TextStyle(
                    fontFamily: 'DMSans',
                    color: Colorstheam.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedButton(
                onTap: _createWishlist,
                child: Container(
                  height: 40.h,
                  color: Colorstheam.nobelblack,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Wishlist',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.clusterwhite
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RenameWishlistDialog extends StatefulWidget {
  final String id;
  final String currentName;
  final dynamic controller;

  const RenameWishlistDialog({
    super.key,
    required this.id,
    required this.currentName,
    required this.controller,
  });

  @override
  State<RenameWishlistDialog> createState() =>
      _RenameWishlistDialogState();
}

class _RenameWishlistDialogState
    extends State<RenameWishlistDialog> {
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.currentName,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _save() {
    final newName = nameController.text.trim();

    if (newName.isEmpty) {
      AppSnackbar.error('Please enter a wishlist name.');
      return;
    }

    if (newName == widget.currentName.trim()) {
      Get.back<void>();
      return;
    }

    widget.controller.renameWishlist(widget.id, newName);
    Get.back<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colorstheam.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: Colorstheam.clusterwhite,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 19.sp,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: Colorstheam.grey,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            Text(
              'Rename wishlist',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colorstheam.nobelblack,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              'Give your wishlist a new name.',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12.sp,
                color: Colorstheam.grey,
              ),
            ),

            SizedBox(height: 22.h),

            TextField(
              controller: nameController,
              autofocus: true,
              maxLength: 40,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colorstheam.nobelblack,
              ),
              decoration: InputDecoration(
                hintText: 'Wishlist name',
                counterText: '',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 12.h,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colorstheam.clusterwhite,
                    width: 1.2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colorstheam.nobelblack,
                    width: 1.4,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back<void>(),
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, 44.h),
                      foregroundColor: Colorstheam.grey,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorstheam.nobelblack,
                        foregroundColor: Colorstheam.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Save changes',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

