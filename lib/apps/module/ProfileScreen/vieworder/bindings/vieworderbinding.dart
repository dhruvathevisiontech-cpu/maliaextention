import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/vieworder/controller/viewordercontroller.dart';

class Vieworderbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Viewordercontroller>(
      Viewordercontroller(),
    );
  }
}
