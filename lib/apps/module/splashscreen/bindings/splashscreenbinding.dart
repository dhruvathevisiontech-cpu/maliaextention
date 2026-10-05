import 'package:get/get.dart';
import 'package:maliaextention/apps/module/splashscreen/controller/splashscreencontroller.dart';
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(),
    );
  }
}
