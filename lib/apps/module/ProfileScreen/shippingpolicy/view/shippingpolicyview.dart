import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/controller/shippingpolicycontroller.dart';


class Shippingpolicyview extends GetView<Shippingpolicycontroller> {
  const Shippingpolicyview({super.key});

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
                SizedBox(width: screensize.width * 0.02),
                Text(
                  Apptext.shippingpolicy,
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 05.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  'Shipping Policy',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22.sp,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    _sectionTitle('Shipping Schedule'),
                    _paragraph(
                      'Orders placed Monday through Friday before 3:00 PM ship the same day. '
                          'Orders placed on Saturday or Sunday ship the following Monday.',
                    ),

                    _sectionTitle('United States Shipping'),
                    _paragraph(
                      'Orders placed before 3:00 PM ship the same day. Packages ship via '
                          'UPS Ground or Next Day Air from Massachusetts. Delivery times vary '
                          'by destination and may take up to 10 days.',
                    ),

                    _shippingRegionRow('East Coast', '2–3 days'),
                    _shippingRegionRow('Midwest', '2–5 days'),
                    _shippingRegionRow('Rocky Mountains', '5–10 days'),
                    _shippingRegionRow('West Coast', '5–8 days'),

                    SizedBox(height: 12.h),

                    _sectionTitle('International Shipping'),
                    _paragraph(
                      'International orders ship via DHL Express Worldwide, with an '
                          'estimated delivery time of 3–5 days.',
                    ),
                    _emailParagraph(
                      'Need help with your shipment? Contact us at ',
                    ),

                    _sectionTitle('Shipping Insurance'),
                    _policyCallout(
                        title: 'Extra peace of mind for your order',
                        description:
                        'Protect your Malia hair order against unexpected shipping issues '
                        'with optional protection at checkout.',
                    ),

                    _policyBullet(
                      title: 'Lost packages: ',
                      description: 'Protection for eligible shipments that never arrive.',
                    ),
                    _policyBullet(
                      title: 'Stolen packages: ',
                      description: 'Coverage for eligible theft after delivery.',
                    ),
                    _policyBullet(
                      title: 'Damaged packages: ',
                      description: 'Assistance for eligible items damaged during transit.',
                    ),
                    _policyBullet(
                      title: 'Easy claims: ',
                      description: 'Submit a claim for review if a covered issue occurs.',
                    ),

                    _paragraph(
                      'Shipping insurance must be purchased at checkout. It does not cover '
                          'shipping delays or incorrect delivery addresses. Claims are subject '
                          'to the applicable shipping protection terms.',
                    ),

                    _sectionTitle('Shipping Protection Policy'),

                    _policySubheading('Why We Offer Shipping Protection'),
                    _paragraph(
                      'We know your time is valuable and so is your order. That is why '
                          'Malia Extensions offers optional Shipping Protection powered by '
                          'ParcelGuard to help protect eligible purchases after they leave '
                          'our facility.',
                    ),

                    _policySubheading('What Is Covered'),
                    _paragraph('When Shipping Protection is purchased, eligible claims may include:'),

                    _policyBullet(
                      title: 'Damaged packages: ',
                      description: 'Packages crushed, water-damaged, or otherwise harmed in transit.',
                    ),
                    _policyBullet(
                      title: 'Lost packages: ',
                      description: 'Shipments that never arrive.',
                    ),
                    _policyBullet(
                      title: 'Stolen packages: ',
                      description: 'Packages stolen after delivery, including porch piracy.',
                    ),

                    _policySubheading('What Is Not Covered'),
                    _policyBullet(
                      title: 'Shipping delays: ',
                      description: 'Late deliveries are not covered.',
                    ),
                    _policyBullet(
                      title: 'Incorrect addresses: ',
                      description: 'Please verify your shipping details before completing checkout.',
                    ),
                    _policyBullet(
                      title: 'Unprotected orders: ',
                      description: 'Orders without Shipping Protection are not eligible for protection claims.',
                    ),

                    _policySubheading('How to File a Claim'),
                    _paragraph(
                      'If you experience a shipping issue, contact our team and provide the '
                          'information needed to review your claim.',
                    ),

                    _numberedPolicyStep(
                      '1',
                      'Contact us',
                      'Email info@maliaextensions.com with your order number and a description of the issue.',
                    ),
                    _numberedPolicyStep(
                      '2',
                      'Provide photos',
                      'Include photos of the damaged product and packaging, if applicable.',
                    ),
                    _numberedPolicyStep(
                      '3',
                      'Keep your packaging',
                      'Retain all packaging materials until your claim has been resolved.',
                    ),
                    _numberedPolicyStep(
                      '4',
                      'Follow the review process',
                      'Our team will explain the next steps. A signed statement may be required.',
                    ),

                    _policySubheading('Important Claim Deadlines'),
                    _policyBullet(
                      title: 'General claims: ',
                      description: 'Submit claims within 120 days of the ship date.',
                    ),
                    _policyBullet(
                      title: 'Damage reports: ',
                      description: 'Report damage discovered after delivery within 15 days.',
                    ),

                    _policyCallout(
                      title: 'Orders without Shipping Protection',
                      description:
                      'Malia Extensions is not responsible for lost, stolen, or damaged '
                          'packages when Shipping Protection has not been purchased. We will '
                          'do our best to assist, but available options may be limited to '
                          'those offered by the carrier.',
                    ),

                    _sectionTitle('Questions?'),
                    _paragraph(
                      'Our team is here to help with your shipping questions. Reach out to us at:',
                    ),
                    _emailParagraph(''),

                    SizedBox(height: 24.h),
                  ],
                )
              ),
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
        final bottomNav = Get.find<Bottomnavigationcontroller>();
        bottomNav.selectedIndex.value = 4;
        bottomNav.currentPage.value = PageType.policy;
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

  Widget _shippingRegionRow(String region, String deliveryTime) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.h,
      ),
      decoration: BoxDecoration(
        color: Colorstheam.clusterwhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              region,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          Text(
            deliveryTime,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colorstheam.nobelblack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _policySubheading(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 8.h,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 16.sp,
          height: 1.3,
          fontWeight: FontWeight.w700,
          color: Colorstheam.nobelblack,
        ),
      ),
    );
  }

  Widget _policyCallout({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colorstheam.clusterwhite,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colorstheam.lightgrey,
          width: 1,
        ),
      ),
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
          SizedBox(height: 7.h),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 13.sp,
              height: 1.7,
              fontWeight: FontWeight.w400,
              color: Colorstheam.dimgrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberedPolicyStep(
      String number,
      String title,
      String description,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colorstheam.clusterwhite,
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Text(
              number,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 13.sp,
                    height: 1.7,
                    color: Colorstheam.dimgrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14.sp,
              height: 1.8,
              color: Colorstheam.dimgrey,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final uri = Uri(
                scheme: 'mailto',
                path: 'info@maliaextensions.com',
              );

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: Text(
              'info@maliaextensions.com',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14.sp,
                height: 1.8,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 18.sp,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: Colorstheam.nobelblack,
          ),
        ),
      ),
    );
  }
  Widget _paragraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 14.sp,
          height: 1.8,
          fontWeight: FontWeight.w400,
          color: Colorstheam.dimgrey,
        ),
      ),
    );
  }

  Widget _policyBullet({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h, right: 10.w),
            child: Container(
              width: 7.w,
              height: 7.w,
              margin: EdgeInsets.only(top: 7.h),
              decoration: const BoxDecoration(
                color: Colorstheam.burntearth,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  height: 1.75,
                  color: Colorstheam.dimgrey,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyBullet1({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h, right: 10.w),
            child: Container(
              width: 7.w,
              height: 7.w,
              margin: EdgeInsets.only(top: 7.h),
              decoration: const BoxDecoration(
                color: Colorstheam.green1,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colorstheam.vanilacusturd,
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 4.h,
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    height: 1.75,
                    color: Colorstheam.green1,
                  ),
                  children: [
                    TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    TextSpan(text: description),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyIntro() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          height: 1.8,
          fontSize: 15.sp,
          fontFamily: 'Urbanist',
          color: Colorstheam.dimgrey,
          fontWeight: FontWeight.w400,
        ),
        children: [
          const TextSpan(
            text: 'This Privacy Policy describes how Maliá (the "',
          ),
          _boldPolicySpan('Site'),
          const TextSpan(text: '", "'),
          _boldPolicySpan('we'),
          const TextSpan(text: '", "'),
          _boldPolicySpan('us'),
          const TextSpan(text: '", or "'),
          _boldPolicySpan('our'),
          const TextSpan(
            text:
            '") collects, uses, and discloses your personal information '
                'when you visit, use our services, or make a purchase from '
                'maliaextensions.com (the "',
          ),
          _boldPolicySpan('Site'),
          const TextSpan(
            text:
            '") or otherwise communicate with us (collectively, the "',
          ),
          _boldPolicySpan('Services'),
          const TextSpan(text: '"). For purposes of this Privacy Policy, "'),
          _boldPolicySpan('you'),
          const TextSpan(text: '" and "'),
          _boldPolicySpan('your'),
          const TextSpan(
            text:
            '" means you as the user of the Services, whether you are a '
                'customer, website visitor, or another individual whose '
                'information we have collected pursuant to this Privacy Policy.',
          ),
          const TextSpan(
            text:
            '\n\nPlease read this Privacy Policy carefully. By using and '
                'accessing any of the Services, you agree to the collection, '
                'use, and disclosure of your information as described in this '
                'Privacy Policy. If you do not agree to this Privacy Policy, '
                'please do not use or access any of the Services.',
          ),
        ],
      ),
    );
  }

  TextSpan _boldPolicySpan(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colorstheam.nobelblack,
      ),
    );
  }



  Widget _policyParagraphWithLink(
      String text,
      String linkText, {
        required String url,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            height: 1.8,
            color: Colorstheam.dimgrey,
          ),
          children: [
            TextSpan(text: text),
            TextSpan(
              text: linkText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(Uri.parse(url));
                },
            ),
          ],
        ),
      ),
    );
  }



  Widget _policyTableCell(
      String text, {
        bool isHeader = false,
        List<String> bullets = const [],
      }){
    return Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (text.isNotEmpty)
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: isHeader
                      ? FontWeight.w700
                      : FontWeight.w400,
                  color: Colorstheam.nobelblack,
                  height: 1.5,
                ),
              ),
            ...bullets.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 1.h,
                      right: 8.w,),
                    child: Container(
                      width: 6.w,
                      height: 6.w,
                      margin: EdgeInsets.only(top: 6.h),
                      decoration: const BoxDecoration(
                        color: Colorstheam.burntearth,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 13.sp,
                        fontFamily: 'Urbanist',
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            )
          ],
        )
    );
  }

  Widget _policyTableCell1(
      String text, {
        bool isHeader = false,
        List<String> bullets = const [],
      }){
    return Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (text.isNotEmpty)
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: isHeader
                      ? FontWeight.w700
                      : FontWeight.w400,
                  color: Colorstheam.nobelblack,
                  height: 1.5,
                ),
              ),
            ...bullets.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child:  Text(
                item,
                style: TextStyle(
                  height: 1.6,
                  fontSize: 13.sp,
                  fontFamily: 'Urbanist',
                  color: Colorstheam.dimgrey,
                ),
              ),
            ),
            )
          ],
        )
    );
  }
}

class LineHighlightedText extends StatelessWidget {
  final String text;

  const LineHighlightedText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 14.sp,
      height: 1.8,
      fontWeight: FontWeight.bold,
      color: Colorstheam.green1,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final painter = TextPainter(
            text: TextSpan(
              text: text,
              style: style,
            ),
            textDirection: Directionality.of(context),
            textAlign: TextAlign.left,
            textWidthBasis: TextWidthBasis.parent,
          );

          painter.layout(
            maxWidth: constraints.maxWidth,
          );

          return CustomPaint(
            painter: _LineBackgroundPainter(
              textPainter: painter,
              backgroundColor: Colorstheam.vanilacusturd,
            ),
            child: SizedBox(
              width: constraints.maxWidth,
              height: painter.height,
            ),
          );
        },
      ),
    );
  }
}

class _LineBackgroundPainter extends CustomPainter {
  final TextPainter textPainter;
  final Color backgroundColor;

  _LineBackgroundPainter({
    required this.textPainter,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    final textLength = textPainter.text?.toPlainText().length ?? 0;

    var offset = 0;

    while (offset < textLength) {
      final range = textPainter.getLineBoundary(
        TextPosition(offset: offset),
      );

      final end = range.end;

      if (end <= offset) {
        break;
      }

      final boxes = textPainter.getBoxesForSelection(
        TextSelection(
          baseOffset: range.start,
          extentOffset: end,
        ),
      );

      for (final box in boxes) {
        canvas.drawRect(
          Rect.fromLTRB(
            box.left,
            box.top,
            box.right,
            box.bottom,
          ),
          paint,
        );
      }

      offset = end;
    }

    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(
      covariant _LineBackgroundPainter oldDelegate,
      ) {
    return oldDelegate.textPainter != textPainter ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}