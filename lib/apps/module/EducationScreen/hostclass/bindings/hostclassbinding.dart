import 'package:get/get.dart';
import 'package:maliaextention/apps/module/EducationScreen/hostclass/controller/hostclasscontroller.dart';

class Hostclassbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Hostclasscontroller>(
      Hostclasscontroller(),
    );
  }
}
