  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:get/get.dart';
  import 'package:maliaextention/animation/animated_button.dart';
  import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/controller/profiledetailscontroller.dart';
  import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
  import 'package:maliaextention/color/colorstheam.dart';

  class Profiledetailsview extends GetView<Profiledetailscontroller> {
    const Profiledetailsview({super.key});

    @override
    Widget build(BuildContext context) {
      Size screensize = MediaQuery.of(context).size;
      return Scaffold(
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
              children: <Widget>[
                _backButton(),
                SizedBox(width: 12.w),
                Text(
                  "Profile Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                    color: Colorstheam.nobelblack,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Dark Profile Header
                Container(
                  width: double.infinity,
                  color: Colorstheam.nobelblack,
                  padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ACCOUNT SETTINGS',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),

                      SizedBox(height: 25.h),

                      Row(
                        children: <Widget>[

                          Obx(
                                () => Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                Container(
                                  height: 90.w,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: Colorstheam.white,
                                    border: Border.all(
                                      color: Colorstheam.clusterwhite,
                                      width: 2,
                                    ),
                                    image: controller.profileImage.value != null
                                        ? DecorationImage(
                                      image: FileImage(
                                        controller.profileImage.value!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: controller.profileImage.value == null
                                      ? Icon(
                                    Icons.person_outline,
                                    color: Colorstheam.grey,
                                    size: 42.sp,
                                  )
                                      : null,
                                ),

                                // Camera icon
                                GestureDetector(
                                  onTap: controller.showImagePickerOptions,
                                  child: Container(
                                    height: 26.w,
                                    width: 26.w,
                                    color: Colorstheam.white,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 13.sp,
                                      color: Colorstheam.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          SizedBox(width: 18.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'HELLO,',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Dhruva Chavda',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colorstheam.white,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'jemish.thevision@gmail.com',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 10.sp,
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                GestureDetector(
                                  onTap: controller.showImagePickerOptions,
                                  child: Text(
                                    'CHANGE PHOTO  →',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                      color: Colorstheam.white,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h),

                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colorstheam.grey,
                      ),

                      SizedBox(height: 15.h),

                      Text(
                        'Manage your personal information',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 11.sp,
                          color: Colorstheam.clusterwhite,
                        ),
                      ),
                    ],
                  ),
                ),

                // White Personal Details Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 32.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '01',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w800,
                              color: Colorstheam.grey,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'PERSONAL DETAILS',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: Colorstheam.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Your information, all in one place.',
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 10.sp,
                                    color: Colorstheam.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 28.h),

                      _profileField(
                        label: 'FULL NAME',
                        value: 'Dhruva Chavda',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: 25.h),

                      _profileField(
                        label: 'EMAIL ADDRESS',
                        value: 'jemish.thevision@gmail.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 25.h),

                      _profileField(
                        label: 'PHONE NUMBER',
                        value: '+91 00000 00000',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),

                      SizedBox(height: 25.h),

                      _profileField(
                        label: 'DATE OF BIRTH',
                        value: '',
                        hint: 'Select your date of birth',
                        icon: Icons.calendar_today_outlined,
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        textController: controller.dateOfBirthController,
                        onTap: () {
                          controller.selectDateOfBirth(context);
                        },
                      ),


                      SizedBox(height: 38.h),

                      AnimatedButton(
                        onTap:(){},
                        child: Container(
                          height: 52.h,
                          width: double.infinity,
                          color: Colorstheam.nobelblack,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'UPDATE PROFILE',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.3,
                                  color: Colorstheam.white,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 17.sp,
                                color: Colorstheam.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      Center(
                        child: Text(
                          'MALIÁ',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                            color: Colorstheam.grey,
                          ),
                        ),
                      ),

                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


    Widget _profileField({
      required String label,
      required String value,
      required IconData icon,
      required TextInputType keyboardType,
      String? hint,
      bool readOnly = false,
      VoidCallback? onTap,
      TextEditingController? textController,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
              color: Colorstheam.black,
            ),
          ),

          SizedBox(height: 10.h),

          TextFormField(
            controller: textController,
            initialValue: textController == null ? value : null,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 13.sp,
              color: Colorstheam.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12.sp,
                color: Colorstheam.grey,
              ),
              prefixIcon: Icon(
                icon,
                size: 18.sp,
                color: Colorstheam.grey,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40.w,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 14.h,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colorstheam.clusterwhite,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colorstheam.nobelblack,
                  width: 1.3,
                ),
              ),
            ),
          ),
        ],
      );
    }
    Widget _backButton() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.lightImpact();
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
  }
