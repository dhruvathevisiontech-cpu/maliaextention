// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/controller/privacypolicycontroller.dart';

class Privacypolicyview extends GetView<Privacypolicycontroller> {
  const Privacypolicyview({super.key});

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
                  Apptext.privacypolicy,
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
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colorstheam.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        'YOUR PRIVACY MATTERS',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10.sp,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w800,
                          color: Colorstheam.burntearth,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 28.sp,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Learn how we collect, use, and protect your personal information.',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        height: 1.6,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _policyIntro(),
                    _sectionTitle('Changes to This Privacy Policy'),
                    _paragraph(
                      'We may update this Privacy Policy from time to time, '
                          'including to reflect changes to our practices or for other '
                          'operational, legal, or regulatory reasons. We will post the '
                          'revised Privacy Policy on the Site, update the "Last updated" '
                          'date and take any other steps required by applicable law.',
                    ),
                    _sectionTitle(
                      'How We Collect and Use Your Personal Information',
                    ),
                    _paragraph(
                      'To provide the Services, we collect and have collected over '
                          'the past 12 months personal information about you from a '
                          'variety of sources, as set out below. The information that '
                          'we collect and use varies depending on how you interact with us.',
                    ),
                    _paragraph(
                      'In addition to the specific uses set out below, we may use '
                          'information we collect about you to communicate with you, '
                          'provide the Services, comply with any applicable legal '
                          'obligations, enforce any applicable terms of service, and '
                          'to protect or defend the Services, our rights, and the rights '
                          'of our users or others.',
                    ),
                    _sectionTitle('What Personal Information We Collect'),
                    _paragraph(
                      'The types of personal information we obtain about you depend '
                          'on how you interact with our Site and use our Services. '
                          'When we use the term "personal information", we are referring '
                          'to information that identifies, relates to, describes, or can '
                          'be associated with you.',
                    ),
                    _sectionTitle('Information We Collect Directly from You'),
                    _paragraph(
                      'Information that you directly submit to us through our '
                          'Services may include:',
                    ),
                    _policyBullet(
                      title: 'Basic contact details',
                      description:
                      ' including your name, address, phone number, and email.',
                    ),
                    _policyBullet(
                      title: 'Order information',
                      description:
                      ' including your name, billing address, shipping address, '
                          'payment confirmation, email address, and phone number.',
                    ),
                    _policyBullet(
                      title: 'Account information',
                      description:
                      ' including your username, password, and security questions.',
                    ),
                    _policyBullet(
                      title: 'Shopping information',
                      description:
                      ' including the items you view, put in your cart, or add '
                          'to your wishlist.',
                    ),
                    _policyBullet(
                      title: 'Customer support information',
                      description:
                      ' including the information you choose to include in '
                          'communications with us.',
                    ),
                    _sectionTitle('Information We Collect through Cookies'),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14.sp,
                            color: Colorstheam.nobelblack,
                            height: 1.8,
                          ),
                          children: [
                            const TextSpan(
                              text: 'We also automatically collect certain information about '
                                  'your interaction with the Services ("',
                            ),
                            TextSpan(
                              text: 'Usage Data',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: '"). To do this, we may use cookies, pixels and similar '
                                  'technologies ("',
                            ),
                            TextSpan(
                              text: 'Cookies',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: '"). Usage Data may include information about how you access '
                                  'and use our Site and your account, including device information, '
                                  'browser information, information about your network connection, '
                                  'your IP address and other information regarding your interaction '
                                  'with the Services.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    _sectionTitle('Information We Obtain from Third Parties'),
                    _paragraph(
                      'Finally, we may obtain information about you from third parties, '
                          'including vendors and service providers who may collect information '
                          'on our behalf, such as:',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' Companies that support our Site and Services, such as Shopify.',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' Our payment processors collect payment information, including '
                          'bank account details, credit or debit card information, and billing '
                          'addresses, to process your payments, fulfill your orders, and provide '
                          'the products or services you have requested, in order to perform '
                          'our contract with you.',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' When you visit our Site, open or click on emails we send you, '
                          'or interact with our Services or advertisements, we or third parties '
                          'we work with may automatically collect certain information using '
                          'online tracking technologies, such as pixels, web beacons, software '
                          'development kits (SDKs), third-party libraries, and cookies.',
                    ),
                    _paragraph(
                      'Any information we obtain from third parties will be treated in '
                          'accordance with this Privacy Policy. We are not responsible or liable '
                          'for the accuracy of information provided to us by third parties, '
                          'and we are not responsible for any third party’s policies or practices. '
                          'For more information, see the section below, '
                          '"Third Party Websites and Links."',
                    ),
                    _sectionTitle('How We Use Your Personal Information'),
                    _policyBullet(
                      title: 'Providing Products and Services.',
                      description:
                      ' We use your personal information to provide you with the Services in order to perform our contract with you, including to process your payments, fulfill your orders, to send notifications to you related to you account, purchases, returns, exchanges or other transactions, to create, maintain and otherwise manage your account, to arrange for shipping, facilitate any returns and exchanges and to enable you to post reviews.',
                    ),
                    _policyBullet(
                      title: 'Marketing and Advertising.',
                      description:
                      ' We use your personal information for marketing and promotional purposes, such as to send marketing, advertising and promotional communications by email, text message or postal mail, and to show you advertisements for products or services. This may include using your personal information to better tailor the Services and advertising on our Site and other websites.',
                    ),
                    _policyBullet(
                      title: 'Security and Fraud Prevention.',
                      description:
                      ' We use your personal information to detect, investigate or take action regarding possible fraudulent, illegal or malicious activity. If you choose to use the Services and register an account, you are responsible for keeping your account credentials safe. We highly recommend that you do not share your username, password, or other access details with anyone else. If you believe your account has been compromised, please contact us immediately.',
                    ),
                    _policyBullet(
                      title: 'Communicating with you.',
                      description:
                      ' We use your personal information to provide you with customer support and improve our Services. This is in our legitimate interests in order to be responsive to you, to provide effective services to you, and to maintain our business relationship with you.',
                    ),
                    _sectionTitle('Cookies'),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14.sp,
                            color: Colorstheam.dimgrey,
                            height: 1.8,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Like many websites, we use Cookies on our Site. '
                                  'For specific information about the Cookies that we use '
                                  'related to powering our store with Shopify, see ',
                            ),
                            TextSpan(
                              text: 'https://www.shopify.com/legal/cookies',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colorstheam.nobelblack,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(
                                    '/webview',
                                    arguments: {
                                      'url': 'https://www.shopify.com/legal/cookies',
                                    },
                                  );
                                },
                            ),
                            const TextSpan(
                              text: '. We use Cookies to power and improve our Site and '
                                  'our Services (including to remember your actions and '
                                  'preferences), to run analytics and better understand '
                                  'user interaction with the Services (in our legitimate '
                                  'interests to administer, improve and optimize the Services). '
                                  'We may also permit third parties and service providers '
                                  'to use Cookies on our Site to better tailor the services, '
                                  'products and advertising on our Site and other websites.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    _paragraph(
                      'Most browsers automatically accept Cookies by default, but you can choose to set your browser to remove or reject Cookies through your browser controls. Please keep in mind that removing or blocking Cookies can negatively impact your user experience and may cause some of the Services, including certain features and general functionality, to work incorrectly or no longer be available. Additionally, blocking Cookies may not completely prevent how we share information with third parties such as our advertising partners.',
                    ),
                    _sectionTitle('How We Disclose Personal Information'),
                    _paragraph(
                      'In certain circumstances, we may disclose your personal information to third parties for legitimate purposes subject to this Privacy Policy. Such circumstances may include:',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' With vendors or other third parties who perform services on our behalf (e.g., IT management, payment processing, data analytics, customer support, cloud storage, fulfillment and shipping).',
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
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
                                  color: Colorstheam.dimgrey,
                                  height: 1.8,
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                    'With business and marketing partners, including Shopify, to provide services and advertise to you. ',
                                  ),
                                  TextSpan(
                                    text:
                                    '[NOTE TO MERCHANT: INSERT THE FOLLOWING SENTENCE IF USING SHOPIFY’S AD SERVICES, SUCH AS SHOPIFY AUDIENCES] [For example, we use Shopify to support personalized advertising with third-party services].',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colorstheam.nobelblack,
                                    ),
                                  ),
                                  const TextSpan(
                                    text:
                                    ' Our business and marketing partners will use your information in accordance with their own privacy notices.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' When you direct, request us or otherwise consent to our disclosure of certain information to third parties, such as to ship you products or through your use of social media widgets or login integrations, with your consent.',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' With our affiliates or otherwise within our corporate group, in our legitimate interests to run a successful business.',
                    ),
                    _policyBullet(
                      title: '',
                      description:
                      ' In connection with a business transaction such as a merger or bankruptcy, to comply with any applicable legal obligations (including to respond to subpoenas, search warrants and similar requests), to enforce any applicable terms of service, and to protect or defend the Services, our rights, and the rights of our users or others.',
                    ),
                    _paragraph(
                      'We have, in the past 12 months disclosed the following categories of personal information and sensitive personal information (denoted by *) about users for the purposes set out above in "How we Collect and Use your Personal Information" and "How we Disclose Personal Information":',
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colorstheam.lightgrey,
                        width: 1,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(
                          children:[
                            _policyTableCell(
                              'Category',
                              isHeader: true,
                            ),
                            _policyTableCell(
                              'Categories of Recipients',
                              isHeader: true,
                            )
                          ]
                        ),
                        TableRow(
                          children: [
                            _policyTableCell(
                              '',
                              bullets: [
                                'Identifiers such as basic contact details and certain order and account information',
                                'Commercial information such as order information, shopping information and customer support information',
                                'Internet or other similar network activity, such as Usage Data',
                              ],
                            ),
                            _policyTableCell(
                              '',
                              bullets: [
                                'Vendors and third parties who perform services on our behalf (such as Internet service providers, payment processors, fulfillment partners, customer support partners and data analytics providers)',
                                'Business and marketing partners',
                                'Affiliates',
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screensize.height * 0.01),
                    _paragraph(
                      'We do not use or disclose sensitive personal information for the purposes of inferring characteristics about you.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT- INSERT THE FOLLOWING PARAGRAPH AND CHART IF USING SHOPIFY’S AD SERVICES SUCH AS SHOPIFY AUDIENCES OR ENGAGING IN ANY OTHER ACTIVITY THAT MAY BE CONSIDERED “SELLING” OR “SHARING” PERSONAL INFORMATION OR PROCESSING PERSONAL INFORMATION FOR “TARGETED ADVERTISING”]',
                    ),
                    LineHighlightedText(
                      text: 'We have “sold” and “shared” (as those terms are defined in applicable law) personal information over the preceding 12 months for the purpose of engaging in advertising and marketing activities, as follows.',
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colorstheam.lightgrey,
                        width: 1,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(
                            children:[
                              _policyTableCell1(
                                'Category of Personal Information',
                                isHeader: true,
                              ),
                              _policyTableCell1(
                                'Categories of Recipients',
                                isHeader: true,
                              )
                            ]
                        ),
                        TableRow(
                          children: [
                            _policyTableCell1(
                              '',
                              bullets: [
                                'Identifiers such as basic contact details and certain order and account information',
                                'Commercial information such as records of products or services purchased and shopping information',
                                'Internet or other similar network activity, such as Usage Data',
                              ],
                            ),
                            _policyTableCell1(
                              '',
                              bullets: [
                                'Business and marketing partners',
                                'Business and marketing partners',
                                'Business and marketing partners',
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    _sectionTitle('User Generated Content'),
                    _paragraph(
                      'The Services may enable you to post product reviews and other user-generated content. If you choose to submit user generated content to any public area of the Services, this content will be public and accessible by anyone.',
                    ),
                    _paragraph(
                      'We do not control who will have access to the information that you choose to make available to others, and cannot ensure that parties who have access to such information will respect your privacy or keep it secure. We are not responsible for the privacy or security of any information that you make publicly available, or for the accuracy, use or misuse of any information that you disclose or receive from third parties.',
                    ),
                    _sectionTitle('Third Party Websites and Links'),
                    _paragraph(
                      'Our Site may provide links to websites or other online platforms operated by third parties. If you follow links to sites not affiliated or controlled by us, you should review their privacy and security policies and other terms and conditions. We do not guarantee and are not responsible for the privacy or security of such sites, including the accuracy, completeness, or reliability of information found on these sites. Information you provide on public or semi-public venues, including information you share on third-party social networking platforms may also be viewable by other users of the Services and/or users of those third-party platforms without limitation as to its use by us or by a third party. Our inclusion of such links does not, by itself, imply any endorsement of the content on such platforms or of their owners or operators, except as disclosed on the Services.',
                    ),
                    _sectionTitle('Children’s Data'),
                    _paragraph(
                      'The Services are not intended to be used by children, and we do not knowingly collect any personal information about children. If you are the parent or guardian of a child who has provided us with their personal information, you may contact us using the contact details set out below to request that it be deleted.',
                    ),
                    _paragraph(
                      'As of the Effective Date of this Privacy Policy, we do not have actual knowledge that we “share” or “sell” (as those terms are defined in applicable law) personal information of individuals under 16 years of age.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT: PLEASE CONSULT WITH LEGAL COUNSEL IF YOUR SITE IS CHILD FOCUSSED OR DIRECTED, AS MORE SPECIFIC DISCLOSURES MAY BE REQUIRED.]',
                    ),
                    _sectionTitle('Security and Retention of Your Information'),
                    _paragraph(
                      'Please be aware that no security measures are perfect or impenetrable, and we cannot guarantee “perfect security.” In addition, any information you send to us may not be secure while in transit. We recommend that you do not use unsecure channels to communicate sensitive or confidential information to us.',
                    ),
                    _paragraph(
                      'How long we retain your personal information depends on different factors, such as whether we need the information to maintain your account, to provide the Services, comply with legal obligations, resolve disputes or enforce other applicable contracts and policies.',
                    ),
                    _sectionTitle('Your Rights and Choices'),
                    _paragraph(
                      'Depending on where you live, you may have some or all of the rights listed below in relation to your personal information. However, these rights are not absolute, may apply only in certain circumstances and, in certain cases, we may decline your request as permitted by law.',
                    ),
                    _policyBullet(
                      title: 'Right to Access / Know.',
                      description:
                      ' You may have a right to request access to personal information that we hold about you, including details relating to the ways in which we use and share your information.',
                    ),
                    _policyBullet(
                      title: 'Right to Delete.',
                      description:
                      ' You may have a right to request that we delete personal information we maintain about you.',
                    ),
                    _policyBullet(
                      title: 'Right to Correct.',
                      description:
                      ' You may have a right to request that we correct inaccurate personal information we maintain about you.',
                    ),
                    _policyBullet(
                      title: 'Right of Portability. ',
                      description:
                      ' You may have a right to receive a copy of the personal information we hold about you and to request that we transfer it to a third party, in certain circumstances and with certain exceptions.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT: IF USING SHOPIFY\'S AD SERVICES SUCH AS SHOPIFY AUDIENCES OR ENGAGING IN ANY OTHER ACTIVITY THAT MAY BE CONSIDERED "SELLING" OR "SHARING" PERSONAL INFORMATION OR PROCESSING PERSONAL INFORMATION FOR "TARGETED ADVERTISING", INSERT THE PARAGRAPH BELOW AND ENSURE YOU PROVIDE CUSTOMERS THE ABILITY TO "OPT OUT" OF THIS ACTIVITY ON YOUR SITE BY USING SHOPIFY\'S PRIVACY AND COMPLIANCE APP OR OTHERWISE.]',
                    ),
                    _policyBullet1(
                      title: 'Right to Opt out of Sale or Sharing or Targeted Advertising. ',
                      description:
                      ' You may have a right to direct us not to "sell" or "share" your personal information or to opt out of the processing of your personal information for purposes considered to be "targeted advertising", as defined in applicable privacy laws. Please note that if you visit our Site with the Global Privacy Control opt-out preference signal enabled, depending on where you are, we will automatically treat this as a request to opt-out of the "sale" or "sharing" of information for the device and browser that you use to visit the Site.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT: IF YOU COLLECT INFORMATION THAT MAY BE DEEMED TO BE SENSITIVE PERSONAL INFORMATION UNDER APPLICABLE PRIVACY LAWS THERE MAY BE ADDITIONAL CONSENTS/DISCLOSURES REQUIRED. INSERT THE PARAGRAPH BELOW IF YOU COLLECT SENSITIVE PERSONAL INFORMATION AND CONSULT WITH EXTERNAL LEGAL COUNSEL TO CONFIRM YOUR RESPONSIBILITIES.]',
                    ),
                    _policyBullet1(
                      title: 'Right to Limit and/or Opt out of Use and Disclosure of Sensitive Personal Information.',
                      description:
                      ' You may have a right to direct us to limit our use and/or disclosure of sensitive personal information to only what is necessary to perform the Services or provide the goods reasonably expected by an average individual.',
                    ),
                    _policyBullet(
                      title: 'Restriction of Processing:',
                      description:
                      ' You may have the right to ask us to stop or restrict our processing of personal information.',
                    ),
                    _policyBullet(
                      title: 'Withdrawal of Consent:',
                      description:
                      ' Where we rely on consent to process your personal information, you may have the right to withdraw this consent.',
                    ),
                    _policyBullet(
                      title: 'Appeal:',
                      description:
                      ' You may have a right to appeal our decision if we decline to process your request. You can do so by replying directly to our denial.',
                    ),
                    _policyBullet(
                      title: 'Managing Communication Preferences:',
                      description:
                      ' We may send you promotional emails, and you may opt out of receiving these at any time by using the unsubscribe option displayed in our emails to you. If you opt out, we may still send you non-promotional emails, such as those about your account or orders that you have made.',
                    ),
                    _paragraph(
                      'You may exercise any of these rights where indicated on our Site or by contacting us using the contact details provided below.',
                    ),
                    _paragraph(
                      'We will not discriminate against you for exercising any of these rights. We may need to collect information from you to verify your identity, such as your email address or account information, before providing a substantive response to the request. In accordance with applicable laws, You may designate an authorized agent to make requests on your behalf to exercise your rights. Before accepting such a request from an agent, we will require that the agent provide proof you have authorized them to act on your behalf, and we may need you to verify your identity directly with us. We will respond to your request in a timely manner as required under applicable law.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT: IF YOU COLLECT INFORMATION THAT MAY BE DEEMED TO BE SENSITIVE PERSONAL INFORMATION UNDER APPLICABLE PRIVACY LAWS THERE MAY BE ADDITIONAL CONSENTS/DISCLOSURES REQUIRED. INSERT THE PARAGRAPH BELOW IF YOU COLLECT SENSITIVE PERSONAL INFORMATION AND CONSULT WITH EXTERNAL LEGAL COUNSEL TO CONFIRM YOUR RESPONSIBILITIES.]',
                    ),
                    _policyParagraphWithLink(
                      'We use Shopify\'s ad services such as Shopify Audiences to help personalize the advertising you see on third party websites. To restrict Shopify merchants that use these ad services from using your personal information for such services, visit ',
                      'https://privacy.shopify.com/en',
                    ),
                    _sectionTitle('Complaints'),
                    _paragraph(
                      'If you have complaints about how we process your personal information, please contact us using the contact details provided below. If you are not satisfied with our response to your complaint, depending on where you live you may have the right to appeal our decision by contacting us using the contact details set out below, or lodge your complaint with your local data protection authority.',
                    ),
                    _sectionTitle('International Users'),
                    _paragraph(
                      'Please note that we may transfer, store and process your personal information outside the country you live in, including the United States. Your personal information is also processed by staff and third party service providers and partners in these countries.',
                    ),
                    _paragraph(
                      'If we transfer your personal information out of Europe, we will rely on recognized transfer mechanisms like the European Commission\'s Standard Contractual Clauses, or any equivalent contracts issued by the relevant competent authority of the UK, as relevant, unless the data transfer is to a country that has been determined to provide an adequate level of protection.',
                    ),
                    _sectionTitle('Contact'),
                    _paragraph(
                      'Should you have any questions about our privacy practices or this Privacy Policy, or if you would like to exercise any of the rights available to you, please call [TOLL FREE TELEPHONE NUMBER IF YOU HAVE A PHYSICAL RETAIL LOCATION] or email us at dimitralouro@gmail.com or contact us at 263 Redwood Lane, Westport MA 02790, United States.',
                    ),
                    LineHighlightedText(
                      text: '[NOTE TO MERCHANT: INSERT THE FOLLOWING IF YOUR SITE IS GOVERNED BY GDPR] For the purpose of applicable data protection laws, we are the data controller of your personal information. Our representative in the [EEA] [and] [the UK] is [INSERT REPRESENTATIVE DETAILS].',
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: 22.h,
        bottom: 10.h,
      ),
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


  Widget _policyParagraphWithLink(
      String text,
      String url,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            height: 1.8,
            fontWeight: FontWeight.w400,
            color: Colorstheam.dimgrey,
          ),
          children: [
            TextSpan(text: text),
            TextSpan(
              text: url,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colorstheam.nobelblack
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(Uri.parse(url));
                },
            ),
            const TextSpan(text: '.'),
          ],
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



