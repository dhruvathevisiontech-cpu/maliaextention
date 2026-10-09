import 'package:get/get.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetrainingviewclass/controller/onlinetrainingviewclasscontroller.dart';

class Onlinetrainingviewclassbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Onlinetrainingviewclasscontroller>(
      Onlinetrainingviewclasscontroller(),
    );
  }
}
