import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/controller/viewordercontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';



class Vieworder extends GetView<Viewordercontroller> {
  const Vieworder({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return AnnotatedRegion(
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
            padding: EdgeInsets.only(left: screensize.width * 0.04),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Apptext.viewordertitle,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        Apptext.viewordersubtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w500,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colorstheam.clusterwhite, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tracking Number',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                  ),
                ),
                SizedBox(height: 4.h),
                Obx(
                      () => Text(
                    controller.trackingNumber.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                      color: Colorstheam.nobelblack,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildTimelineStepper(),
                SizedBox(height: 24.h),
                _buildDashedLine(),
                SizedBox(height: 20.h),
                Obx(
                      () => Column(
                    children: controller.orderItems
                        .map((item) => _buildOrderItemRow(item))
                        .toList(),
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(color: Colorstheam.nobelblack, thickness: 1.h),
                SizedBox(height: 12.h),
                Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pay',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                      Text(
                        '\$${controller.totalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
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
        bottomNav.currentPage.value = PageType.orderhistory;
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
  // Horizontal Timeline
  Widget _buildTimelineStepper() {
    return Obx(() {
      final steps = controller.statusSteps;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (index) {
          final isFirst = index == 0;
          final isLast = index == steps.length - 1;
          final step = steps[index];
          return Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 1.h,
                        color: isFirst
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                    ),
                    // Step Dot Indicator
                    Container(
                      width: 15.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.5.r),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        color: Colors.white,
                      ),
                      child: step.isCompleted
                          ? Center(
                        child: Container(
                          width: 7.5.w,
                          height: 7.5.h,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(1.5.r),
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                      )
                          : null,
                    ),
                    // Right connecting line
                    Expanded(
                      child: Container(
                        height: 1.h,
                        color: isLast
                            ? Colors.transparent
                            : Colorstheam.alabastergrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  step.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600,
                    color: Colorstheam.nobelblack,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 4.h),
                // Date Label
                Text(
                  step.date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w300,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  // Single Order Item Row
  Widget _buildOrderItemRow(OrderItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.bold,
                  color: Colorstheam.nobelblack,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'QTY ${item.quantity}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w400,
                  color: Colorstheam.nobelblack,
                ),
              ),
            ],
          ),
          Text(
            '\$${item.price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.bold,
              color: Colorstheam.nobelblack,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashHeight = 2.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colorstheam.clusterwhite),
              ),
            );
          }),
        );
      },
    );
  }
}