import 'package:get/get.dart';
import 'package:maliaextention/apps/module/EducationScreen/education/controller/educationcontroller.dart';

class Educationbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Educationcontroller>(
      Educationcontroller(),
    );
  }
}
