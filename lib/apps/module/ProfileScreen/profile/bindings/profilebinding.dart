import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profile/controller/profilecontroller.dart';

class Profilebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Profilecontroller>(
      Profilecontroller(),
    );
  }
}
