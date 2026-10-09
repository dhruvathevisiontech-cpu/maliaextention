import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/addresslist/controller/addresslistcontroller.dart';

class Addresslistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Addresslistcontroller>(
      Addresslistcontroller(),
    );
  }
}
