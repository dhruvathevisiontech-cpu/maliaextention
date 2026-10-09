import 'package:get/get.dart';
import 'package:maliaextention/apps/module/EducationScreen/viewclass/controller/viewclasscontroller.dart';

class Viewclassbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Viewclasscontroller>(
      Viewclasscontroller(),
    );
  }
}
