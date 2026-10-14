import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/controller/returnandrefundcontroller.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/controller/shippingpolicycontroller.dart';
import 'package:url_launcher/url_launcher.dart';

class Returnandrefundview extends GetView<Returnandrefundcontroller> {
  const Returnandrefundview({super.key});

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
                  Apptext.returnpolicy,
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
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Returns & Refunds',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              _paragraph(
                'Please review our return and refund guidelines carefully before '
                    'submitting a return or exchange request.',
              ),

              _returnRule(
                '1',
                'Unused products only',
                'Returns and refunds are accepted only if the product has not been '
                    'used. Once the hair packaging has been opened, the product is '
                    'considered used and cannot be returned.',
              ),

              _returnRule(
                '2',
                '7-day return window',
                'Refund requests must be made within 7 days of the recipient '
                    'receiving the hair.',
              ),

              _returnRule(
                '3',
                'Inspection before refund',
                'Refunds are processed after the returned item has been received '
                    'and inspected.',
              ),

              _returnRule(
                '4',
                'Shipping costs',
                'Original shipping costs are non-refundable.',
              ),

              _returnRule(
                '5',
                'Return approval',
                'We reserve the right to refuse any return or refund request.',
              ),

              SizedBox(height: 12.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: Colorstheam.lightgrey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start a Return or Exchange',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _paragraph(
                      'Ready to get started? Use our online returns portal to '
                          'submit your request.',
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final uri = Uri.parse(
                            'https://maliaextensions.loopreturns.com/#/',
                          );

                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colorstheam.nobelblack,
                          foregroundColor: Colorstheam.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                        ),
                        child: Text(
                          'START A RETURN',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              Center(
                child: Text(
                  'Thank you for your understanding.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.dimgrey,
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
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
  Widget _returnRule(
      String number,
      String title,
      String description,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colorstheam.clusterwhite,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              number,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14.sp,
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
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