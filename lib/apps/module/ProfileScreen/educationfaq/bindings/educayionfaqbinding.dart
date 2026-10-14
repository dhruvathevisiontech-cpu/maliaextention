import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/educationfaq/controller/educationfaqcontroller.dart';


class Educationfaqbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Educationfaqcontroller>(
      Educationfaqcontroller(),
    );
  }
}
