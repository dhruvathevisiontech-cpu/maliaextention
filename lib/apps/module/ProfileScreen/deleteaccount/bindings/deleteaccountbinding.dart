import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/deleteaccount/controller/deleteaccountcontroller.dart';

class Deleteaccountbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Deleteaccountcontroller>(
      Deleteaccountcontroller(),
    );
  }
}
