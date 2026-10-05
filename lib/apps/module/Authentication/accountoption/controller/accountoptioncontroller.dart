import 'package:get/get.dart';

class Accountoptioncontroller extends GetxController {
  RxInt selectedOption = 0.obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }
}