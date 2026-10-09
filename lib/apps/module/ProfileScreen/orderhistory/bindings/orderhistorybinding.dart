import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/orderhistory/controller/orderhistorycontroller.dart';

class Orderhistorybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Orderhistorycontroller>(
      Orderhistorycontroller(),
    );
  }
}
