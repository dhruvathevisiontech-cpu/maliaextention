import 'package:get/get.dart';
import 'package:maliaextention/apps/module/InPerson/controller/inpersoncontroller.dart';

class Inpersonbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Inpersoncontroller>(
      Inpersoncontroller(),
    );
  }
}
