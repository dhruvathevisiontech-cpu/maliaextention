import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Splash/onboarding/controller/onboardingcontroller.dart';

class Onboardingbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Onboardingcontroller>(
          () => Onboardingcontroller(),
    );
  }
}
