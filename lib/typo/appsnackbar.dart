
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maliaextention/color/colorstheam.dart';

class AppSnackbar {
  static void success(String message) {
    _show(
      title: 'ADDED TO YOUR BAG',
      message: message,
      icon: Icons.check_rounded,
    );
  }

  static void error(String message) {
    _show(
      title: 'UNABLE TO COMPLETE',
      message: message,
      icon: Icons.priority_high_rounded,
    );
  }

  static void warning(String message) {
    _show(
      title: 'A LITTLE REMINDER',
      message: message,
      icon: Icons.info_outline_rounded,
    );
  }

  static void info(String message) {
    _show(
      title: 'JUST SO YOU KNOW',
      message: message,
      icon: Icons.auto_awesome_outlined,
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
  }) {
    final context = Get.context;
    if (context == null) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            20.h,
          ),
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.horizontal,
          content: _LuxuryToast(
            title: title,
            message: message,
            icon: icon,
            onClose: messenger.hideCurrentSnackBar,
          ),
        ),
      );
  }
}

class _LuxuryToast extends StatefulWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback onClose;

  const _LuxuryToast({
    required this.title,
    required this.message,
    required this.icon,
    required this.onClose,
  });

  @override
  State<_LuxuryToast> createState() => _LuxuryToastState();
}

class _LuxuryToastState extends State<_LuxuryToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colorstheam.nobelblack,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colorstheam.white.withValues(alpha: 0.13),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colorstheam.black.withValues(alpha: 0.22),
            blurRadius: 28.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              16.h,
              10.w,
              15.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colorstheam.white.withValues(alpha: 0.22),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colorstheam.white,
                    size: 18.sp,
                  ),
                ),

                SizedBox(width: 13.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'M A L I Á',
                        style: TextStyle(
                          color: Colorstheam.Silver,
                          fontFamily: 'DMSans',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colorstheam.white,
                          fontFamily: 'DMSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.65,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        widget.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colorstheam.Silver,
                          fontFamily: 'DMSans',
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 4.w),

                IconButton(
                  onPressed: widget.onClose,
                  splashRadius: 18.r,
                  padding: EdgeInsets.all(8.r),
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colorstheam.Silver,
                    size: 17.sp,
                  ),
                ),
              ],
            ),
          ),

          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 1 - _progressController.value,
                  child: Container(
                    height: 2.h,
                    color: Colorstheam.Silver,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
