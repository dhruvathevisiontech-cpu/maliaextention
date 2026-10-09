import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/productdetails/controller/productdetailscontroller.dart';

class Productdetailsbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Productdetailscontroller>(
      Productdetailscontroller(),
    );
  }
}
