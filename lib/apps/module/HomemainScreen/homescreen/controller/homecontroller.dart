import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController butterflyVideoController;
  final RxBool isButterflyVideoInitialized = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    butterflyVideoController = VideoPlayerController.asset(
      'asset/video/video1.mp4',
    );
    butterflyVideoController.initialize().then((_) {
      isButterflyVideoInitialized.value = true;
    }).catchError((error) {
      debugPrint('Video initialization failed: $error');
    });
  }
  @override
  void onClose() {
    homeScrollController.dispose();
    butterflyVideoController.dispose();
    super.onClose();
  }


}