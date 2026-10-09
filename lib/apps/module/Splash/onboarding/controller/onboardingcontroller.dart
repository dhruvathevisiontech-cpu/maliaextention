import 'package:get/get.dart';

class Onboardingcontroller extends GetxController {
  RxInt selectedButton = 0.obs;
  void selectButton(int index) {
    selectedButton.value = index;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}