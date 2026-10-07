import 'package:get/get.dart';
import 'package:maliaextention/apps/module/orderhistory/controller/orderhistorycontroller.dart';
import 'package:maliaextention/apps/module/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';

class Orderhistorybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Orderhistorycontroller>(
      Orderhistorycontroller(),
    );
  }
}
