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
          toolbarHeight: 64.h,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Apptext.profiledetails,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w800,
                          color: Colorstheam.nobelblack,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'YOUR ACCOUNT',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.grey,
                          letterSpacing: 1.8,
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
              height: 1.h,
              color: Colorstheam.clusterwhite,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 35.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileHeader(),

                SizedBox(height: 34.h),

                _sectionHeading(
                  title: 'Personal information',
                  subtitle: 'Your personal details, all in one place.',
                ),

                SizedBox(height: 16.h),

                _detailsCard([
                  _detailRow(
                    icon: Icons.person_outline_rounded,
                    title: 'Full name',
                    value: 'Your full name',
                    onTap: () => _showEditMessage('Full Name'),
                  ),
                  _detailDivider(),
                  _detailRow(
                    icon: Icons.mail_outline_rounded,
                    title: 'Email address',
                    value: 'your@email.com',
                    onTap: () => _showEditMessage('Email Address'),
                  ),
                  _detailDivider(),
                  _detailRow(
                    icon: Icons.phone_outlined,
                    title: 'Phone number',
                    value: 'Add your phone number',
                    onTap: () => _showEditMessage('Phone Number'),
                  ),
                  _detailDivider(),
                  _detailRow(
                    icon: Icons.calendar_today_outlined,
                    title: 'Date of birth',
                    value: 'Add your birthday',
                    onTap: () => _showEditMessage('Date of Birth'),
                    showDividerSpace: false,
                  ),
                ]),

                SizedBox(height: 32.h),

                _sectionHeading(
                  title: 'Account settings',
                  subtitle: 'Make your account work for you.',
                ),

                SizedBox(height: 16.h),

                _detailsCard([
                  _actionRow(
                    icon: Icons.location_on_outlined,
                    title: 'Saved addresses',
                    subtitle: 'Manage your delivery locations',
                    onTap: () {
                      // Navigate to your address list screen.
                    },
                  ),
                  _detailDivider(),
                  _actionRow(
                    icon: Icons.shield_outlined,
                    title: 'Password & security',
                    subtitle: 'Keep your account protected',
                    onTap: () {
                      // Navigate to your password screen.
                    },
                  ),
                  _detailDivider(),
                  _actionRow(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Manage your preferences',
                    onTap: () {
                      // Navigate to your notification settings.
                    },
                    showDividerSpace: false,
                  ),
                ]),

                SizedBox(height: 32.h),

                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 30.w,
                        height: 1.h,
                        color: Colorstheam.clusterwhite,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'YOUR BEAUTY, YOUR WAY.',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colorstheam.grey,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Made for your confidence.',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 12.sp,
                          color: Colorstheam.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // PROFILE HEADER
  // --------------------------------------------------

  Widget _profileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 25.h,
      ),
      decoration: BoxDecoration(
        color: Colorstheam.lightgrey,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colorstheam.white,
                  border: Border.all(
                    color: Colorstheam.clusterwhite,
                    width: 1.2,
                  ),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 43.sp,
                  color: Colorstheam.nobelblack,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: Colorstheam.nobelblack,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colorstheam.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 13.sp,
                    color: Colorstheam.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 17.h),

          Text(
            'Your Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 25.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              color: Colorstheam.nobelblack,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            'your@email.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colorstheam.grey,
            ),
          ),

          SizedBox(height: 19.h),

          InkWell(
            onTap: () => _showEditMessage('Profile'),
            borderRadius: BorderRadius.circular(30.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: Colorstheam.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: Colorstheam.clusterwhite,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 14.sp,
                    color: Colorstheam.nobelblack,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'EDIT PROFILE',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // SECTION HEADING
  // --------------------------------------------------

  Widget _sectionHeading({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colorstheam.grey,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // DETAILS CARD
  // --------------------------------------------------

  Widget _detailsCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colorstheam.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: Colorstheam.clusterwhite,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _leadingIcon(IconData icon) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        color: Colorstheam.lightgrey,
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Icon(
        icon,
        size: 20.sp,
        color: Colorstheam.nobelblack,
      ),
    );
  }

  Widget _detailDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 69.w, right: 16.w),
      child: Divider(
        height: 1.h,
        thickness: 0.7,
        color: Colorstheam.clusterwhite,
      ),
    );
  }

  // --------------------------------------------------
  // PERSONAL INFORMATION ROW
  // --------------------------------------------------

  Widget _detailRow({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    bool showDividerSpace = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 15.h,
          ),
          child: Row(
            children: [
              _leadingIcon(icon),
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
                        fontWeight: FontWeight.w500,
                        color: Colorstheam.grey,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              Icon(
                Icons.edit_outlined,
                size: 17.sp,
                color: Colorstheam.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // ACCOUNT SETTINGS ROW
  // --------------------------------------------------

  Widget _actionRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDividerSpace = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 15.h,
          ),
          child: Row(
            children: [
              _leadingIcon(icon),
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
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: Colorstheam.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // EDIT MESSAGE
  // --------------------------------------------------

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

  // --------------------------------------------------
  // BACK BUTTON
  // --------------------------------------------------

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.policy;
      },
      child: Container(
        width: 40.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colorstheam.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colorstheam.clusterwhite,
            width: 1,
          ),
        ),
        child: SvgPicture.asset(
          'asset/svg/arrowleft.svg',
          width: 13.w,
          height: 13.h,
          colorFilter: ColorFilter.mode(
            Colorstheam.nobelblack,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}