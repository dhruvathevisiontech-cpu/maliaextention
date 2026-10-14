import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/termsandservice/controller/termsandservicecontroller.dart';

class Termsandservicebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Termsandservicecontroller>(
      Termsandservicecontroller(),
    );
  }
}
