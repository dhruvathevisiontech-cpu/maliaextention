import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/resetpassword/controller/resetpasswordcontroller.dart';

class Resetpasswordbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Resetpasswordcontroller>(
      Resetpasswordcontroller(),
    );
  }
}
