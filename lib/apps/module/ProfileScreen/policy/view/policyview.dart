import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/controller/policycontoller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Policyview extends GetView<Policycontoller> {
  const Policyview({super.key});

  static const Color _background = Colorstheam.white;
  static const Color _text = Colorstheam.nobelblack;
  static const Color _muted = Colorstheam.grey1;
  static const Color _border = Colorstheam.arabiangrey;
  static const Color _blush = Colorstheam.clusterwhite;

  static const List<Map<String, String>> _policies = [
    {
      'title': 'Privacy Policy',
      'subtitle': 'Your data and privacy',
      'content': 'privacy',
    },
    {
      'title': 'Shipping Policy',
      'subtitle': 'Delivery and shipping information',
      'content': 'shipping',
    },
    {
      'title': 'Return & Refund Policy',
      'subtitle': 'Returns, exchanges and refunds',
      'content': 'returns',
    },
    {
      'title': 'Terms & Conditions',
      'subtitle': 'Our terms of service',
      'content': 'terms',
    },
  ];


  void openPolicy(Map<String, String> policy) {
    final policyKey = policy['content'];

    print('Policy key: $policyKey');

    switch (policyKey) {
      case 'privacy':
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.privacypolicy;
        break;

      case 'shipping':
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.shippingpolicy;
        break;

      case 'returns':
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.returnandrefundpolicy;
        break;

      case 'terms':
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.termsandservice;
        break;

      default:
        print('Policy not found: $policyKey');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: _background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          toolbarHeight: 62.h,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.policytitle,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      color: _text,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(height: 1.h, color: _border),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 30.h),
          children: [
            Text(
              'EVERYTHING YOU NEED TO KNOW',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 27.sp,
                height: 1.18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
                color: _text,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Everything you need to know, all in one place. Explore our FAQs for quick and helpful answers.',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14.sp,
                height: 1.65,
                fontWeight: FontWeight.w400,
                color: _muted,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Container(
                  width: 28.w,
                  height: 1.5.h,
                  color: Colorstheam.Racingred,
                ),
                SizedBox(width: 9.w),
                Text(
                  'POLICIES & INFORMATION',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 10.sp,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    color: _muted,
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.h),
            ..._policies.map(
                  (policy) => Padding(
                padding: EdgeInsets.only(bottom: 13.h),
                child: _policyCard(
                  title: policy['title']!,
                  subtitle: policy['subtitle']!,
                  icon: _policyIcon(policy['content']!),
                  onTap: () => openPolicy(policy),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Center(
              child: Column(
                children: [
                  Container(width: 35.w, height: 1.h, color: _border),
                  SizedBox(height: 14.h),
                  Text(
                    'MALIÁ EXTENSIONS',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _policyIcon(String key) {
    switch (key) {
      case 'privacy':
        return Icons.shield_outlined;
      case 'shipping':
        return Icons.local_shipping_outlined;
      case 'returns':
        return Icons.assignment_return_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  Widget _policyCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 17.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.r),
            border: Border.all(color: _border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 49.w,
                height: 49.w,
                decoration: BoxDecoration(
                  color: _blush,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  icon,
                  size: 23.sp,
                  color: _text,
                ),
              ),
              SizedBox(width: 14.w),
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
                        letterSpacing: -0.2,
                        color: _text,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12.sp,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: _muted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: _muted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Material(
      color: _text,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          final bottomNav = Get.find<Bottomnavigationcontroller>();
          bottomNav.selectedIndex.value = 4;
          bottomNav.currentPage.value = PageType.profile;
        },
        child: SizedBox(
          width: 38.w,
          height: 38.w,
          child: Center(
            child: SvgPicture.asset(
              'asset/svg/arrowleft.svg',
              width: 12.w,
              height: 12.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

