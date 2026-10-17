import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/aboutus/controller/aboutuscontroller.dart';

class Aboutusbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Aboutuscontroller>(
      Aboutuscontroller(),
    );
  }
}
