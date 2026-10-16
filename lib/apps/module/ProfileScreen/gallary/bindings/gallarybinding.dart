import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/gallary/controller/gallarycontroller.dart';

class Gallarybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Gallarycontroller>(
      Gallarycontroller(),
    );
  }
}
