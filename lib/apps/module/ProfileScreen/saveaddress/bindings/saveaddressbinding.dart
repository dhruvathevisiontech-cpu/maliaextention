import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/saveaddress/controller/saveaddresscontroller.dart';

class Saveaddressbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Saveaddresscontroller>(
      Saveaddresscontroller(),
    );
  }
}
