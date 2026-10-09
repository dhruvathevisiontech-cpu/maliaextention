import 'package:get/get.dart';
import 'package:maliaextention/apps/module/EducationScreen/onlinetraining/controller/onlinetrainingcontroller.dart';

class Onlinetrainingbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Onlinetrainingcontroller>(
      Onlinetrainingcontroller(),
    );
  }
}
