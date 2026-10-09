import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/orderplace/controller/orderplacecontroller.dart';

class Orderplacebinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Orderplacecontroller>(
      Orderplacecontroller(),
    );
  }
}
