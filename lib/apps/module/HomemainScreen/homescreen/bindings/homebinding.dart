import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/controller/homecontroller.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Homecontroller>(
      Homecontroller(),
    );
  }
}
