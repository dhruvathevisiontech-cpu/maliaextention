// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/controller/searchcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Searchview extends GetView<Searchdatacontroller> {
  Searchview({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
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
            leadingWidth: 50.w,
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.heavyImpact();
                final bottomNav =
                Get.find<Bottomnavigationcontroller>();

                bottomNav.selectedIndex.value = 0;
                bottomNav.currentPage.value =
                    PageType.home;
              },
              child: Padding(
                padding: EdgeInsets.only(left: screensize.width * 0.04),
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
              ),
            ),
            title: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(
                    (1 - value) * 30.w,
                    0,
                  ),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: screensize.width * 0.02,
                ),
                child: Container(
                  height: 46.h,
                  margin: EdgeInsets.only(
                    right: screensize.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      color: Colorstheam.clusterwhite
                    )
                  ),
                  child:

                  TextField(
                    controller: controller.searchTextController,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: controller.onSearchChanged,
                    onSubmitted: controller.submitSearch,
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.nobelblack,
                    ),
                    cursorColor: Colorstheam.nobelblack,
                    decoration: InputDecoration(
                      hintText: "Search hair extensions...",
                      hintStyle: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.lightgrey,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 10.w),
                        child: SvgPicture.asset(
                          "asset/svg/search.svg",
                          width: 18.w,
                          height: 18.h,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 42.w,
                        minHeight: 46.h,
                      ),
                      suffixIcon: Obx(
                            () => controller.searchText.value.isNotEmpty
                            ? IconButton(
                          onPressed: controller.clearSearch,
                          icon: Icon(
                            Icons.close,
                            size: 19.sp,
                            color: Colorstheam.nobelblack,
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.only(left: 14.w, right: 10.w),
                          child: SvgPicture.asset(
                            "asset/svg/mic.svg",
                            width: 18.w,
                            height: 18.h,
                          ),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 45.w,
                        minHeight: 46.h,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )


                ),
              ),
            ),
          ),
        body: Obx(() {
          final hasQuery = controller.searchText.value.trim().isNotEmpty;

          if (!hasQuery) {
            return ListView(
              padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 24.h),
              children: [
                _searchSectionTitle('RECENT SEARCHES'),
                SizedBox(height: 14.h),
                if (controller.recentSearches.isEmpty)
                  Text(
                    'Your recent searches will appear here.',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colorstheam.grey,
                    ),
                  )
                else
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: controller.recentSearches.map((term) {
                      return ActionChip(
                        label: Text(
                          term,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        backgroundColor: Colorstheam.white,
                        side: BorderSide(color: Colorstheam.clusterwhite),
                        onPressed: () => controller.selectRecentSearch(term),
                      );
                    }).toList(),
                  ),
              ],
            );
          }

          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colorstheam.black),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colorstheam.grey,
                  ),
                ),
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 30.h),
            children: [
              // RELATED PRODUCTS
              if (controller.products.isNotEmpty) ...[
                _searchSectionTitle('RELATED PRODUCTS'),
                SizedBox(height: 12.h),
                ...controller.products.map(
                      (product) => _buildSearchProduct(product),
                ),
                SizedBox(height: 22.h),
              ],

              // SUGGESTIONS
              if (controller.suggestions.isNotEmpty) ...[
                _searchSectionTitle('SUGGESTIONS'),
                SizedBox(height: 10.h),
                ...controller.suggestions.map(
                      (term) => _buildSearchSuggestion(term),
                ),
                SizedBox(height: 22.h),
              ],

              // COLLECTIONS
              if (controller.collections.isNotEmpty) ...[
                _searchSectionTitle('COLLECTIONS'),
                SizedBox(height: 10.h),
                ...controller.collections.map(
                      (collection) => _buildSearchCollection(collection),
                ),
              ],

              if (controller.products.isEmpty &&
                  controller.suggestions.isEmpty &&
                  controller.collections.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Center(
                    child: Text(
                      'No results found for "${controller.searchText.value}".',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.grey,
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

  Widget _searchSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'DMSans',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: Colorstheam.arabiangrey,
      ),
    );
  }

  Widget _buildSearchProduct(Map<String, String> product) {
    final imageUrl = product['image'] ?? '';

    return InkWell(
      onTap: () {
        Get.find<Bottomnavigationcontroller>()
            .openProductDetails(product);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: SizedBox(
                width: 94.w,
                height: 112.h,
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.image_outlined,
                    color: Colorstheam.grey,
                  ),
                )
                    : Icon(
                  Icons.image_outlined,
                  color: Colorstheam.grey,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '15 Minutes Per Row',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.grey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      product['priceLabel'] ?? 'Login to See Price',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestion(String term) {
    return InkWell(
      onTap: () => controller.selectSuggestion(term),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 18.sp,
              color: Colorstheam.grey,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                term,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),
            Icon(
              Icons.north_west,
              size: 15.sp,
              color: Colorstheam.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCollection(Map<String, String> collection) {
    final imageUrl = collection['image'] ?? '';

    return InkWell(
      onTap: () {
        controller.selectSuggestion(collection['name'] ?? '');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: SizedBox(
                width: 54.w,
                height: 54.h,
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.collections_outlined,
                    color: Colorstheam.grey,
                  ),
                )
                    : Icon(
                  Icons.collections_outlined,
                  color: Colorstheam.grey,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                collection['name'] ?? '',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 13.sp,
              color: Colorstheam.grey,
            ),
          ],
        ),
      ),
    );
  }

}
