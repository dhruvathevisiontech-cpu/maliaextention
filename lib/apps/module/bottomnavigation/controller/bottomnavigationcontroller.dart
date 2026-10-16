import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/controller/collectioncontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collection/view/collectionview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/controller/collectionlistcontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/view/collectionlistview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/controller/filtercontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/view/filterview.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/controller/productdetailscontroller.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/view/productdetailsview.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/controller/inpersoncontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/InPerson/view/inpersonview.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/controller/educationcontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/view/educationview.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/controller/hostclasscontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/view/hostclassview.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/controller/onlinetrainingcontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/view/onlinetrainingview.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/controller/onlinetrainingviewclasscontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/view/onlinetrainingviewclass.dart';
import 'package:maliaextention/apps/module/EducationScreen/viewclass/controller/viewclasscontroller.dart';
import 'package:maliaextention/apps/module/EducationScreen/viewclass/view/viewclass.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/view/homeview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/view/orderplaceview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/view/searchview.dart';
import 'package:maliaextention/apps/module/HomemainScreen/viewcart/controller/viewcartcontroller.dart';
import 'package:maliaextention/apps/module/HomemainScreen/viewcart/view/viewcart.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/controller/addresslistcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/view/addresslistview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/blog/controller/blogcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/blog/view/blogview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/controller/contactuscontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/view/contactusview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/controller/educationfaqcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/view/educationfaqview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/controller/faqlistcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/view/faqlistview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/gallary/controller/gallarycontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/gallary/view/gallaryview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/controller/orderhistorycontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/view/orderhistoryview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/controller/policycontoller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/view/policyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/controller/privacypolicycontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/view/privacypolicyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/controller/profilecontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/view/profileview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/controller/profiledetailscontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/view/profiledetailsview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/controller/returnandrefundcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/view/returnandrefundview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/controller/salonlocatorcontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/view/salonlocatorview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/saveaddress/controller/saveaddresscontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/saveaddress/view/saveaddressview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/controller/shippingpolicycontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/shippingpolicy/view/shippingpolicyview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/controller/termsandservicecontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/view/termsandserviceview.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/controller/viewordercontroller.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/view/vieworder.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/view/wishlistview.dart';

enum PageType {home, list, search, collection, collectionlist,productdetails,education,inperson,viewclass,onlinetraing,onlinetrainingviewclass,hostclass,profile,wishlist,viewcart,addresslist,saveaddress,orderplace,orderhistory,vieworder,salonlocator,filter,contactus,faqlist,educationfaq,policy,privacypolicy,shippingpolicy,returnandrefundpolicy,termsandservice,educationbundle,profiledetails,gallary,blog}
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
    final productDetailsController = Get.find<Productdetailscontroller>();

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

      case PageType.filter:
        if (!Get.isRegistered<Filtercontroller>()) {
          Get.put(Filtercontroller());
        }

        return Filterview();

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

      case PageType.salonlocator:
        if (!Get.isRegistered<Salonlocatorcontroller>()) {
          Get.put(Salonlocatorcontroller());
        }
        return Salonlocatorview();

      case PageType.faqlist:
        if (!Get.isRegistered<Faqlistcontroller>()) {
          Get.put(Faqlistcontroller());
        }
        return Faqlistview();

      case PageType.contactus:
        if (!Get.isRegistered<Contactuscontroller>()) {
          Get.put(Contactuscontroller());
        }
        return Contactusview();

      case PageType.vieworder:
        if (!Get.isRegistered<Viewordercontroller>()) {
          Get.put(Viewordercontroller());
        }
        return Vieworder();

      case PageType.educationfaq:
        if (!Get.isRegistered<Educationfaqcontroller>()) {
          Get.put(Educationfaqcontroller());
        }
        return Educationfaqview();

      case PageType.policy:
        if (!Get.isRegistered<Policycontoller>()) {
          Get.put(Policycontoller());
        }
        return Policyview();

      case PageType.privacypolicy:
        if (!Get.isRegistered<Privacypolicycontroller>()) {
          Get.put(Privacypolicycontroller());
        }
        return Privacypolicyview();

      case PageType.shippingpolicy:
        if (!Get.isRegistered<Shippingpolicycontroller>()) {
          Get.put(Shippingpolicycontroller());
        }
        return Shippingpolicyview();

      case PageType.returnandrefundpolicy:
        if (!Get.isRegistered<Returnandrefundcontroller>()) {
          Get.put(Returnandrefundcontroller());
        }
        return Returnandrefundview();

      case PageType.termsandservice:
        if (!Get.isRegistered<Termsandservicecontroller>()) {
          Get.put(Termsandservicecontroller());
        }
        return Termsandserviceview();

      case PageType.gallary:
        if (!Get.isRegistered<Gallarycontroller>()) {
          Get.put(Gallarycontroller());
        }
        return Gallaryview();

      case PageType.profiledetails:
        if (!Get.isRegistered<Profiledetailscontroller>()) {
          Get.put(Profiledetailscontroller());
        }
        return Profiledetailsview();

      case PageType.blog:
        if (!Get.isRegistered<Blogcontroller>()) {
          Get.put(Blogcontroller());
        }
        return Blogview();

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