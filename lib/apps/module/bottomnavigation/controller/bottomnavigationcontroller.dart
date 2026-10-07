import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/controller/addresslistcontroller.dart';
import 'package:maliaextention/apps/module/CustomerAddress/addresslist/view/addresslistview.dart';
import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/controller%20/saveaddresscontroller.dart';
import 'package:maliaextention/apps/module/CustomerAddress/saveaddress/view/saveaddressview.dart';
import 'package:maliaextention/apps/module/InPerson/controller/inpersoncontroller.dart';
import 'package:maliaextention/apps/module/InPerson/view/inpersonview.dart';
import 'package:maliaextention/apps/module/collection/controller/collectioncontroller.dart';
import 'package:maliaextention/apps/module/collection/view/collectionview.dart';
import 'package:maliaextention/apps/module/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/apps/module/collectionlist/view/collectionlistview.dart';
import 'package:maliaextention/apps/module/education/controller/educationcontroller.dart';
import 'package:maliaextention/apps/module/education/view/educationview.dart';
import 'package:maliaextention/apps/module/homescreen/view/homeview.dart';
import 'package:maliaextention/apps/module/hostclass/controller/hostclasscontroller.dart';
import 'package:maliaextention/apps/module/hostclass/view/hostclassview.dart';
import 'package:maliaextention/apps/module/onlinetraining/controller/onlinetrainingcontroller.dart';
import 'package:maliaextention/apps/module/onlinetraining/view/onlinetrainingview.dart';
import 'package:maliaextention/apps/module/onlinetrainingviewclass/controller/onlinetrainingviewclasscontroller.dart';
import 'package:maliaextention/apps/module/onlinetrainingviewclass/view/onlinetrainingviewclass.dart';
import 'package:maliaextention/apps/module/orderhistory/controller/orderhistorycontroller.dart';
import 'package:maliaextention/apps/module/orderhistory/view/orderhistoryview.dart';
import 'package:maliaextention/apps/module/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/orderplace/view/orderplaceview.dart';
import 'package:maliaextention/apps/module/productdetails/controller/productdetailscontroller.dart';
import 'package:maliaextention/apps/module/productdetails/view/productdetailsview.dart';
import 'package:maliaextention/apps/module/profile/controller/profilecontroller.dart';
import 'package:maliaextention/apps/module/profile/view/profileview.dart';
import 'package:maliaextention/apps/module/search/view/searchview.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';
import 'package:maliaextention/apps/module/viewcart/view/viewcart.dart';
import 'package:maliaextention/apps/module/viewclass/controller/viewclasscontroller.dart';
import 'package:maliaextention/apps/module/viewclass/view/viewclass.dart';
import 'package:maliaextention/apps/module/wishlist/view/wishlistview.dart';

enum PageType {home, list, search, collection, collectionlist,productdetails,education,inperson,viewclass,onlinetraing,onlinetrainingviewclass,hostclass,profile,wishlist,viewcart,addresslist,saveaddress,orderplace,orderhistory,vieworder}
enum NavigationSource {
  productList,
  settings,
  education,
  home,
  profile,
  unknown
}
class Bottomnavigationcontroller extends GetxController {
  var selectedIndex = 0.obs;
  var currentPage = PageType.list.obs;
  var selectedCollectionIndex = 0.obs;
  var selectedCollectionName = ''.obs;
  final Rxn<Map<String, String>> selectedProduct = Rxn<Map<String, String>>();
  void openProductDetails(Map<String, String> product) {
    selectedProduct.value = product;

    if (!Get.isRegistered<Productdetailscontroller>()) {
      Get.put(Productdetailscontroller());
    }

    final productDetailsController =
    Get.find<Productdetailscontroller>();

    productDetailsController.setProduct(product);

    currentPage.value = PageType.productdetails;
  }

  void changeIndex(int index) {
    if ((index == 0 || index == 1 || index == 2||index == 3||index == 4)) {
      selectedIndex.value = index;
      currentPage.value = PageType.list;
      return;
    }
    selectedIndex.value = index;
    currentPage.value = PageType.list;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  Widget get currentCollectionPage {
    switch (currentPage.value) {
      case PageType.collectionlist:
        if (!Get.isRegistered<Collectionlistcontroller>()) {
          Get.put(Collectionlistcontroller());
        }
        return Collectionlistview();

      case PageType.productdetails:
        if (!Get.isRegistered<Productdetailscontroller>()) {
          Get.put(Productdetailscontroller());
        }

        return Productdetailsview();

      case PageType.collection:
      default:
        if (!Get.isRegistered<Collectioncontroller>()) {
          Get.put(Collectioncontroller());
        }
        return Collectionview();
    }
  }
  Widget get currentEducationPage {
    switch (currentPage.value) {
      case PageType.inperson:
        if (!Get.isRegistered<Inpersoncontroller>()) {
          Get.put(Inpersoncontroller());
        }
        return Inpersonview();

      case PageType.viewclass:
        if (!Get.isRegistered<Viewclasscontroller>()) {
          Get.put(Viewclasscontroller());
        }
        return Viewclass();

      case PageType.onlinetraing:
        if (!Get.isRegistered<Onlinetrainingcontroller>()) {
          Get.put(Onlinetrainingcontroller());
        }
        return Onlinetrainingview();

      case PageType.onlinetrainingviewclass:
        if (!Get.isRegistered<Onlinetrainingviewclasscontroller>()) {
          Get.put(Onlinetrainingviewclasscontroller());
        }
        return Onlinetrainingviewclass();

      case PageType.hostclass:
        if (!Get.isRegistered<Hostclasscontroller>()) {
          Get.put(Hostclasscontroller());
        }
        return Hostclassview();


      case PageType.education:
      default:
        if (!Get.isRegistered<Educationcontroller>()) {
          Get.put(Educationcontroller());
        }
        return Educationview();
    }
  }
  Widget get currentPofile {
    switch (currentPage.value) {
      case PageType.addresslist:
        if (!Get.isRegistered<Addresslistcontroller>()) {
          Get.put(Addresslistcontroller());
        }
        return Addresslistview();

      case PageType.saveaddress:
        if (!Get.isRegistered<Saveaddresscontroller>()) {
          Get.put(Saveaddresscontroller());
        }
        return Saveaddressview();

      case PageType.orderhistory:
        if (!Get.isRegistered<Orderhistorycontroller>()) {
          Get.put(Orderhistorycontroller());
        }
        return Orderhistoryview();

      case PageType.profile:
      default:
        if (!Get.isRegistered<Profilecontroller>()) {
          Get.put(Profilecontroller());
        }

        return Profileview();
    }
  }
  Widget get currentWishlist {
    switch (currentPage.value) {
      case PageType.wishlist:
      default:
        return Wishlistview();
    }
  }
  Widget get currentHomePage {
    switch (currentPage.value) {
      case PageType.viewcart:
        if (!Get.isRegistered<Viewcartcontroller>()) {
          Get.put(Viewcartcontroller());
        }
        return Viewcart();

      case PageType.orderplace:
        if (!Get.isRegistered<Orderplacecontroller>()) {
          Get.put(Orderplacecontroller());
        }
        return Orderplaceview();

      case PageType.search:
        return Searchview();
      case PageType.home:
      default:
        return Homeview();
    }
  }
}