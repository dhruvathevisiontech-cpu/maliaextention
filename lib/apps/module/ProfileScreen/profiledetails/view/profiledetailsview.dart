import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/controller/profiledetailscontroller.dart';

class Profiledetailsview extends GetView<Profiledetailscontroller> {
  const Profiledetailsview({super.key});

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colorstheam.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 72.h,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 17.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Apptext.profiledetails,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'PERSONAL ACCOUNT',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.8,
                          color: Colorstheam.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 0.7.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 35.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileHeader(),
                SizedBox(height: 36.h),
                _sectionHeading(
                  eyebrow: 'YOUR DETAILS',
                  title: 'Personal information',
                  subtitle: 'Everything you need, all in one place.',
                ),
                SizedBox(height: 20.h),

                _personalInformation(),

                SizedBox(height: 36.h),

                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // PROFILE HEADER

  Widget _profileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 23.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
          width: 1.8,
        ),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                  color: Colorstheam.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colorstheam.clusterwhite,
                    width: 4,
                  ),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 44.sp,
                  color: Colorstheam.nobelblack,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 1.h,
                child: Material(
                  color: Colorstheam.nobelblack,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _showEditMessage('Profile'),
                    child: SizedBox(
                      width: 29.w,
                      height: 29.w,
                      child: Icon(
                        Icons.edit_outlined,
                        size: 13.sp,
                        color: Colorstheam.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 19.h),

          Text(
            'Your Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              color: Colorstheam.nobelblack,
            ),
          ),

          SizedBox(height: 5.h),

          Text(
            'your@email.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12.sp,
              color: Colorstheam.grey,
            ),
          ),

          SizedBox(height: 20.h),

          Container(
            width: 40.w,
            height: 1.h,
            color: Colorstheam.grey,
          ),

          SizedBox(height: 17.h),

          InkWell(
            onTap: () => _showEditMessage('Profile'),
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 7.h,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'EDIT PROFILE',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  SizedBox(width: 9.w),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16.sp,
                    color: Colorstheam.nobelblack,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SECTION HEADING

  Widget _sectionHeading({
    required String eyebrow,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Colorstheam.grey,
          ),
        ),
        SizedBox(height: 7.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12.sp,
            height: 1.5,
            color: Colorstheam.grey,
          ),
        ),
      ],
    );
  }

  // PERSONAL INFORMATION

  Widget _personalInformation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colorstheam.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          _personalRow(
            icon: Icons.person_outline_rounded,
            title: 'Full name',
            value: 'Your full name',
            onTap: () => _showEditMessage('Full Name'),
          ),
          _divider(),
          _personalRow(
            icon: Icons.mail_outline_rounded,
            title: 'Email address',
            value: 'your@email.com',
            onTap: () => _showEditMessage('Email Address'),
          ),
          _divider(),
          _personalRow(
            icon: Icons.phone_outlined,
            title: 'Phone number',
            value: 'Add your phone number',
            onTap: () => _showEditMessage('Phone Number'),
          ),
          _divider(),
          _personalRow(
            icon: Icons.calendar_today_outlined,
            title: 'Date of birth',
            value: 'Add your birthday',
            onTap: () => _showEditMessage('Date of Birth'),
          ),
        ],
      ),
    );
  }

  Widget _personalRow({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              SizedBox(
                width: 32.w,
                child: Icon(
                  icon,
                  size: 21.sp,
                  color: Colorstheam.nobelblack,
                ),
              ),

              SizedBox(width: 13.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.grey,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.edit_outlined,
                size: 16.sp,
                color: Colorstheam.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ACCOUNT SETTINGS

  Widget _accountSettings() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colorstheam.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          _settingRow(
            icon: Icons.location_on_outlined,
            title: 'Saved addresses',
            subtitle: 'Manage your delivery locations',
            onTap: () {},
          ),
          _divider(),
          _settingRow(
            icon: Icons.shield_outlined,
            title: 'Password & security',
            subtitle: 'Keep your account protected',
            onTap: () {},
          ),
          _divider(),
          _settingRow(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Manage your preferences',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _settingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              SizedBox(
                width: 32.w,
                child: Icon(
                  icon,
                  size: 21.sp,
                  color: Colorstheam.nobelblack,
                ),
              ),

              SizedBox(width: 13.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 11.sp,
                        color: Colorstheam.grey,
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

  Widget _divider() {
    return Divider(
      height: 1.h,
      thickness: 0.7,
      color: Colorstheam.clusterwhite,
    );
  }

  // FOOTER

  Widget _footer() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 35.w,
            height: 1.h,
            color: Colorstheam.clusterwhite,
          ),
          SizedBox(height: 17.h),
          Text(
            'YOUR BEAUTY, YOUR WAY.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: Colorstheam.grey,
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            'Made for your confidence.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12.sp,
              color: Colorstheam.grey,
            ),
          ),
        ],
      ),
    );
  }

  // BACK BUTTON

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
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
            "asset/svg/arrowleft.svg",
            width: 10.w,
            height: 10.h,
          ),
        ),
      ),
    );
  }

  // EDIT MESSAGEz

  void _showEditMessage(String field) {
    Get.snackbar(
      'Edit $field',
      'Connect this action to your profile editing form.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colorstheam.nobelblack,
      colorText: Colorstheam.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 14.r,
    );
  }
}
