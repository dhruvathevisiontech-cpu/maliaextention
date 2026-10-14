import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maliaextention/typo/apptext.dart';
import 'package:maliaextention/color/colorstheam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/controller/termsandservicecontroller.dart';


class Termsandserviceview extends GetView<Termsandservicecontroller> {
  Termsandserviceview({super.key});
  final List<Map<String, String>> _termsSections = [
    {
      'title': 'SECTION 1 - ACCESS AND ACCOUNT',
      'content': '''By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, and you have given us your consent to allow any of your minor dependents to use the Services on devices you own, purchase or manage.

To use the Services, including accessing or browsing our online stores or purchasing any of the products or services we offer, you may be asked to provide certain information, such as your email address, billing, payment, and shipping information. You represent and warrant that all the information you provide in our stores is correct, current and complete and that you have all rights necessary to provide this information.

You are solely responsible for maintaining the security of your account credentials and for all of your account activity. You may not transfer, sell, assign, or license your account to any other person.
''',
    },
    {
      'title': 'SECTION 2 - OUR PRODUCTS',
      'content': '''We have made every effort to provide an accurate representation of our products and services in our online stores. However, please note that colors or product appearance may differ from how they may appear on your screen due to the type of device you use to access the store and your device settings and configuration.

We do not warrant that the appearance or quality of any products or services purchased by you will meet your expectations or be the same as depicted or rendered in our online stores.

All descriptions of products are subject to change at any time without notice at our sole discretion. We reserve the right to discontinue any product at any time and may limit the quantities of any products that we offer to any person, geographic region or jurisdiction, on a case-by-case basis.
''',
    },
    {
      'title': 'SECTION 3 - ORDERS',
      'content': '''When you place an order, you are making an offer to purchase. Malia Extensions reserves the right to accept or decline your order for any reason at its discretion. Your order is not accepted until Malia Extensions confirms acceptance. We must receive and process your payment before your order is accepted. Please review your order carefully before submitting, as Malia Extensions may be unable to accommodate cancellation requests after an order is accepted. In the event that we do not accept, make a change to, or cancel an order, we will attempt to notify you by contacting the e‑mail, billing address, and/or phone number provided at the time the order was made.

Your purchases are subject to return or exchange solely in accordance with our Refund Policy [LINK].

You represent and warrant that your purchases are for your own personal or household use and not for commercial resale or export.
''',
    },
    {
      'title': 'SECTION 4 - PRICES AND BILLING',
      'content': '''Prices, discounts and promotions are subject to change without notice. The price charged for a product or service will be the price in effect at the time the order is placed and will be set out in your order confirmation email. Unless otherwise expressly stated, posted prices do not include taxes, shipping, handling, customs or import charges.

Prices posted in our online stores may be different from prices offered in physical stores or in online or other stores operated by third parties. We may offer, from time to time, promotions on the Services that may affect pricing and that are governed by terms and conditions separate from these Terms. If there is a conflict between the terms for a promotion and these Terms, the promotion terms will govern.

You agree to provide current, complete and accurate purchase, payment and account information for all purchases made at our stores. You agree to promptly update your account and other information, including your email address, credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.

You represent and warrant that (i) the credit card information you provide is true, correct, and complete, (ii) you are duly authorized to use such credit card for the purchase, (iii) charges incurred by you will be honored by your credit card company, and (iv) you will pay charges incurred by you at the posted prices, including shipping and handling charges and all applicable taxes, if any.
''',
    },
    {
      'title': 'SECTION 5 - SHIPPING AND DELIVERY',
      'content': '''We are not liable for shipping and delivery delays. All delivery times are estimates only and are not guaranteed. We are not responsible for delays caused by shipping carriers, customs processing, or events outside our control. Once we transfer products to the carrier, title and risk of loss passes to you.
''',
    },
    {
      'title': 'SECTION 6 - INTELLECTUAL PROPERTY',
      'content': '''Our Services, including but not limited to all trademarks, brands, text, displays, images, graphics, product reviews, video, and audio, and the design, selection, and arrangement thereof, are owned by Malia Extensions, its affiliates or licensors and are protected by U.S. and foreign patent, copyright and other intellectual property laws.

These Terms permit you to use the Services for your personal, non-commercial use only.

You must not reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any of the material on the Services without our prior written consent. Except as expressly provided herein, nothing in these Terms grants or shall be construed as granting a license or other rights to you under any patent, trademark, copyright, or other intellectual property of Malia Extensions, Shopify or any third party. Unauthorized use of the Services may be a violation of federal and state intellectual property laws. All rights not expressly granted herein are reserved by Malia Extensions.

Malia Extensions's names, logos, product and service names, designs, and slogans are trademarks of Malia Extensions or its affiliates or licensors. You must not use such trademarks without the prior written permission of Malia Extensions. Shopify's name, logo, product and service names, designs and slogans are trademarks of Shopify. All other names, logos, product and service names, designs, and slogans on the Services are the trademarks of their respective owners.
''',
    },
    {
      'title': 'SECTION 7 - OPTIONAL TOOLS',
      'content': '''You may be provided with access to customer tools offered by third parties as part of the Services, which we neither monitor nor have any control nor input.

You acknowledge and agree that we provide access to such tools "as is" and "as available" without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.

Any use by you of the optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).

We may also, in the future, offer new features through the Services (including the release of new tools and resources). Such new features shall also be deemed part of the Services and are subject to these Terms of Service.
''',
    },
    {
      'title': 'SECTION 8 - THIRD-PARTY LINKS',
      'content': '''The Services may contain materials and hyperlinks to websites provided or operated by third parties (including any embedded third party functionality). We are not responsible for examining or evaluating the content or accuracy of any third-party materials or websites you choose to access. If you decide to leave the Services to access these materials or third party sites, you do so at your own risk.

We are not liable for any harm or damages related to your access of any third-party websites, or your purchase or use of any products, services, resources, or content on any third-party websites. Please review carefully the third-party's policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products and services should be directed to the third-party.
''',
    },
    {
      'title': 'SECTION 9 - RELATIONSHIP WITH SHOPIFY',
      'content': '''[NOTE TO MERCHANT: This section accurately characterizes Shopify's relationship with your store and should not be removed or modified.]

Malia Extensions is powered by Shopify, which enables us to provide the Services to you.

However, any sales and purchases you make in our Store are made directly with Malia Extensions. By using the Services, you acknowledge and agree that Shopify is not responsible for any aspect of any sales between you and Malia Extensions, including any injury, damage, or loss resulting from purchased products and services. You hereby expressly release Shopify and its affiliates from all claims, damages, and liabilities arising from or related to your purchases and transactions with Malia Extensions.
''',
    },
    {
      'title': 'SECTION 10 - PRIVACY POLICY',
      'content': '''All personal information we collect through the Services is subject to our Privacy Policy, which can be viewed here [LINK], and certain personal information may be subject to Shopify's Privacy Policy, which can be viewed here. By using the Services, you acknowledge that you have read these privacy policies.

Because the Services are hosted by Shopify, Shopify collects and processes personal information about your access to and use of the Services in order to provide and improve the Services for you. Information you submit to the Services will be transmitted to and shared with Shopify as well as third parties that may be located in other countries than where you reside, in order to provide services to you. Review our privacy policy [LINK] for more details on how we, Shopify, and our partners use your personal information.  
''',
    },
    {
      'title': 'SECTION 11 - FEEDBACK',
      'content': '''If you submit, upload, post, email, or otherwise transmit any ideas, suggestions, feedback, reviews, proposals, plans, or other content (collectively, "Feedback"), you grant us a perpetual, worldwide, sublicensable, royalty-free license to use, reproduce, modify, publish, distribute and display such Feedback in any medium for any purpose, including for commercial use. We may, for example, use our rights under this license to operate, provide, evaluate, enhance, improve and promote the Services and to perform our obligations and exercise our rights under the Terms of Service.

You also represent and warrant that: (i) you own or have all necessary rights to all Feedback; (ii) you have disclosed any compensation or incentives received in connection with your submission of Feedback; and (iii) your Feedback will comply with these Terms. We are and shall be under no obligation (1) to maintain your Feedback in confidence; (2) to pay compensation for your Feedback; or (3) to respond to your Feedback.

We may, but have no obligation to, monitor, edit or remove Feedback that we determine in our sole discretion to be unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party's intellectual property or these Terms of Service.

You agree that your Feedback will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your Feedback will not contain libelous or otherwise unlawful, abusive or obscene Feedback, or contain any computer virus or other malware that could in any way affect the operation of the Services or any related website. You may not use a false email address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any Feedback. You are solely responsible for any Feedback you make and its accuracy. We take no responsibility and assume no liability for any Feedback posted by you or any third-party.
''',
    },
    {
      'title': 'SECTION 12 - ERRORS, INACCURACIES AND OMISSIONS',
      'content': '''Occasionally there may be information on or in the Services that contain typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information is inaccurate at any time without prior notice (including after you have submitted your order).  
''',
    },
    {
      'title': 'SECTION 13 - PROHIBITED USES',
      'content': '''You may access and use the Services for lawful purposes only. You may not access or use the Services, directly or indirectly: (a) for any unlawful or malicious purpose; (b) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (c) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (d) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or harm any of our employees or any other person; (e) to transmit false or misleading information; (f) to send, knowingly receive, upload, download, use, or re-use any material that does not comply with the these Terms; (g) to transmit, or procure the sending of, any advertising or promotional material, including any "junk mail," "chain letter," "spam," or any other similar solicitation; (h) to impersonate or attempt to impersonate any other person or entity; or (i) to engage in any other conduct that restricts or inhibits anyone's use or enjoyment of the Services, or which, as determined by us, may harm Malia Extensions, Shopify or users of the Services, or expose them to liability.

In addition, you agree not to: (a) upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Services; (b) reproduce, duplicate, copy, extract, sell, resell or exploit any portion of the Services; (c) collect or track the personal information of others; (d) spam, phish, pharm, or pretext the services; (e) use any robot, spider, scraping, data gathering and extraction tools, automatic devices or processes, AI tools (such as agentic AI) or automated or manual means to access the Services; or (f) interfere with, bypass, or circumvent the security or authorization features, robot exclusion headers, or other measures we employ to restrict access to the Services. We reserve the right to suspend, disable, or terminate your account at any time, without notice, if we determine that you have violated any part of these Terms.
''',
    },
    {
      'title': 'SECTION 14 - AGENTS',
      'content': '''14.1 This section ("Agent Terms") applies if you use, allow, enable, or cause the deployment of an Agent to access, use, or interact with any Services. "Agent" means any software or service that takes autonomous or semi-autonomous action on behalf of, or at the instruction of, any person or entity and that can be executed on behalf of or using persons device, without direct supervision.

14.1 This section ("Agent Terms") applies if you use, allow, enable, or cause the deployment of an Agent to access, use, or interact with any Services. "Agent" means any software or service that takes autonomous or semi-autonomous action on behalf of, or at the instruction of, any person or entity and that can be executed on behalf of or using persons device, without direct supervision.

14.3 We may limit, including by technical measures, whether and how any Agent accesses, uses, and interacts with Services.

14.4 Agents must: (i) in all HTTP/HTTPS requests, identify that the request is from an Agent and disclose the name of the Agent by including the following in the request's user agent string: "Agent/[agent name]"; (ii) not conceal or obfuscate that any access, use, or interactions are from an Agent, such as by (a) mimicking human behavior and interaction patterns, or (b) completing or circumventing CAPTCHAs or measures intended to distinguish computer use from humans, (iii) respond truthfully to any question or prompt seeking to determine if interactions are coming from a human or a computer, (iv) not circumvent or otherwise avoid any measure intended to block, limit, modify, or control whether and how Agents access, use, or interact with the Services.
''',
    },
    {
      'title': 'SECTION 15 - TERMINATION',
      'content': '''We may terminate this agreement or your access to the Services (or any part thereof) in our sole discretion at any time without notice, and you will remain liable for all amounts due up to and including the date of termination.

The following sections will continue to apply following any termination: Intellectual Property, Feedback, Termination, Disclaimer of Warranties, Limitation of Liability, Indemnification, Severability, Waiver; Entire Agreement, Assignment, Governing Law, Privacy Policy, and any other provisions that by their nature should survive termination.
''',
    },
    {
      'title': 'SECTION 16 - DISCLAIMER OF WARRANTIES',
      'content': '''The information presented on or through the Services is made available solely for general information purposes. We do not warrant the accuracy, completeness, or usefulness of this information. Any reliance you place on such information is strictly at your own risk. We disclaim all liability and responsibility arising from any reliance placed on such materials by you or any other visitor to the Services, or by anyone who may be informed of any of its contents.

EXCEPT AS EXPRESSLY STATED BY Malia Extensions, THE SERVICES AND ALL PRODUCTS OFFERED THROUGH THE SERVICES ARE PROVIDED 'AS IS' AND 'AS AVAILABLE' FOR YOUR USE, WITHOUT ANY REPRESENTATION, WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ALL IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, MERCHANTABLE QUALITY, FITNESS FOR A PARTICULAR PURPOSE, DURABILITY, TITLE, AND NON-INFRINGEMENT. WE DO NOT GUARANTEE, REPRESENT OR WARRANT THAT YOUR USE OF THE SERVICES WILL BE UNINTERRUPTED, TIMELY, SECURE OR ERROR-FREE. SOME JURISDICTIONS LIMIT OR DO NOT ALLOW THE DISCLAIMER OF IMPLIED OR OTHER WARRANTIES SO THE ABOVE DISCLAIMER MAY NOT APPLY TO YOU.
''',
    },
    {
      'title': 'SECTION 17 - LIMITATION OF LIABILITY',
      'content': '''TO THE FULLEST EXTENT PROVIDED BY LAW, IN NO CASE SHALL Malia Extensions, OUR PARTNERS, DIRECTORS, OFFICERS, EMPLOYEES, AFFILIATES, AGENTS, CONTRACTORS, SERVICE PROVIDERS OR LICENSORS, OR THOSE OF SHOPIFY AND ITS AFFILIATES, BE LIABLE FOR ANY INJURY, LOSS, CLAIM, OR ANY DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, SPECIAL, OR CONSEQUENTIAL DAMAGES OF ANY KIND, INCLUDING, WITHOUT LIMITATION, LOST PROFITS, LOST REVENUE, LOST SAVINGS, LOSS OF DATA, REPLACEMENT COSTS, OR ANY SIMILAR DAMAGES, WHETHER BASED IN CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, ARISING FROM YOUR USE OF ANY OF THE SERVICES OR ANY PRODUCTS PROCURED USING THE SERVICES, OR FOR ANY OTHER CLAIM RELATED IN ANY WAY TO YOUR USE OF THE SERVICES OR ANY PRODUCT, INCLUDING, BUT NOT LIMITED TO, ANY ERRORS OR OMISSIONS IN ANY CONTENT, OR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF THE SERVICES OR ANY CONTENT (OR PRODUCT) POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES, EVEN IF ADVISED OF THEIR POSSIBILITY.
''',
    },
    {
      'title': 'SECTION 18 - INDEMNIFICATION',
      'content': '''You agree to indemnify, defend and hold harmless Malia Extensions, Shopify, and our affiliates, partners, officers, directors, employees, agents, contractors, licensors, and service providers from any losses, damages, liabilities or claims, including reasonable attorneys' fees, payable to any third party due to or arising out of (1) your breach of these Terms of Service or the documents they incorporate by reference, (2) your violation of any law or the rights of a third party, or (3) your access to and use of the Services.

We will notify you of any indemnifiable claim, provided that a failure to promptly notify will not relieve you of your obligations unless you are materially prejudiced. We may control the defense and settlement of such claim at your expense, including choice of counsel, but will not settle any claim requiring non-monetary obligations from you without your consent (not to be unreasonably withheld). You will cooperate in the defense of indemnified claims, including by providing relevant documents.
''',
    },
    {
      'title': 'SECTION 19 - SEVERABILITY',
      'content': '''In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.
''',
    },
    {
      'title': 'SECTION 20 - WAIVER; ENTIRE AGREEMENT',
      'content': '''The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision.

These Terms of Service and any policies or operating rules posted by us on this site or in respect to the Service constitutes the entire agreement and understanding between you and us and governs your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service).

Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.
''',
    },
    {
      'title': 'SECTION 21 - ASSIGNMENT',
      'content': '''You may not delegate, transfer or assign this Agreement or any of your rights or obligations under these Terms without our prior written consent, and any such attempt will be null and void. We may transfer, assign, or delegate these Terms and our rights and obligations without consent or notice to you.
''',
    },
    {
      'title': 'SECTION 22 - GOVERNING LAW',
      'content': '''These Terms of Service and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the federal and state or territorial courts in the jurisdiction where Malia Extensions is headquartered. You and Malia Extensions consent to venue and personal jurisdiction in such courts.
''',
    },
    {
      'title': 'SECTION 23 - HEADINGS',
      'content': '''The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.
''',
    },
    {
      'title': 'SECTION 24 - CHANGES TO TERMS OF SERVICE',
      'content': '''You can review the most current version of the Terms of Service at any time on this page.

We reserve the right, in our sole discretion, to update, change, or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. We will notify you of any material changes to these Terms in accordance with applicable law, and such changes will be effective on the date specified in the notice. Your continued use of or access to the Services following the posting of any changes to these Terms of Service constitutes acceptance of those changes.
''',
    },
    {
      'title': 'SECTION 25 - CONTACT INFORMATION',
      'content': '''Questions about the Terms of Service should be sent to us at info@maliaextensions.com. Our contact information is posted below:

[INSERT TRADING NAME]

info@maliaextensions.com

[INSERT BUSINESS ADDRESS]

[INSERT BUSINESS PHONE NUMBER]

[INSERT BUSINESS REGISTRATION NUMBER]

[INSERT VAT NUMBER]
''',
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
                  Apptext.Termsandservice,
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
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(22.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MALIA EXTENSIONS',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.8,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: Colorstheam.nobelblack,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 22.h),
              _sectionTitle('Welcome to Malia Extensions'),
              _paragraph(
                'Welcome to Malia Extensions! The terms "we", "us" and "our" '
                    'refer to Malia Extensions. Malia Extensions operates this store '
                    'and website, including all related information, content, features, '
                    'tools, products and services in order to provide you, the customer, '
                    'with a curated shopping experience (the "Services"). '
                    'Malia Extensions is powered by Shopify, which enables us to '
                    'provide the Services to you.',
              ),
              _paragraph(
                'The below terms and conditions, together with any policies '
                    'referenced herein (these "Terms of Service" or "Terms") describe '
                    'your rights and responsibilities when you use the Services.',
              ),
              _paragraph(
                'Please read these Terms of Service carefully, as they include '
                    'important information about your legal rights and cover areas '
                    'such as warranty disclaimers and limitations of liability.',
              ),
              _paragraph(
                'By visiting, interacting with or using our Services, you agree '
                    'to be bound by these Terms of Service and our Privacy Policy.',
              ),
              SizedBox(height: 12.h),
              Text(
                'TERMS AND CONDITIONS',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: Colorstheam.dimgrey,
                ),
              ),
              SizedBox(height: 14.h),
              ..._termsSections.asMap().entries.map((entry) {
                final index = entry.key;
                final section = entry.value;
                return _termsSectionCard(
                  number: index + 1,
                  title: section['title']!,
                  content: section['content']!,
                );
              }),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colorstheam.clusterwhite,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: Colorstheam.nobelblack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Questions about the Terms of Service should be sent to us at:',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        height: 1.7,
                        color: Colorstheam.dimgrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri(
                          scheme: 'mailto',
                          path: 'info@maliaextensions.com',
                        );

                        await launchUrl(uri);
                      },
                      child: Text(
                        'info@maliaextensions.com',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                          color: Colorstheam.nobelblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        )),
    );
  }
  Widget _termsSectionCard({
    required int number,
    required String title,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colorstheam.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: Colorstheam.lightgrey,
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(Get.context!).copyWith(
          dividerColor: Colorstheam.white,
        ),
        child: ExpansionTile(
          key: PageStorageKey<String>(title),
          tilePadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 4.h,
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          leading: Container(
            width: 34.w,
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colorstheam.clusterwhite,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Text(
              number.toString().padLeft(2, '0'),
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: Colorstheam.nobelblack,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              height: 1.4,
              color: Colorstheam.nobelblack,
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 23.sp,
            color: Colorstheam.nobelblack,
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  height: 1.75,
                  color: Colorstheam.dimgrey,
                ),
              ),
            ),
          ],
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
        bottom: 10.h,
      ),
      child: Align(
        alignment: Alignment.topLeft,
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