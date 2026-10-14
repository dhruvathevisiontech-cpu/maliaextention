import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maliaextention/animation/animated_button.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/controller/faqlistcontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:maliaextention/typo/apptext.dart';
class Faqlistview extends GetView<Faqlistcontroller> {
  final TextEditingController searchController = TextEditingController();

  final RxInt expandedIndex = (-1).obs;
  final RxString searchQuery = ''.obs;

  final List<Map<String, String>> faqList = [
    {
      'question': 'Why do I need to create a Pro Account??',
      'answer': 'Creating a Pro Account gives you access to exclusive pricing, education resources, and special promotions only available to licensed cosmetologists.',
    },
    {
      'question': 'Is there a fee to join?',
      'answer': 'No, creating a Pro Account is completely free. You simply need to verify that you''re a licensed stylist.',
    },
    {
      'question': "Where's my Pro Discount?",
      'answer':
       "Once your account is approved, you'll automatically see Pro pricing when you're logged in. If you don't see your discount, try logging out and back in.",
    },
    {
      'question': "Do I need to be a hairstylist to purchase Maliá Hair Extensions?",
      'answer':
       "Our professional extension methods (Butterfly Wefts, Genius Wefts, Tape-Ins, and K-Tips) are available exclusively to licensed stylists with a free Pro Account. Our Agápē Luxury Clip-Ins and Siiri Parks Vivid Clip-Ins are available to everyone; no account needed. Looking for a professional install?",
    },
    {
      'question': "Do I need to be certified to purchase?",
      'answer':
       "You need to be a licensed stylist, but you don't need to be Maliá certified to purchase. However, we highly recommend our education programs to get the most out of our products.",
    },
    {
      'question': 'Can I see pricing before I sign up?',
      'answer':
       "Pro pricing is only visible to approved Pro Account holders. Create your free account today to unlock pro pricing.",
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
                    Apptext.faqlisttitle,
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
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    26.h,
                    20.w,
                    28.h,
                  ),
                  children: [
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
                      "EVERYTHING YOU NEED TO KNOW",
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
                      "Everything you need to know, all in one place. Explore our FAQs for quick and helpful answers.",
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
                      children: [
                        Text(
                          'General Questions',
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

                    // FAQ list
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
                            final isExpanded =
                                expandedIndex.value == index;

                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: Colorstheam.white,
                                border: Border.all(
                                  color: isExpanded
                                      ? Colorstheam.nobelblack
                                      .withOpacity(0.20)
                                      : const Color(0xFFEAEAEA),
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  key: ValueKey(
                                    '${faq['question']}_$index',
                                  ),
                                  initiallyExpanded: isExpanded,
                                  onExpansionChanged: (expanded) {
                                    expandedIndex.value =
                                    expanded ? index : -1;
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
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
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
                            );
                          },
                        ),
                      );
                    }),

                    SizedBox(height: 18.h),

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
