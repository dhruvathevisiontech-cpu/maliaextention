import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/login/controller/logincontroller.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Logincontroller>(
      Logincontroller(),
    );
  }
}
