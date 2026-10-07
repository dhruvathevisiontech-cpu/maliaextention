import 'package:get/get.dart';
import 'package:maliaextention/apps/module/orderhistory/controller/orderhistorycontroller.dart';
import 'package:maliaextention/apps/module/orderplace/controller/orderplacecontroller.dart';
import 'package:maliaextention/apps/module/viewcart/controller/viewcartcontroller.dart';
import 'package:maliaextention/apps/module/vieworder/controller/viewordercontroller.dart';

class Vieworderbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Viewordercontroller>(
      Viewordercontroller(),
    );
  }
}
