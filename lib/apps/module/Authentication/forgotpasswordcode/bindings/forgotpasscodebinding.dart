import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpasswordcode/controller/forgotpasscodecontroller.dart';

class Forgotpasscodebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Forgotpasscodecontroller>(
      Forgotpasscodecontroller(),
    );
  }
}
