/// ------------------------------------------------------------
/// Change Log
/// ------------------------------------------------------------
/// 2026-08-08
/// - Build This screen
/// ------------------------------------------------------------
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/forgotpassword/controller/forgotpasswordcontroller.dart';

class Forgotpasswordbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Forgotpasswordcontroller>(
      Forgotpasswordcontroller(),
    );
  }
}
