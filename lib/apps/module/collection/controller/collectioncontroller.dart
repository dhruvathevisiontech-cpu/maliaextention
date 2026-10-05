import 'package:get/get.dart';

class Collectioncontroller extends GetxController {
  RxInt selectedCollection = (-1).obs;

  void selectCollection(int index) {
    selectedCollection.value = index;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}