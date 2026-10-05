import 'package:get/get.dart';

class Onlinetrainingviewclasscontroller extends GetxController {
  final RxBool isWishlisted = false.obs;
  final selectedAction = 0.obs;
  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
  }
  final RxBool isExpanded = false.obs;
  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}