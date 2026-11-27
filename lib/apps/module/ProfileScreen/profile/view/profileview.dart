import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/apps/routes/app_pages.dart';
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
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colorstheam.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colorstheam.white,
        elevation: 0,
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            color: Colorstheam.clusterwhite,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: screensize.width * 0.04),
          child: Row(
            children: <Widget>[
              _backButton(),
              SizedBox(width: 12.w),
              Text(
                Apptext.profileappbartitle,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ],
          ),
        ),
        actions: [
          _headerAction(
            icon: 'asset/svg/search.svg',
            onTap: () {
              HapticFeedback.lightImpact();
              bottomController.selectedIndex.value = 0;
              bottomController.currentPage.value = PageType.search;
            },
          ),
          SizedBox(width: 18.w),
          Padding(
            padding: EdgeInsets.only(right: screensize.width * 0.045),
            child: _cartAction(bottomController),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 27.h),
              _buildWelcomeSection(),
              SizedBox(height: 25.h),
              _buildProfileButton(),
              SizedBox(height: 35.h),
              _sectionLabel('MY ACCOUNT'),
              SizedBox(height: 10.h),
              _menuItem(
                title: 'Salon Locator',
                subtitle: 'Discover a salon near you',
                asset: 'asset/svg/salonlocator.svg',
                onTap: () => _navigate(
                  bottomController,
                  PageType.salonlocator,
                ),
              ),
              _divider(),
              _menuItem(
                title: 'Profile Details',
                subtitle: 'Manage your personal information',
                asset: 'asset/svg/profile.svg',
                onTap: () => _navigate(
                  bottomController,
                  PageType.profiledetails,
                ),
              ),
              _divider(),
              _menuItem(
                title: 'My Courses',
                subtitle: 'Explore your education and courses',
                asset: 'asset/svg/cource.svg',
                onTap: () {},
              ),
              _divider(),
              _menuItem(
                title: 'Address Book',
                subtitle: 'Manage your saved addresses',
                asset: 'asset/svg/address.svg',
                onTap: () => _navigate(
                  bottomController,
                  PageType.addresslist,
                ),
              ),
              _divider(),
              _menuItem(
                title: 'Order History',
                subtitle: 'View your previous purchases',
                asset: 'asset/svg/orders.svg',
                onTap: () => _navigate(
                  bottomController,
                  PageType.orderhistory,
                ),
              ),
              SizedBox(height: 28.h),
              _sectionLabel('DISCOVER MORE'),
              SizedBox(height: 5.h),
              _buildInformationSection(bottomController),
              _divider(),
              SizedBox(height: 29.h),
              _sectionLabel('ACCOUNT SETTINGS'),
              SizedBox(height: 10.h),
              _accountAction(
                title: 'Delete Account',
                onTap: () => _navigate(
                  bottomController,
                  PageType.deleteaccount,
                ),
              ),
              _divider(),
              _accountAction(
                title: 'Log Out',
                onTap: () {
                  HapticFeedback.lightImpact();
                  controller.showLogoutBottomSheet();
                },
              ),
              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }
  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
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
  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Apptext.profilewelcome,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 30.sp,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 290.w,
          child: Text(
            Apptext.profilewelcomesubtitle,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12.sp,
              height: 1.65,
              fontWeight: FontWeight.w400,
              color: Colorstheam.dimgrey,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildProfileButton() {
    return Material(
      color: Colorstheam.nobelblack,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          Get.offAllNamed(Routes.ONBOARDING);
        },
        child: Container(
          width: double.infinity,
          height: 49.h,
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Apptext.profilebtntext,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Colorstheam.white,
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 17.sp,
                color: Colorstheam.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _menuItem({
    required String title,
    required String subtitle,
    required String asset,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colorstheam.white,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: SizedBox(
          height: 75.h,
          child: Row(
            children: <Widget>[
              Container(
                width: 42.w,
                height: 42.w,
                alignment: Alignment.center,
                color: Colorstheam.clusterwhite,
                child: SvgPicture.asset(
                  asset,
                  width: 19.w,
                  height: 19.w,
                  colorFilter: ColorFilter.mode(
                    Colorstheam.nobelblack,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13.sp,
                color: Colorstheam.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInformationSection(Bottomnavigationcontroller bottomController,) {
    return Obx(() => Column(
        children: <Widget>[
          Material(
            color: Colorstheam.white,
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                controller.isProfileExpanded.toggle();
              },
              child: SizedBox(
                height: 58.h,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 38.w,
                      height: 38.w,
                      alignment: Alignment.center,
                      color: Colorstheam.clusterwhite,
                      child: SvgPicture.asset(
                        'asset/svg/information.svg',
                        width: 18.w,
                        height: 18.w,
                        colorFilter: ColorFilter.mode(
                          Colorstheam.nobelblack,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Text(
                        'Information',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: controller.isProfileExpanded.value ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 22.sp,
                        color: Colorstheam.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: controller.isProfileExpanded.value ? Padding(
              padding: EdgeInsets.only(left: 52.w, bottom: 12.h),
              child: Column(
                children: <Widget>[
                  _informationLink(
                    title: 'Education FAQs',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.educationfaq,
                    ),
                  ),
                  _informationLink(
                    title: 'Contact Us',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.contactus,
                    ),
                  ),
                  _informationLink(
                    title: 'About Us',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.aboutus,
                    ),
                  ),
                  _informationLink(
                    title: 'Policies',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.policy,
                    ),
                  ),
                  _informationLink(
                    title: 'Gallery',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.gallary,
                    ),
                  ),
                  _informationLink(
                    title: 'FAQs',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.faqlist,
                    ),
                  ),
                  _informationLink(
                    title: 'Blog',
                    onTap: () => _navigate(
                      bottomController,
                      PageType.blog,
                    ),
                  ),
                ],
              ),
            ) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  Widget _sectionLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'DMSans',
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.6,
        color: Colorstheam.grey,
      ),
    );
  }
  Widget _headerAction({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 25.w,
        height: 42.h,
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 21.w,
            height: 21.w,
          ),
        ),
      ),
    );
  }
  Widget _cartAction(Bottomnavigationcontroller bottomNav) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
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
          children: <Widget>[
            SvgPicture.asset(
              'asset/svg/cart.svg',
              height: 22.h,
              width: 22.w,
            ),
            if (quantity > 0)
              Positioned(
                right: -8.w,
                top: -7.h,
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
                      fontFamily: 'Urbanist',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colorstheam.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
  Widget _informationLink({
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colorstheam.white,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: SizedBox(
          height: 39.h,
          child: Row(
            children: <Widget>[
              Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colorstheam.grey,
                ),
              ),
              SizedBox(width: 11.w),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colorstheam.dimgrey,
                ),
              ),
            ],
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
  void _navigate(Bottomnavigationcontroller bottomController, PageType page, {int index = 4}) {
    HapticFeedback.lightImpact();
    bottomController.selectedIndex.value = index;
    bottomController.currentPage.value = page;
  }
}