
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/ProfileScreen/editaddress/controller/editaddresscontroller.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/controller/addresslistcontroller.dart';

class Addresslistview extends GetView<Addresslistcontroller> {
  const Addresslistview({super.key});

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
                  Apptext.addresstitle,
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
                final bottomNav =
                Get.find<Bottomnavigationcontroller>();

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
                icon: "asset/svg/cart.svg",
                onTap: () {
                  final bottomNav =
                  Get.find<Bottomnavigationcontroller>();

                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.viewcart;
                },
              ),
            ),
          ],
        ),

        // ADDRESS LIST
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Urbanist",
                        color: Colorstheam.grey,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: controller.retryFetchAddresses,
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.addresses.isEmpty) {
            return _emptyAddressView();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  20.h,
                  16.w,
                  0,
                ),
                child: Text(
                  Apptext.selectanaddress,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    0,
                    16.w,
                    120.h,
                  ),
                  itemCount: controller.addresses.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 14.h);
                  },
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> address = controller.addresses[index];
                    return Obx((){
                      final bool selected = controller.selectedAddress.value == index;
                      debugPrint('CARD $index | SELECTED: $selected');
                      return _addressCard(
                        address: address,
                        isSelected:
                        controller.selectedAddress.value == index,
                        onSelect: () {
                          debugPrint('ADDRESS TAPPED: $index');
                          controller.selectAddress(index);
                        },
                        onEdit: () {
                          final Editaddresscontroller editController =
                          Get.isRegistered<Editaddresscontroller>()
                              ? Get.find<Editaddresscontroller>()
                              : Get.put(Editaddresscontroller());

                          // Fill the selected address in the edit form.
                          editController.setAddressForEdit(address);

                          // Navigate to your separate Edit Address screen.
                          final bottomNav =
                          Get.find<Bottomnavigationcontroller>();

                          bottomNav.selectedIndex.value = 4;
                          bottomNav.currentPage.value = PageType.editaddress;
                        },
                        onDelete: () {
                          _showDeleteDialog(context, index);
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          );
        }),

        // ADD NEW ADDRESS BUTTON
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              16.w,
              12.h,
              16.w,
              16.h,
            ),
            decoration: BoxDecoration(
              color: Colorstheam.white,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HapticFeedback.heavyImpact();

                final bottomNav =
                Get.find<Bottomnavigationcontroller>();

                bottomNav.selectedIndex.value = 4;
                bottomNav.currentPage.value = PageType.saveaddress;
              },
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colorstheam.nobelblack,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colorstheam.white.withValues(
                          alpha: 0.12,
                        ),
                      ),
                      child: SvgPicture.asset(
                        "asset/svg/plus.svg",
                        height: 5.h,
                        color: Colorstheam.clusterwhite,
                      ),
                    ),
                    SizedBox(width: 9.w),
                    Text(
                      Apptext.addnewaddress1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 0.1,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        color: Colorstheam.clusterwhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ADDRESS CARD
  Widget _addressCard({
    required Map<String, dynamic> address,
    required bool isSelected,
    required VoidCallback onSelect,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    final String locationDetails = [
      address["city"],
      address["state"],
      address["pincode"],
    ]
        .where((value) =>
    value != null &&
        value.toString().trim().isNotEmpty)
        .join(", ");

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        onSelect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colorstheam.nobelblack.withValues(alpha: 0.035)
              : Colorstheam.white,
          border: Border.all(
            color: isSelected
                ? Colorstheam.nobelblack
                : Colorstheam.clusterwhite,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colorstheam.nobelblack.withValues(
                alpha: 0.08,
              ),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _addressTypeBadge(
                  address["type"] ?? "ADDRESS",
                ),
                const Spacer(),
                if (address["isDefault"] == true)
                  _defaultBadge(),
                SizedBox(width: 10.w),
                _selectionIndicator(
                  isSelected: isSelected,
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Text(
              address["name"] ?? "",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              address["address"] ?? "",
              style: TextStyle(
                height: 1.4,
                fontSize: 14.5.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w500,
                color: Colorstheam.nobelblack,
              ),
            ),

            if (address["address2"] != null &&
                address["address2"].toString().trim().isNotEmpty) ...[
              SizedBox(height: 3.h),
              Text(
                address["address2"],
                style: TextStyle(
                  height: 1.4,
                  fontSize: 14.sp,
                  fontFamily: "Urbanist",
                  color: Colorstheam.grey,
                ),
              ),
            ],
            if (locationDetails.isNotEmpty) ...[
              SizedBox(height: 3.h),
              Text(
                locationDetails,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 14.sp,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w400,
                  color: Colorstheam.grey,
                ),
              ),
            ],
            SizedBox(height: 3.h),
            Text(
              address["country"] ?? "",
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w400,
                color: Colorstheam.grey,
              ),
            ),

            if (address["phone"] != null &&
                address["phone"].toString().trim().isNotEmpty) ...[
              SizedBox(height: 3.h),
              Text(
                "${address["dialCode"] ?? ""} ${address["phone"]}",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: "Urbanist",
                  color: Colorstheam.grey,
                ),
              ),
            ],
            SizedBox(height: 9.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 15.sp,
                        color: Colorstheam.grey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "Set as default",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25.h,
                    child: Transform.scale(
                      scale: 0.75,
                      alignment: Alignment.centerRight,
                      child: Switch.adaptive(
                        value: address["isDefault"] == true,
                        activeTrackColor: Colorstheam.nobelblack,
                        inactiveTrackColor: Colorstheam.lightgrey,
                        onChanged: (value) {
                          if (value) {
                            HapticFeedback.selectionClick();

                            final index = controller.addresses.indexWhere(
                                  (item) => item["id"] == address["id"],
                            );

                            if (index != -1) {
                              controller.setDefaultAddress(index);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16.h),
            Container(
              height: 1,
              width: double.infinity,
              color: Colorstheam.clusterwhite,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _addressAction(
                    title: "Edit Address",
                    onTap: onEdit,
                  ),
                ),
                Container(
                  width: 1,
                  height: 20.h,
                  color: Colorstheam.clusterwhite,
                ),
                Expanded(
                  child: _addressAction(
                    title: "Remove",
                    isDelete: true,
                    onTap: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SELECTED ADDRESS INDICATOR
  Widget _selectionIndicator({required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? Colorstheam.nobelblack
            : Colorstheam.white,
        border: Border.all(
          color: isSelected
              ? Colorstheam.nobelblack
              : Colorstheam.grey,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Icon(
        Icons.check,
        size: 14.sp,
        color: Colorstheam.white,
      )
          : null,
    );
  }

  // ADDRESS TYPE BADGE
  Widget _addressTypeBadge(String type) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: Colorstheam.nobelblack,
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 9.5.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: Colorstheam.white,
        ),
      ),
    );
  }

  // DEFAULT BADGE
  Widget _defaultBadge() {
    return Text(
      "DEFAULT",
      style: TextStyle(
        fontSize: 9.5.sp,
        letterSpacing: 0.7,
        fontFamily: "Urbanist",
        fontWeight: FontWeight.w700,
        color: Colorstheam.grey,
      ),
    );
  }

  // ADDRESS ACTION BUTTON
  Widget _addressAction({
    required String title,
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 32.h,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.5.sp,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w600,
              color: isDelete
                  ? Colors.grey.shade600
                  : Colorstheam.nobelblack,
            ),
          ),
        ),
      ),
    );
  }

  // EMPTY ADDRESS VIEW
  Widget _emptyAddressView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 35.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 74.w,
              height: 74.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colorstheam.clusterwhite,
              ),
              child: Icon(
                Icons.location_on_outlined,
                size: 34.sp,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "No saved addresses",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: Colorstheam.nobelblack,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Add your address for a faster and easier checkout experience.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DELETE CONFIRMATION BOTTOM SHEET
  void _showDeleteDialog(
      BuildContext context,
      int index,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            20.w,
            20.h,
            20.w,
            25.h,
          ),
          decoration: BoxDecoration(
            color: Colorstheam.white,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colorstheam.clusterwhite,
                  ),
                ),
                SizedBox(height: 22.h),
                Text(
                  "Remove Address?",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Are you sure you want to remove this address?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Get.back();
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.nobelblack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          HapticFeedback.heavyImpact();
                          Get.back();
                          await controller.deleteAddress(index);
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colorstheam.nobelblack,
                          ),
                          child: Center(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.white,
                              ),
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
      },
    );
  }

  // BACK BUTTON
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();

        final Bottomnavigationcontroller bottomNav =
        Get.find<Bottomnavigationcontroller>();

        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
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

  // HEADER ICON
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
