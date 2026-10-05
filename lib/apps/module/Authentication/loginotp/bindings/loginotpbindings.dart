import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/loginotp/controller/loginotpcontroller.dart';

class Loginotpbindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Loginotpcontroller>(
      Loginotpcontroller(),
    );
  }
}
