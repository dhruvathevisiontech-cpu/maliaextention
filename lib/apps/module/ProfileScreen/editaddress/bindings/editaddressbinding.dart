import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/editaddress/controller/editaddresscontroller.dart';

class Editaddressbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Editaddresscontroller>(
      Editaddresscontroller(),
    );
  }
}
