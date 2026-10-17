
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/aboutus/controller/aboutuscontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Aboutusview extends GetView<Aboutuscontroller> {
  const Aboutusview({super.key});

  static const String _aboutImage =
      'https://maliaextensions.com/cdn/shop/files/Screenshot_2026-08-08_at_11.00.24_AM.png?v=1786201307&width=2000';

  static const String _founderImage =
      'https://maliaextensions.com/cdn/shop/files/about-us-updated.png?v=1786453305&width=1200';

  static const String _teamImage =
      'https://maliaextensions.com/cdn/shop/files/dimitra-w-team.png?v=1785475433&width=1200';

  static const String _classImage =
      'https://maliaextensions.com/cdn/shop/files/malia_class.jpg?v=1783613096&width=2000';

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
          toolbarHeight: 62.h,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.aboutustitle,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
                    ),
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
            padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(),

                SizedBox(height: 34.h),

                _buildTextSection(
                  eyebrow: 'ABOUT',
                  title: 'MALIA EXTENTIONS',
                  paragraphs: [
                    'Created by working stylist Dimitra Louro, the brand began out of frustration with overpriced products and overcomplicated methods that didn’t actually serve stylists.',
                  ],
                ),

                SizedBox(height: 30.h),

                _buildTextSection(
                  eyebrow: 'MODERN STYLISTS WORK',
                  title: 'MALIA STORY',
                  paragraphs: [
                    'Created by working stylist Dimitra Louro, the brand began out of frustration with overpriced products and overcomplicated methods that didn’t actually serve stylists.',
                    "At MALIÁ, we're redefining the extension experience with methods that fit modern salon life. By combining speed, ergonomic application, and flawless results, our techniques allow stylists to complete installs in as little as 15 minutes per row—without sacrificing comfort or quality.",
                    'Created by stylists, for stylists, MALIÁ is the professional extension brand built to help you work smarter and elevate every appointment.',
                    'We specialize in innovative methods like the Butterfly Method, designed to prioritize your time, protect your body, and deliver results your clients can’t stop looking at. No unnecessary steps. No outdated techniques. Just modern extension systems that work as hard as you do.',
                  ],
                ),

                SizedBox(height: 22.h),

                _buildImage(_aboutImage, aspectRatio: 0.9),

                SizedBox(height: 36.h),

                _buildTextSection(
                  eyebrow: '',
                  title: 'VISION',
                  paragraphs: [
                    'We envision a future where every stylist has access to faster, healthier, and more profitable extension methods that elevate their artistry, grow their business, and transform the client experience.',
                  ],
                ),

                SizedBox(height: 30.h),

                _buildTextSection(
                  eyebrow: '',
                  title: 'MISSION',
                  paragraphs: [
                    'MALIÁ exists to empower professional stylists with innovative extension systems, premium products, and education that simplify the craft without compromising quality.',
                    'By combining modern techniques, luxury materials, and a stylist-first approach, we help professionals save time, protect their bodies, increase profitability, and deliver seamless results their clients love.',
                  ],
                ),

                SizedBox(height: 36.h),

                _buildFounderSection(),

                SizedBox(height: 38.h),

                _buildQualitySection(),

                SizedBox(height: 38.h),

                _buildWhyMaliaSection(),

                SizedBox(height: 24.h),

                _buildImage(_classImage, aspectRatio: 0.9),

                SizedBox(height: 38.h),

                _buildChallengeSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Main introduction
  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 28.h),
      decoration: BoxDecoration(
        color: Colorstheam.clusterwhite,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eyebrow('MALIÁ'),
          SizedBox(height: 22.h),
          Text(
            'Our Hair Extensions Revolutionise The Way',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 29.sp,
              height: 1.18,
              fontWeight: FontWeight.w800,
              color: Colorstheam.nobelblack,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable text sections
  Widget _buildTextSection({
    required String eyebrow,
    required String title,
    required List<String> paragraphs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow.isNotEmpty) ...[
          _eyebrow(eyebrow),
          SizedBox(height: 12.h),
        ],
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 27.sp,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 15.h),
        ...paragraphs.map(
              (paragraph) => Padding(
            padding: EdgeInsets.only(bottom: 13.h),
            child: Text(
              paragraph,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 13.5.sp,
                height: 1.85,
                fontWeight: FontWeight.w400,
                color: Colorstheam.dimgrey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Founder and team photographs
  Widget _buildFounderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('FOUNDER'),
        SizedBox(height: 12.h),
        Text(
          'DIMITRA LOURO',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 29.sp,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 20.h),
        _buildImage(_founderImage, aspectRatio: 0.9),
        SizedBox(height: 18.h),
        Text(
          'Dimitra is a licensed hairstylist, educator, and entrepreneur with a passion for redefining the professional hair extension industry. After years behind the chair, she founded MALIÁ The Extension Line to create innovative methods that are faster, healthier, and built for real salon life.',
          style: _bodyStyle(),
        ),
        SizedBox(height: 14.h),
        Text(
          'As the creator of the Butterfly Method, Dimitra is committed to helping stylists work smarter, protect their bodies, and deliver seamless, luxury results. Beyond product innovation, she is passionate about mentoring the next generation of hairstylists, believing that education, confidence, and community are the foundation of long-term success.',
          style: _bodyStyle(),
        ),
        SizedBox(height: 20.h),
        _buildImage(_teamImage, aspectRatio: 0.95),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: Colorstheam.clusterwhite,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Fun Fact: ',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                TextSpan(
                  text:
                  "Dimitra is proudly Greek, and you'll find subtle nods to her heritage woven throughout the MALIÁ brand—from collection names to product details and storytelling.",
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w400,
                    color: Colorstheam.dimgrey,
                  ),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.85,
            ),
          ),
        ),
      ],
    );
  }

  // Quality behind every strand
  Widget _buildQualitySection() {
    final features = [
      {
        'number': '1.',
        'title': 'ETHICALLY SOURCED HUMAN HAIR',
        'description':
        'Responsibly Sourced, Premium human hair selected for consistency and quality.',
        'image':
        'https://maliaextensions.com/cdn/shop/files/before_model_1.png?v=1786202439&width=1100',
      },
      {
        'number': '2.',
        'title': '100% REMY HAIR',
        'description':
        'Remy hair means the cuticles are kept intact and aligned in the same direction, which helps maintain the hair’s natural softness, shine, and strength while preventing tangling.',
        'image':
        'https://maliaextensions.com/cdn/shop/files/Experience_the_Malia_Difference_2.png?v=1786339503&width=1100',
      },
      {
        'number': '3.',
        'title': 'DOUBLE QUALITY INSPECTION',
        'description':
        "Every bundle is inspected multiple times throughout production to ensure it meets Maliá's standards before packaging. Nothing leaves the warehouse without careful review.",
        'image':
        'https://maliaextensions.com/cdn/shop/files/model_3_after.png?v=1786202155&width=1100',
      },
      {
        'number': '4.',
        'title': 'CRAFTED FOR PROFESSIONAL STYLISTS',
        'description':
        'From installation to maintenance, every detail is created to help stylists work more efficiently while delivering exceptional results their clients will love.',
        'image':
        'https://maliaextensions.com/cdn/shop/files/Hair_Tools_Mobile.png?v=1785925022&width=1100',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('THE QUALITY BEHIND EVERY STRAND'),
        SizedBox(height: 18.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _qualityTag('Ethical Hair'),
            _qualityTag('Pure Remy'),
            _qualityTag('Double Checked'),
            _qualityTag('Pro Crafted'),
          ],
        ),
        SizedBox(height: 24.h),
        ...features.map(
              (feature) => Padding(
            padding: EdgeInsets.only(bottom: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(
                  feature['image']!,
                  aspectRatio: 0.95,
                ),
                SizedBox(height: 15.h),
                Text(
                  feature['number']!,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.dimgrey,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  feature['title']!,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18.sp,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  feature['description']!,
                  style: _bodyStyle(),
                ),
                SizedBox(height: 18.h),
                Container(
                  height: 1.h,
                  color: Colorstheam.clusterwhite,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _qualityTag(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 9.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colorstheam.clusterwhite),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Colorstheam.nobelblack,
        ),
      ),
    );
  }

  // Why MALIÁ
  Widget _buildWhyMaliaSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(23.w),
      decoration: BoxDecoration(
        color: Colorstheam.nobelblack,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHY MALIÁ?',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Colorstheam.white,
            ),
          ),
          SizedBox(height: 19.h),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text:
                  "We're not in the business of just selling hair. We're in the business of ",
                ),
                TextSpan(
                  text: 'growing salon success.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 25.sp,
              height: 1.35,
              fontWeight: FontWeight.w500,
              color: Colorstheam.white,
            ),
          ),
          SizedBox(height: 19.h),
          Container(
            width: 40.w,
            height: 2.h,
            color: Colorstheam.white,
          ),
          SizedBox(height: 18.h),
          Text(
            "Through innovative methods, premium products, and education, MALIÁ helps stylists increase profitability, create exceptional client experiences, and build thriving extension businesses. At the heart of it all is Dimitra's belief that anyone can succeed in extensions with the right method, the right guidance, and the confidence to grow.",
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13.sp,
              height: 1.9,
              color: Colorstheam.white,
            ),
          ),
        ],
      ),
    );
  }

  // The challenge
  Widget _buildChallengeSection() {
    final priorities = [
      'Exceptional customer support',
      'High-quality education',
      'A strong stylist community',
      'Sales and consultation training',
      'Reliable shipping and fulfillment',
      'Consistent premium quality',
      'Transparent communication and ongoing partnership',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _eyebrow('THE CHALLENGE'),
        SizedBox(height: 12.h),
        Text(
          'Industry Gaps',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 29.sp,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),
        SizedBox(height: 22.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 17.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colorstheam.clusterwhite),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            children: priorities.map((priority) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'asset/svg/verified.svg',
                      width: 22.w,
                      height: 22.w,
                    ),
                    SizedBox(width: 13.w),
                    Expanded(
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 13.sp,
                          height: 1.65,
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.burntearth,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Shared image widget
  Widget _buildImage(
      String url, {
        required double aspectRatio,
      }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image.network(
          url,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;

            return Container(
              color: Colorstheam.clusterwhite,
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colorstheam.nobelblack,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colorstheam.clusterwhite,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_outlined,
                size: 30.sp,
                color: Colorstheam.dimgrey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _eyebrow(String title) {
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 1.5.h,
          color: Colorstheam.nobelblack,
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Colorstheam.dimgrey,
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _bodyStyle() {
    return TextStyle(
      fontFamily: 'DMSans',
      fontSize: 13.5.sp,
      height: 1.85,
      fontWeight: FontWeight.w400,
      color: Colorstheam.dimgrey,
    );
  }

  Widget _backButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 12.w,
            height: 12.w,
            colorFilter: ColorFilter.mode(
              Colorstheam.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
