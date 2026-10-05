import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/prostylistreg/controller/prostyleregcontroller.dart';

class Prostylistregbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Prostyleregcontroller>(
      Prostyleregcontroller(),
    );
  }
}
