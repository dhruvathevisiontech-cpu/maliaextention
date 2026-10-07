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
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/bindings/addresslistbinding.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/controller/addresslistcontroller.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/view/addresslistview.dart';
import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/bindings/saveaddressbinding.dart';
import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/view/saveaddressview.dart';
import 'package:maliaextention/apps/module/InPerson/bindings/inpersonbinding.dart';
import 'package:maliaextention/apps/module/InPerson/view/inpersonview.dart';
import 'package:maliaextention/apps/module/bottomnavigation/bindings/bottomnavigationbinding.dart';
import 'package:maliaextention/apps/module/bottomnavigation/view/bottomnavigationview.dart';
import 'package:maliaextention/apps/module/collection/bindings/collectionbinidng.dart';
import 'package:maliaextention/apps/module/collection/view/collectionview.dart';
import 'package:maliaextention/apps/module/collectionlist/bindings/collectionlistbinding.dart';
import 'package:maliaextention/apps/module/collectionlist/view/collectionlistview.dart';
import 'package:maliaextention/apps/module/education/bindings/educationbinding.dart';
import 'package:maliaextention/apps/module/education/view/educationview.dart';
import 'package:maliaextention/apps/module/homescreen/bindings/homebinding.dart';
import 'package:maliaextention/apps/module/homescreen/view/homeview.dart';
import 'package:maliaextention/apps/module/hostclass/bindings/hostclassbinding.dart';
import 'package:maliaextention/apps/module/hostclass/view/hostclassview.dart';
import 'package:maliaextention/apps/module/onboarding/bindings/onboardingbinding.dart';
import 'package:maliaextention/apps/module/onboarding/view/onboardingview.dart';
import 'package:maliaextention/apps/module/onlinetraining/bindings/onlinetrainingbinding.dart';
import 'package:maliaextention/apps/module/onlinetraining/view/onlinetrainingview.dart';
import 'package:maliaextention/apps/module/onlinetrainingviewclass/bindings/onlinetrainingviewclassbinding.dart';
import 'package:maliaextention/apps/module/onlinetrainingviewclass/view/onlinetrainingviewclass.dart';
import 'package:maliaextention/apps/module/orderhistory/bindings/orderhistorybinding.dart';
import 'package:maliaextention/apps/module/orderhistory/view/orderhistoryview.dart';
import 'package:maliaextention/apps/module/orderplace/bindings/orderplacebinding.dart';
import 'package:maliaextention/apps/module/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/orderplace/view/orderplaceview.dart';
import 'package:maliaextention/apps/module/productdetails/bindings/productdetailsbinding.dart';
import 'package:maliaextention/apps/module/productdetails/view/productdetailsview.dart';
import 'package:maliaextention/apps/module/profile/bindings/profilebinding.dart';
import 'package:maliaextention/apps/module/profile/view/profileview.dart';
import 'package:maliaextention/apps/module/search/bindings/searchbinding.dart';
import 'package:maliaextention/apps/module/search/view/searchview.dart';
import 'package:maliaextention/apps/module/splashscreen/bindings/splashscreenbinding.dart';
import 'package:maliaextention/apps/module/splashscreen/view/splashscreenview.dart';
import 'package:maliaextention/apps/module/viewcart/bindings/viewcartbinding.dart';
import 'package:maliaextention/apps/module/viewcart/view/viewcart.dart';
import 'package:maliaextention/apps/module/viewclass/bindings/viewclassbinding.dart';
import 'package:maliaextention/apps/module/viewclass/view/viewclass.dart';
import 'package:maliaextention/apps/module/vieworder/bindings/vieworderbinding.dart';
import 'package:maliaextention/apps/module/vieworder/view/vieworder.dart';
import 'package:maliaextention/apps/module/wishlist/bindings/wishlistbinding.dart';
import 'package:maliaextention/apps/module/wishlist/view/wishlistview.dart';
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
  ];
}