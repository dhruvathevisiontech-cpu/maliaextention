import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/controller/profilecontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Profileview extends GetView<Profilecontroller> {
  const Profileview({super.key});

  @override
  Widget build(BuildContext context) {
    final Bottomnavigationcontroller bottomController = Get.find<Bottomnavigationcontroller>();
    return Scaffold(
      backgroundColor: Colorstheam.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(bottomController),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      _buildWelcomeSection(),
                      SizedBox(height: 22.h),
                      _buildProfileButton(),
                      SizedBox(height: 32.h),
                      _menuItem(
                        title: 'Salon Locator',
                        asset: 'asset/svg/salonlocator.svg',
                        onTap: () =>
                            _navigate(bottomController, PageType.salonlocator),
                      ),
                      _divider(),
                      _menuItem(
                        title: 'Profile Details',
                        asset: 'asset/svg/profile.svg',
                        onTap: () => _navigate(
                          bottomController,
                          PageType.profiledetails,
                        ),
                      ),
                      _divider(),
                      _menuItem(
                        title: 'My Courses',
                        asset: 'asset/svg/cource.svg',
                        onTap: () {},
                      ),
                      _divider(),
                      _menuItem(
                        title: 'Address Book',
                        asset: 'asset/svg/address.svg',
                        onTap: () =>
                            _navigate(bottomController, PageType.addresslist),
                      ),
                      _divider(),
                      _menuItem(
                        title: 'Order History',
                        asset: 'asset/svg/orders.svg',
                        onTap: () =>
                            _navigate(bottomController, PageType.orderhistory),
                      ),
                      _divider(),
                      _buildInformationSection(bottomController),
                      _divider(),
                      SizedBox(height: 28.h),
                      Text(
                        'ACCOUNT SETTINGS',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                          color: Colorstheam.grey,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _accountAction(title: 'Delete Account', onTap: () {}),
                      _divider(),
                      _accountAction(
                        title: 'Log Out',
                        onTap: () {
                          controller.showLogoutBottomSheet();
                        },
                      ),
                      SizedBox(height: 28.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(Bottomnavigationcontroller bottomController) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colorstheam.clusterwhite, width: 0.7),
        ),
      ),
      child: Row(
        children: [
          _headerIcon(
            asset: 'asset/svg/arrowleft.svg',
            onTap: () => _navigate(bottomController, PageType.home, index: 0),
          ),

          SizedBox(width: 18.w),

          Expanded(
            child: Text(
              Apptext.profileappbartitle,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),

          _headerIcon(
            asset: 'asset/svg/search.svg',
            onTap: () => _navigate(bottomController, PageType.search, index: 0),
          ),

          SizedBox(width: 18.w),

          _headerIcon(
            asset: 'asset/svg/cart.svg',
            onTap: () =>
                _navigate(bottomController, PageType.viewcart, index: 0),
          ),
        ],
      ),
    );
  }

  Widget _headerIcon({required String asset, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 26.w,
        height: 38.h,
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: 19.w,
            height: 19.h,
            colorFilter: ColorFilter.mode(
              Colorstheam.nobelblack,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Apptext.profilewelcome,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 27.sp,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: Colorstheam.nobelblack,
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          Apptext.profilewelcomesubtitle,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12.sp,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Colorstheam.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileButton() {
    return GestureDetector(
      onTap: () {
        // Add your preferred profile action here.
      },
      child: Container(
        width: double.infinity,
        height: 46.h,
        alignment: Alignment.center,
        color: Colorstheam.nobelblack,
        child: Text(
          Apptext.profilebtntext,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colorstheam.white,
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required String title,
    required String asset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 56.h,
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              width: 19.w,
              height: 19.h,
              colorFilter: ColorFilter.mode(
                Colorstheam.nobelblack,
                BlendMode.srcIn,
              ),
            ),

            SizedBox(width: 15.w),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ),

            Icon(Icons.chevron_right, size: 19.sp, color: Colorstheam.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationSection(Bottomnavigationcontroller bottomController) {
    return Obx(
      () => Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.isProfileExpanded.toggle();
            },
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'asset/svg/information.svg',
                    width: 19.w,
                    height: 19.h,
                    colorFilter: ColorFilter.mode(
                      Colorstheam.nobelblack,
                      BlendMode.srcIn,
                    ),
                  ),

                  SizedBox(width: 15.w),

                  Expanded(
                    child: Text(
                      'Information',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ),

                  Icon(
                    controller.isProfileExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 19.sp,
                    color: Colorstheam.grey,
                  ),
                ],
              ),
            ),
          ),

          if (controller.isProfileExpanded.value)
            Padding(
              padding: EdgeInsets.only(left: 34.w, bottom: 12.h),
              child: Column(
                children: [
                  _informationLink(
                    title: 'Education FAQs',
                    onTap: () =>
                        _navigate(bottomController, PageType.educationfaq),
                  ),
                  _informationLink(
                    title: 'Contact Us',
                    onTap: () =>
                        _navigate(bottomController, PageType.contactus),
                  ),
                  _informationLink(
                    title: 'About Us',
                    onTap: () => _navigate(bottomController, PageType.aboutus),
                  ),
                  _informationLink(
                    title: 'Policies',
                    onTap: () => _navigate(bottomController, PageType.policy),
                  ),
                  _informationLink(
                    title: 'Gallery',
                    onTap: () => _navigate(bottomController, PageType.gallary),
                  ),
                  _informationLink(
                    title: 'FAQs',
                    onTap: () => _navigate(bottomController, PageType.faqlist),
                  ),
                  _informationLink(title: 'Blog', onTap: () {}),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _informationLink({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 39.h,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colorstheam.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _accountAction({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48.h,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colorstheam.Racingred,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, thickness: 0.6, color: Colorstheam.clusterwhite);
  }

  void _navigate(
    Bottomnavigationcontroller bottomController,
    PageType page, {
    int index = 4,
  }) {
    bottomController.selectedIndex.value = index;
    bottomController.currentPage.value = page;
  }
}
