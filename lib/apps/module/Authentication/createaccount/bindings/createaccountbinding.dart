import 'package:get/get.dart';
import 'package:maliaextention/apps/module/Authentication/createaccount/controller/createaccountcontroller.dart';

class Createaccountbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Createaccountcontroller>(
      Createaccountcontroller(),
    );
  }
}
