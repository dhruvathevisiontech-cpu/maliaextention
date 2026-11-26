import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/controller/salonlocatorcontroller.dart';
class Salonlocatorview extends GetView<Salonlocatorcontroller> {
  const Salonlocatorview({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colorstheam.white,
        appBar: _appBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colorstheam.nobelblack,
              ),
            );
          }
          return Column(
            children: [
              _heroBanner(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 700) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 350,
                            child: _sidebar(),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                0, 16, 16, 16,
                              ),
                              child: _mapPanel(),
                            ),
                          ),
                        ],
                      );
                    }
                    return _mobileLayout();
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  PreferredSizeWidget _appBar() {
    return AppBar(
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _backButton(),
            SizedBox(width: 13.w),
            Expanded(
              child: Text(
                Apptext.salonlocatortitle,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontFamily: 'Urbanist',
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
  Widget _heroBanner() {
    return SizedBox(
      height: 125.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'asset/image/salon-locator-banner.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colorstheam.nobelblack,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.72),
                  Colors.black.withOpacity(0.30),
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'THE MALIA EXPERIENCE',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.5,
                    color: Colorstheam.white,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  'FIND YOUR MALIA STYLIST',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Colorstheam.white,
                  ),
                ),
                SizedBox(height: 7.h),
                Container(
                  width: 32.w,
                  height: 1.h,
                  color: Colorstheam.white,
                ),
                SizedBox(height: 6.h),
                Text(
                  'Discover professional stylists and experience '
                      'the art of beautiful Malia hair extensions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: 'DMSans',
                    height: 1.3,
                    color: Colorstheam.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _mobileLayout() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 15.h, 16.w, 12.h),
          child: _searchField(),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 230.h,
            child: _mapPanel(),
          ),
        ),

        SizedBox(height: 12.h),

        Expanded(
          child: _salonList(),
        ),
      ],
    );
  }
  Widget _sidebar() {
    return Container(
      color: Colorstheam.white,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colorstheam.clusterwhite,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 23.h, 18.w, 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OUR SALON NETWORK',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Find your stylist.',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Search our network of professional Malia salons.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'DMSans',
                    height: 1.5,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 17.h),
                _searchField(),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colorstheam.clusterwhite,
          ),
          Expanded(
            child: _salonList(),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: Colorstheam.white,
        border: Border.all(
          color: Colorstheam.Silver,
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w),
          Icon(
            Icons.search,
            size: 21.sp,
            color: Colorstheam.dimgrey,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              onChanged: controller.searchSalons,
              onSubmitted: controller.searchSalons,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'DMSans',
                color: Colorstheam.nobelblack,
              ),
              decoration: InputDecoration(
                hintText: 'Search salon, city or postcode',
                hintStyle: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'DMSans',
                  color: Colorstheam.dimgrey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () => controller.searchSalons(''),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.close,
                  size: 17.sp,
                  color: Colorstheam.dimgrey,
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () {
              controller.searchSalons(
                controller.searchQuery.value,
              );
            },
            child: Container(
              width: 52.w,
              height: double.infinity,
              color: Colorstheam.nobelblack,
              child: Icon(
                Icons.arrow_forward,
                color: Colorstheam.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _salonList() {
    return Obx(() {
      final salons = controller.filteredSalons;
      final selected = controller.selectedSalon.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECTION HEADER
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 13.h, 18.w, 12.h),
            child: Row(
              children: [
                Text(
                  'SALON LOCATIONS',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colorstheam.clusterwhite,
                  ),
                  child: Text(
                    '${salons.length} RESULTS',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (selected != null) _selectedSalonDetails(selected),
          Expanded(
            child: salons.isEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_off_outlined,
                      size: 30.sp,
                      color: Colorstheam.Silver,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'No salons found',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Try searching with another salon name, city or postcode.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: 'DMSans',
                        height: 1.5,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.separated(
              padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 20.h),
              itemCount: salons.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 0.7,
                color: Colorstheam.clusterwhite,
              ),
              itemBuilder: (context, index) {
                final salon = salons[index];
                final name =
                    salon['name']?.toString().trim() ?? 'Salon';
                final address = _salonAddress(salon);
                final phone =
                    salon['phone']?.toString().trim() ?? '';

                final isSelected =
                    selected?['stockist_id']?.toString() ==
                        salon['stockist_id']?.toString();

                return Material(
                  color: isSelected
                      ? Colorstheam.clusterwhite
                      : Colorstheam.white,
                  child: InkWell(
                    onTap: () => controller.selectSalon(salon),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.fromLTRB(
                        12.w,
                        15.h,
                        10.w,
                        15.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: isSelected
                                ? Colorstheam.nobelblack
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // RESULT NUMBER
                          SizedBox(
                            width: 30.w,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Text(
                                (index + 1)
                                    .toString()
                                    .padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colorstheam.nobelblack
                                      : Colorstheam.Silver,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          // SALON INFORMATION
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),

                                if (address.isNotEmpty) ...[
                                  SizedBox(height: 6.h),
                                  Text(
                                    address,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10.5.sp,
                                      fontFamily: 'DMSans',
                                      height: 1.45,
                                      color: Colorstheam.dimgrey,
                                    ),
                                  ),
                                ],

                                if (phone.isNotEmpty) ...[
                                  SizedBox(height: 7.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        size: 12.sp,
                                        color: Colorstheam.dimgrey,
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          phone,
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'DMSans',
                                            fontWeight:
                                            FontWeight.w500,
                                            color:
                                            Colorstheam.nobelblack,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),

                          SizedBox(width: 8.w),

                          // SELECT INDICATOR
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Icon(
                              isSelected
                                  ? Icons.check
                                  : Icons.arrow_outward,
                              size: 16.sp,
                              color: isSelected
                                  ? Colorstheam.nobelblack
                                  : Colorstheam.Silver,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
  Widget _selectedSalonDetails(Map<String, dynamic> salon) {
    final String name = salon['name']?.toString() ?? 'Salon';
    final String address = _salonAddress(salon);
    final String phone = salon['phone']?.toString().trim() ?? '';

    final String website = [
      salon['website'],
      salon['website_url'],
      salon['url'],
    ]
        .where(
          (value) =>
      value != null && value.toString().trim().isNotEmpty,
    )
        .map((value) => value.toString().trim())
        .firstOrNull ?? '';

    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colorstheam.clusterwhite,
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'YOUR SELECTED SALON',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colorstheam.dimgrey,
                ),
              ),

              const Spacer(),

              GestureDetector(
                onTap: controller.clearSelectedSalon,
                child: Icon(
                  Icons.close,
                  size: 18.sp,
                  color: Colorstheam.dimgrey,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Text(
            name,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              color: Colorstheam.nobelblack,
            ),
          ),

          if (address.isNotEmpty) ...[
            SizedBox(height: 11.h),
            _detailRow(Icons.location_on_outlined, address),
          ],

          if (phone.isNotEmpty) ...[
            SizedBox(height: 9.h),
            _detailRow(Icons.phone_outlined, phone),
          ],

          if (website.isNotEmpty) ...[
            SizedBox(height: 9.h),
            _detailRow(Icons.language, website),
          ],

          SizedBox(height: 14.h),

          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.openSalonDirections(salon);
              },
              icon: Icon(
                Icons.directions_outlined,
                size: 18.sp,
              ),
              label: Text(
                'GET DIRECTIONS',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colorstheam.nobelblack,
                foregroundColor: Colorstheam.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _detailRow(IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 15.sp,
          color: Colorstheam.dimgrey,
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: 'DMSans',
              height: 1.5,
              color: Colorstheam.nobelblack,
            ),
          ),
        ),
      ],
    );
  }
  String _salonAddress(Map<String, dynamic> salon) {
    return [salon['address_line_1'], salon['address_line_2'], salon['city'], salon['state_province'], salon['postal_code'], salon['country'],
    ].where((value) => value != null && value.toString().trim().isNotEmpty,).map((value) => value.toString().trim()).join(', ');
  }
  Widget _mapPanel() {
    return Obx(
          () => Stack(
        children: [
          GoogleMap(
            key: const ValueKey('salon_locator_map'),
            initialCameraPosition:
            Salonlocatorcontroller.initialCameraPosition,
            markers: controller.markers.toSet(),
            myLocationEnabled:
            controller.hasLocationPermission.value,
            myLocationButtonEnabled: false,
            onMapCreated: controller.onMapCreated,
            onCameraMove: controller.onCameraMove,
            onCameraIdle: controller.onCameraIdle,
          ),

          Positioned(
            top: 13.h,
            left: 13.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: Colorstheam.white,
                borderRadius: BorderRadius.circular(5.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 14.sp,
                    color: Colorstheam.nobelblack,
                  ),
                  SizedBox(width: 7.w),
                  Text(
                    'EXPLORE MAP',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 13.w,
            bottom: 16.h,
            child: Material(
              color: Colorstheam.white,
              elevation: 4,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: controller.isGettingLocation.value
                    ? null
                    : controller.getCurrentLocation,
                child: SizedBox(
                  width: 46.w,
                  height: 46.w,
                  child: Center(
                    child: controller.isGettingLocation.value
                        ? SizedBox(
                      width: 19.w,
                      height: 19.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colorstheam.nobelblack,
                      ),
                    )
                        : Icon(
                      Icons.my_location,
                      size: 21.sp,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.heavyImpact();
        final bottomNav = Get.find<Bottomnavigationcontroller>();
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
            'asset/svg/arrowleft.svg',
            width: 10.w,
            height: 10.h,
          ),
        ),
      ),
    );
  }
}