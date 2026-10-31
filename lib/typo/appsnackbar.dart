
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maliaextention/color/colorstheam.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(String message) {
    _show(message, Icons.check_circle_outline_rounded);
  }

  static void error(String message) {
    _show(message, Icons.error_outline_rounded);
  }

  static void _show(String message, IconData icon) {
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
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.down,
          content: _NudeMinimalToast(
            message: message,
            icon: icon,
            onClose: () => messenger.hideCurrentSnackBar(),
          ),
        ),
      );
  }
}

class _NudeMinimalToast extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback onClose;

  const _NudeMinimalToast({
    required this.message,
    required this.icon,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48.h),
      padding: EdgeInsets.only(left: 13.w, right: 5.w),
      decoration: BoxDecoration(
        color: Colorstheam.clusterwhite,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colorstheam.black.withValues(alpha: 0.08),
            blurRadius: 18.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 19.sp,
            color: Colorstheam.burntearth,
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Text(
              message,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colorstheam.nobelblack,
                letterSpacing: 0.1,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          IconButton(
            onPressed: onClose,
            tooltip: 'Dismiss notification',
            visualDensity: VisualDensity.compact,
            constraints: BoxConstraints(
              minWidth: 34.w,
              minHeight: 40.h,
            ),
            padding: EdgeInsets.zero,
            splashRadius: 16.r,
            icon: Icon(
              Icons.close_rounded,
              size: 16.sp,
              color: Colorstheam.grey,
            ),
          ),
        ],
      ),
    );
  }
}
