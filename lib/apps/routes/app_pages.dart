import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/accountoption/bindings/accountoptionbinding.dart';
import 'package:maliaextention/apps/module/Authentication/accountoption/view/accountoptionview.dart';
import 'package:maliaextention/apps/module/Authentication/createaccount/bindings/createaccountbinding.dart';
import 'package:maliaextention/apps/module/Authentication/createaccount/view/createaccountview.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpassword/bindings/forgotpasswordbinding.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpassword/view/forgotpasswordview.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpasswordcode/bindings/forgotpasscodebinding.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpasswordcode/view/forgotpasscodeview.dart';
import 'package:maliaextention/apps/module/Authentication/login/bindings/loginbinding.dart';
import 'package:maliaextention/apps/module/Authentication/login/view/loginview.dart';
import 'package:maliaextention/apps/module/Authentication/loginotp/bindings/loginotpbindings.dart';
import 'package:maliaextention/apps/module/Authentication/loginotp/view/loginotpview.dart';
import 'package:maliaextention/apps/module/Authentication/prostylistreg/bindings/prostylistregbinding.dart';
import 'package:maliaextention/apps/module/Authentication/prostylistreg/view/prostyleregview.dart';
import 'package:maliaextention/apps/module/Authentication/resetpassword/bindings/resetpasswordbinding.dart';
import 'package:maliaextention/apps/module/Authentication/resetpassword/view/resetpasswordview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/bindings/collectionbinidng.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/view/collectionview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/bindings/collectionlistbinding.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/view/collectionlistview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/bindings/filterbinding.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/view/filterview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/bindings/productdetailsbinding.dart' show Productdetailsbinding;
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/view/productdetailsview.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/bindings/inpersonbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/view/inpersonview.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/bindings/educationbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/view/educationview.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/bindings/hostclassbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/view/hostclassview.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/bindings/onlinetrainingbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/view/onlinetrainingview.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/bindings/onlinetrainingviewclassbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/view/onlinetrainingviewclass.dart';
import 'package:maliaextention/apps/module/EducationScreen/viewclass/bindings/viewclassbinding.dart';
import 'package:maliaextention/apps/module/EducationScreen/viewclass/view/viewclass.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/bindings/homebinding.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/view/homeview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/bindings/orderplacebinding.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/view/orderplaceview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/bindings/searchbinding.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/view/searchview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/viewcart/bindings/viewcartbinding.dart';
import 'package:maliaextention/apps/module/HomemainScreen/viewcart/view/viewcart.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/bindings/addresslistbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/view/addresslistview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/bindings/contactusbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/view/contactusview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/bindings/educayionfaqbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/view/educationfaqview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/bindings/faqlistbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/view/faqlistview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/bindings/orderhistorybinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/view/orderhistoryview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/bindings/policybinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/view/policyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/bindings/privacypolicybinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/view/privacypolicyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/bindings/profilebinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/view/profileview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/bindings/profiledetailsbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/view/profiledetailsview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/bindings/returnandrefundbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/view/returnandrefundview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/bindings/salonlocatorbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/view/salonlocatorview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/saveaddress/bindings/saveaddressbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/saveaddress/view/saveaddressview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/bindings/shippingpolicybinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/view/shippingpolicyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/bindings/termsandservicebinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/view/termsandserviceview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/bindings/vieworderbinding.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/view/vieworder.dart';
import 'package:maliaextention/apps/module/Splash/onboarding/bindings/onboardingbinding.dart';
import 'package:maliaextention/apps/module/Splash/onboarding/view/onboardingview.dart';
import 'package:maliaextention/apps/module/Splash/splashscreen/bindings/splashscreenbinding.dart';
import 'package:maliaextention/apps/module/Splash/splashscreen/view/splashscreenview.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/bindings/wishlistbinding.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/view/wishlistview.dart';
import 'package:maliaextention/apps/module/bottomnavigation/bindings/bottomnavigationbinding.dart';
import 'package:maliaextention/apps/module/bottomnavigation/view/bottomnavigationview.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ONBOARDING,
        page: () => Onboardingview(),
        binding: Onboardingbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => Loginview(),
        binding: Loginbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.CREATEACCOUNT,
        page: () => Createaccountview(),
        binding: Createaccountbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.LOGINOTP,
        page: () => Loginotpview(),
        binding: Loginotpbindings(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.FORGOTPASSWORD,
        page: () => Forgotpasswordview(),
        binding: Forgotpasswordbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ACCOUNTOPTION,
        page: () => Accountoptionview(),
        binding: Accountoptionbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.PROSTYLISTREGISTRATION,
        page: () => Prostyleregview(),
        binding: Prostylistregbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.FORGOTPASSWORDCODE,
        page: () => Forgotpasscodeview(),
        binding: Forgotpasscodebinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.RESETPASSWORD,
        page: () => Resetpasswordview(),
        binding: Resetpasswordbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => Homeview(),
        binding: Homebinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.BOTTOMNAV,
        page: () => Bottomnavigationview(),
        binding: Bottomnavigationbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.SEARCH,
        page: () => Searchview(),
        binding: Searchbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.COLLECTION,
        page: () => Collectionview(),
        binding: Collectionbinidng(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.COLLECTIONLISTVIEW,
        page: () => Collectionlistview(),
        binding: Collectionlistbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.PRODUCTDETAILS,
        page: () => Productdetailsview(),
        binding: Productdetailsbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.EDUCATION,
        page: () => Educationview(),
        binding: Educationbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.INPERSON,
        page: () => Inpersonview(),
        binding: Inpersonbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.VIEWCLASS,
        page: () => Viewclass(),
        binding: Viewclassbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ONLINETRAINING,
        page: () => Onlinetrainingview(),
        binding: Onlinetrainingbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ONLINETRAININGVIEWCLASS,
        page: () => Onlinetrainingviewclass(),
        binding: Onlinetrainingviewclassbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.HOSTCLASS,
        page: () => Hostclassview(),
        binding: Hostclassbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.PROFILE,
        page: () => Profileview(),
        binding: Profilebinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.WISHLIST,
        page: () => Wishlistview(),
        binding: Wishlistbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.VIEWCART,
        page: () => Viewcart(),
        binding: Viewcartbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ADDRESSLIST,
        page: () => Addresslistview(),
        binding: Addresslistbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.SAVEADDRESS,
        page: () => Saveaddressview(),
        binding: Saveaddressbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ORDERPLACE,
        page: () => Orderplaceview(),
        binding: Orderplacebinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.ORDERHISTORY,
        page: () => Orderhistoryview(),
        binding: Orderhistorybinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.VIEWORDER,
        page: () => Vieworder(),
        binding: Vieworderbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.SALONLOCTOR,
        page: () => Salonlocatorview(),
        binding: Salonlocatorbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.FILTER,
        page: () => Filterview(),
        binding: Filterbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.CONTACTUS,
        page: () => Contactusview(),
        binding: Contactusbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.FAQLIST,
        page: () => Faqlistview(),
        binding: Faqlistbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.EDUCATIONFAQ,
        page: () => Educationfaqview(),
        binding: Educationfaqbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.POLICY,
        page: () => Policyview(),
        binding: Policybinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.PRIVACYPOLICY,
        page: () => Privacypolicyview(),
        binding: Privacypolicybinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.SHIPPINGPOLICY,
        page: () => Shippingpolicyview(),
        binding: Shippingpolicybinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.RETURNANDREFUND,
        page: () => Returnandrefundview(),
        binding: Returnandrefundbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.TERMSNDSERVIC,
        page: () => Termsandserviceview(),
        binding: Termsandservicebinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
    GetPage(
        name: _Paths.PROFILEDETAILS,
        page: () => Profiledetailsview(),
        binding: Profiledetailsbinding(),
        transition: Transition.noTransition,
        curve: Curves.elasticIn
    ),
  ];
}