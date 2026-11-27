import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class CheckoutWebView extends StatefulWidget {
  final String checkoutUrl;
  const CheckoutWebView({
    super.key,
    required this.checkoutUrl,
  });
  @override
  State<CheckoutWebView> createState() => _CheckoutWebViewState();
}

class _CheckoutWebViewState extends State<CheckoutWebView> {
  late final WebViewController webViewController;
  int loadingProgress = 0;
  bool hasError = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colorstheam.nobelblack,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colorstheam.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                loadingProgress = progress;
              });
            }
          },
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                hasError = false;
                loadingProgress = 0;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                loadingProgress = 100;
              });
            }
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame == true && mounted) {
              setState(() {
                hasError = true;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colorstheam.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colorstheam.nobelblack,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colorstheam.nobelblack,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              Container(
                height: 56.h,
                width: double.infinity,
                color: Colorstheam.nobelblack,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 8.w,
                      top: 4.h,
                      bottom: 4.h,
                      child: _closeButton(),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'asset/svg/maliablacklogo.svg',
                        width: 150.w,
                        height: 32.h,
                        colorFilter: ColorFilter.mode(
                          Colorstheam.white,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              if (loadingProgress < 100 && !hasError)
                LinearProgressIndicator(
                  value: loadingProgress / 100,
                  minHeight: 2.h,
                  backgroundColor: Colorstheam.clusterwhite,
                  color: Colorstheam.nobelblack,
                ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: WebViewWidget(
                        controller: webViewController,
                      ),
                    ),

                    if (hasError)
                      Positioned.fill(
                        child: Container(
                          color: Colorstheam.white,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.wifi_off_outlined,
                                  size: 40.sp,
                                  color: Colorstheam.grey,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Unable to load checkout",
                                  style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colorstheam.nobelblack,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colorstheam.nobelblack,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      hasError = false;
                                      loadingProgress = 0;
                                    });

                                    webViewController.reload();
                                  },
                                  child: Text(
                                    "Try Again",
                                    style: TextStyle(
                                      color: Colorstheam.white,
                                      fontFamily: "DMSans",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: SizedBox(
        width: 48.w,
        height: 48.h,
        child: Center(
          child: SizedBox(
            width: 30.w,
            height: 30.w,
            child: CustomPaint(
              painter: CheckoutClosePainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class CheckoutClosePainter extends CustomPainter {
  const CheckoutClosePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colorstheam.white
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(
      const Offset(5, 5),
      Offset(size.width - 5, size.height - 5),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - 5, 5),
      Offset(5, size.height - 5),
      paint,
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
