import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/accountoption/controller/accountoptioncontroller.dart';

class Accountoptionbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Accountoptioncontroller>(
      Accountoptioncontroller(),
    );
  }
}
