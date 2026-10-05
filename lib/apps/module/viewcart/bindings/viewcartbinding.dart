import 'package:get/get.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';

class Viewcartbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Viewcartcontroller>(
      Viewcartcontroller(),
    );
  }
}
