  // ignore_for_file: prefer_const_constructors_in_immutables

  import 'package:get/get.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:maliaextention/animation/animated_button.dart';
  import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/controller%20/saveaddresscontroller.dart';
  import 'package:maliaextention/typo/apptext.dart';
  import 'package:maliaextention/color/colorstheam.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

  class Saveaddressview extends GetView<Saveaddresscontroller> {
    const Saveaddressview({super.key});
    void _showCountryPicker() {
      Get.bottomSheet(
        Container(
          height: 500.h,
          decoration: BoxDecoration(
            color: Colorstheam.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                "Select Country",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 15.h),

              Expanded(
                child: ListView.builder(
                  itemCount: controller.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];

                    return Obx(
                          () => ListTile(
                        title: Text(country.name),

                        trailing:
                        controller.selectedCountry.value == country.name
                            ? Icon(
                          Icons.check_rounded,
                          color: Colorstheam.nobelblack,
                        )
                            : null,

                        onTap: () {
                          controller.selectCountry(country.name);
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
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
                  SizedBox(width: 12.w),
                  Text(
                    Apptext.addnewaddress,
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
            actions: [
              _headerIcon(
                icon: "asset/svg/search.svg",
                onTap: () {
                  final bottomNav = Get.find<Bottomnavigationcontroller>();
                  bottomNav.selectedIndex.value = 0;
                  bottomNav.currentPage.value = PageType.search;
                },
              ),
              SizedBox(width: 16.w),
              Padding(
                padding: EdgeInsets.only(
                  right: screensize.width * 0.04,
                ),
                child: _headerIcon(
                    icon: "asset/svg/cart.svg",
                    onTap: (){
                      final bottomNav = Get.find<Bottomnavigationcontroller>();
                      bottomNav.selectedIndex.value = 0;
                      bottomNav.currentPage.value = PageType.viewcart;
                    }
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "Country/region",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screensize.width * 0.04,
                    ),
                    child: Obx(
                          () => GestureDetector(
                        onTap: _showCountryPicker,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 13.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colorstheam.clusterwhite,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.selectedCountry.value.isEmpty
                                      ? "Select Country"
                                      : controller.selectedCountry.value,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w400,
                                    color: controller.selectedCountry.value.isEmpty
                                        ? Colorstheam.grey
                                        : Colorstheam.nobelblack,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                "asset/svg/arrowdown.svg",
                                color: Colorstheam.nobelblack,
                                width: 20.w,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "FirstName",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                    child: TextFormField(
                      controller: controller.firstNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Colorstheam.nobelblack,
                      cursorErrorColor: Colorstheam.red,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your first name";
                        }

                        if (value.trim().length < 2) {
                          return "First name must be at least 2 characters";
                        }

                        return null;
                      },
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.nobelblack,
                      ),
                      decoration: InputDecoration(
                        hintText: "First Name",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "LastName",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                    child: TextFormField(
                      controller: controller.lastNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Colorstheam.nobelblack,
                      cursorErrorColor: Colorstheam.red,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.nobelblack,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your last name";
                        }

                        if (value.trim().length < 2) {
                          return "Last name must be at least 2 characters";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "Company",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                    child: TextFormField(
                      controller: controller.companyController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Colorstheam.nobelblack,
                      cursorErrorColor: Colorstheam.red,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.nobelblack,
                      ),
                      decoration: InputDecoration(
                        hintText: "Company",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                    child: TextFormField(
                      controller: controller.addressController,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: controller.searchAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please select or enter your address";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Search your address",
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 14.w,
                            right: 8.w,
                          ),
                          child: SvgPicture.asset(
                            "asset/svg/location.svg",
                            width: 17.w,
                            height: 17.w,
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                        () {
                      if (controller.addressSuggestions.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        margin: EdgeInsets.only(
                          left: screensize.width * 0.04,
                          right: screensize.width * 0.04,
                          top: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colorstheam.white,
                          border: Border.all(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.addressSuggestions.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1.h,
                              color: Colorstheam.clusterwhite,
                            );
                          },
                          itemBuilder: (context, index) {
                            final address =
                            controller.addressSuggestions[index];

                            return InkWell(
                              onTap: () {
                                controller.selectAddress(address);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20.sp,
                                      color: Colors.grey.shade600,
                                    ),

                                    SizedBox(width: 10.w),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address["address"] ?? "",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "DMSans",
                                              fontWeight: FontWeight.w600,
                                              color: Colorstheam.nobelblack,
                                            ),
                                          ),

                                          SizedBox(height: 3.h),

                                          Text(
                                            address["location"] ?? "",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: "DMSans",
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                      child: Text(
                        "Apartment, suite, etc",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w600,
                            color: Colorstheam.nobelblack
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04),
                    child: TextFormField(
                      controller: controller.apartmentController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Colorstheam.nobelblack,
                      cursorErrorColor: Colorstheam.red,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.nobelblack,
                      ),
                      decoration: InputDecoration(
                        hintText: "Apartment, suite, etc",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Text(
                        "City",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screensize.width * 0.04,
                      right: screensize.width * 0.04,
                    ),
                    child: TextFormField(
                      controller: controller.cityController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Colorstheam.nobelblack,
                      cursorErrorColor: Colorstheam.red,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your city";
                        }

                        return null;
                      },
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w400,
                        color: Colorstheam.nobelblack,
                      ),
                      decoration: InputDecoration(
                        hintText: "City",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w400,
                          color: Colorstheam.lightgrey,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: "DMSans",
                          color: Colorstheam.red,
                          fontWeight: FontWeight.w100,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colorstheam.clusterwhite,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screensize.width * 0.04,
                        right: screensize.width * 0.04,
                      ),
                      child: Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.015),
                  Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            left: screensize.width * 0.04,
                            right: screensize.width * 0.04,
                          ),
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colorstheam.clusterwhite,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                controller.selectedDialCode,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w400,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your phone number";
                                }

                                final phone = value.trim();

                                if (phone.length < 7) {
                                  return "Please enter a valid phone number";
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w400,
                                  color: Colorstheam.lightgrey,
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: "DMSans",
                                  color: Colorstheam.red,
                                  fontWeight: FontWeight.w100,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 13.h,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    color: Colorstheam.clusterwhite,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    color: Colorstheam.clusterwhite,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                                              ],
                                            ),
                        ),
                  ),
                  SizedBox(height: screensize.height * 0.01),
                  AnimatedButton(
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: screensize.width * 0.04,right: screensize.width * 0.04,bottom: screensize.height * 0.02),
                      child: Container(
                        height: 40.h,
                        color: Colorstheam.nobelblack,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w600,
                              color: Colorstheam.clusterwhite
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _backButton() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final Bottomnavigationcontroller bottomNav = Get.find<Bottomnavigationcontroller>();
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
    Widget _headerIcon({
      required String icon,
      VoidCallback? onTap,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 22.w,
          height: 22.w,
          child: SvgPicture.asset(
            icon,
            width: 22.w,
            height: 22.h,
          ),
        ),
      );
    }

  }
