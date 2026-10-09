import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  final ScrollController homeScrollController = ScrollController();
  RxString selectedLength = "16".obs;
  void selectLength(String length) {
    selectedLength.value = length;
  }
  RxInt selectedEducation = 0.obs;

  void selectEducation(int index) {
    selectedEducation.value = index;
  }
  final RxSet<int> wishlistItems = <int>{}.obs;

  void toggleWishlist(int index) {
    if (wishlistItems.contains(index)) {
      wishlistItems.remove(index);
    } else {
      wishlistItems.add(index);
    }
  }

  bool isWishlisted(int index) {
    return wishlistItems.contains(index);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    homeScrollController.dispose();
    super.onClose();
  }


}