import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/returnandrefund/controller/returnandrefundcontroller.dart';

class Returnandrefundbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Returnandrefundcontroller>(
      Returnandrefundcontroller(),
    );
  }
}
