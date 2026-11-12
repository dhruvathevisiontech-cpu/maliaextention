import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Viewclasscontroller extends GetxController {
  final PageController carouselController = PageController();
  final RxInt currentCarouselIndex = 0.obs;
  final List<String> carouselImages = [
    'asset/image/sliderimage.webp',
    'asset/image/sliderimage.webp',
    'asset/image/sliderimage.webp',
  ];
  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }
  @override
  void onClose() {
    carouselController.dispose();
    super.onClose();
  }
}