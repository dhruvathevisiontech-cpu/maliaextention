import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/controller/educationfaqcontroller.dart';

class Educationfaqview extends GetView<Educationfaqcontroller> {
  final TextEditingController searchController = TextEditingController();

  final RxInt expandedIndex = (-1).obs;
  final RxString searchQuery = ''.obs;

  final List<Map<String, String>> faqList = [
    {
      'question': "How do I access my online course?",
      'answer': "Go to the login page and enter your account information. Once you’re logged in, select “My Courses” under your profile.",
    },
    {
      'question': "Do I need to complete an online certification to purchase Maliá hair?",
      'answer': "No, certification is not required to purchase our hair. However, our online education gives you continued access to training that you can reference anytime. You’ll also receive access to our stylist community and",
    },
    {
      'question': "What are the benefits of completing the online Butterfly Method Certification?",
      'answer':
      "You’ll learn the full Butterfly Method at your own pace, gain the confidence to begin offering the method, and receive 5% off all Butterfly Wefts for life.",
    },
  ];
  final List<Map<String, String>> faqList1 = [
    {
      'question': "Do I need to be a licensed cosmetologist to attend?",
      'answer': "Yes. Attendees must be licensed cosmetologists or currently enrolled cosmetology students. Proof may be required before the class.",
    },
    {
      'question': "What is included with my in-person certification?",
      'answer': "Each attendee receives a Maliá certification kit, including a Butterfly practice weft, multi-method tool kit, training manual, educational materials, tote bag, and hairbrush.",
    },
    {
      'question': "How long is the class?",
      'answer': "Our in-person Butterfly Method Certification typically runs from 10 AM to 3 PM. Exact times may vary by class.",
    },
    {
      'question': "Is the class hands-on?",
      'answer': "Yes. This is an interactive, hands-on certification. You’ll practice the Butterfly Method with guidance from a Maliá pro educator.",
    },
    {
      'question': "Do I need to bring a model?",
      'answer': "Do I need to bring a model?",
    },
    {
      'question': "Do I need to bring anything with me?",
      'answer': "We provide the main tools and materials needed for the class. Please bring any personal styling tools requested in your class confirmation email.",
    },
    {
      'question': "Will I receive a certificate?",
      'answer': "Yes. After successfully completing the class, you’ll receive a physical Butterfly Method certification.",
    },
    {
      'question': "What are the benefits of becoming Butterfly certified?",
      'answer': "You’ll receive 5% off Butterfly Wefts for life, access to our stylist community and educational resources, and the knowledge and confidence to begin offering the method to your clients.",
    },
    {
      'question': "Can I purchase hair or products during the class?",
      'answer': "Product availability varies by location. Any class-exclusive offers or purchasing options will be shared with attendees before or during the class.",
    },
    {
      'question': "What is the cancellation or transfer policy?",
      'answer': "Tickets are nonrefundable. If you cannot attend, please contact us as soon as possible to find out whether your ticket can be transferred to a future class.",
    },
    {
      'question': "What happens if Maliá cancels or reschedules the class?",
      'answer': "If a class is canceled or rescheduled by Maliá, registered attendees will be contacted directly with their available options.",
    },
    {
      'question': "Do you offer private certifications for salons?",
      'answer': "Yes. Private classes may be available for salon teams that meet the minimum attendance requirement. Contact our education team for pricing, availability, and location details.",
    },
    {
      'question': "Can Maliá host a certification at my salon?",
      'answer': "Depending on your location, team size, and educator availability, we may be able to bring the certification to your salon. Travel or additional fees may apply.",
    },
    {
      'question': "When is payment due for a private class?",
      'answer': "A 50% deposit is typically required to secure the date. The remaining balance is due by the agreed-upon deadline or on the day of the class.",
    },
    {
      'question': "Who can I contact with questions about my class?",
      'answer': "Please contact us info@maliaextensions.com for any class related questions.",
    },
  ];

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
          toolbarHeight: 60.h,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screensize.width * 0.045,
            ),
            child: Row(
              children: [
                _backButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    Apptext.educationtitle,
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      color: Colorstheam.nobelblack,
                      letterSpacing: -0.4,
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
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    26.h,
                    20.w,
                    28.h,
                  ),
                  children: <Widget>[
                    Text(
                      'WE’RE HERE TO HELP',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                        color: Colorstheam.Racingred,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "EDUCATION FAQ'S",
                      style: TextStyle(
                        fontSize: 31.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                        height: 1.13,
                        letterSpacing: -0.8,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Find helpful answers to common questions about our educational resources, programs, courses, and learning opportunities. Explore the FAQs to learn more and get the information you need.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                        height: 1.65,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: <Widget>[
                        Text(
                          'Online Education',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        const Spacer(),
                        Obx(() {
                          final filteredCount = faqList.where((faq) {
                            final query = searchQuery.value;
                            return faq['question']!
                                .toLowerCase()
                                .contains(query) ||
                                faq['answer']!
                                    .toLowerCase()
                                    .contains(query);
                          }).length;

                          return Text(
                            '$filteredCount ARTICLES',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Colors.grey.shade500,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Obx(() {
                      final filteredFaqs = faqList.where((faq) {
                        final query = searchQuery.value;
                        return faq['question']!
                            .toLowerCase()
                            .contains(query) ||
                            faq['answer']!
                                .toLowerCase()
                                .toLowerCase()
                                .contains(query);
                      }).toList();
                      if (filteredFaqs.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 45.h,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 42.sp,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'No questions found',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Try searching with different keywords.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: List.generate(
                          filteredFaqs.length,
                              (index) {
                            final faq = filteredFaqs[index];
                            final isExpanded = expandedIndex.value == index;
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isExpanded
                                      ? Colorstheam.nobelblack.withOpacity(0.20)
                                      : const Color(0xFFEAEAEA),
                                ),
                              ),
                              child: Material(
                                color: Colorstheam.white,
                                clipBehavior: Clip.antiAlias,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    key: ValueKey(faq['question']),
                                    initiallyExpanded: isExpanded,
                                    backgroundColor: Colors.transparent,
                                    collapsedBackgroundColor: Colors.transparent,
                                    onExpansionChanged: (expanded) {
                                      expandedIndex.value = expanded ? index : -1;
                                    },
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 5.h,
                                    ),
                                    childrenPadding: EdgeInsets.fromLTRB(
                                      16.w,
                                      0,
                                      16.w,
                                      18.h,
                                    ),
                                    trailing: AnimatedRotation(
                                      turns: isExpanded ? 0.5 : 0,
                                      duration: const Duration(milliseconds: 200),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 23.sp,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    title: Text(
                                      faq['question']!,
                                      style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          faq['answer']!,
                                          style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: 13.sp,
                                            height: 1.75,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: 18.h),
                    Row(
                      children: <Widget>[
                        Text(
                          'In-Person Education',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: Colorstheam.nobelblack,
                          ),
                        ),
                        const Spacer(),
                        Obx(() {
                          final filteredCount = faqList1.where((faq) {
                            final query = searchQuery.value;
                            return faq['question']!
                                .toLowerCase()
                                .contains(query) ||
                                faq['answer']!
                                    .toLowerCase()
                                    .contains(query);
                          }).length;

                          return Text(
                            '$filteredCount ARTICLES',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Colors.grey.shade500,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Obx(() {
                      final filteredFaqs = faqList1.where((faq) {
                        final query = searchQuery.value;
                        return faq['question']!
                            .toLowerCase()
                            .contains(query) ||
                            faq['answer']!
                                .toLowerCase()
                                .toLowerCase()
                                .contains(query);
                      }).toList();
                      if (filteredFaqs.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 45.h,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 42.sp,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'No questions found',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colorstheam.nobelblack,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Try searching with different keywords.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: List.generate(
                          filteredFaqs.length,
                              (index) {
                            final faq = filteredFaqs[index];
                            final isExpanded = expandedIndex.value == index;
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(
                                  color: isExpanded
                                      ? Colorstheam.nobelblack.withOpacity(0.20)
                                      : const Color(0xFFEAEAEA),
                                ),
                              ),
                              child: Material(
                                color: Colorstheam.white,
                                clipBehavior: Clip.antiAlias,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    key: ValueKey(faq['question']),
                                    initiallyExpanded: isExpanded,
                                    backgroundColor: Colors.transparent,
                                    collapsedBackgroundColor: Colors.transparent,
                                    onExpansionChanged: (expanded) {
                                      expandedIndex.value = expanded ? index : -1;
                                    },
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 5.h,
                                    ),
                                    childrenPadding: EdgeInsets.fromLTRB(
                                      16.w,
                                      0,
                                      16.w,
                                      18.h,
                                    ),
                                    trailing: AnimatedRotation(
                                      turns: isExpanded ? 0.5 : 0,
                                      duration: const Duration(milliseconds: 200),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 23.sp,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    title: Text(
                                      faq['question']!,
                                      style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4,
                                        color: Colorstheam.nobelblack,
                                      ),
                                    ),
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          faq['answer']!,
                                          style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: 13.sp,
                                            height: 1.75,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colorstheam.clusterwhite,
                          borderRadius: BorderRadius.circular(5.r)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DISCOVER MORE IN FAQ’S?",
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800,
                              color: Colorstheam.nobelblack,
                            ),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            "Have more questions? Feel free to contact us at info@maliaextensions.com",
                            style: TextStyle(
                              height: 1.6,
                              fontSize: 13.sp,
                              color: Colors.black54,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 17.h),
                          SizedBox(
                            width: double.infinity,
                            height: 48.h,
                            child: AnimatedButton(
                              onTap: () {
                                Get.snackbar(
                                  'Contact Support',
                                  'Connect your Contact Us page here.',
                                  snackPosition:
                                  SnackPosition.BOTTOM,
                                );
                              },
                              child: Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colorstheam.nobelblack,
                                  borderRadius: BorderRadius.circular(5.r)
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CONTACT US',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      letterSpacing: 1.2,
                                      fontFamily: 'Urbanist',
                                      color: Colorstheam.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
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
        bottomNav.currentPage.value = PageType.profile;
      },
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorstheam.nobelblack,
        ),
        child: Center(
          child: SvgPicture.asset(
            'asset/svg/arrowleft.svg',
            width: 11.w,
            height: 11.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
