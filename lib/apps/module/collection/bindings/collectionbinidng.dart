import 'package:get/get.dart';
import 'package:maliaextention/apps/module/collection/controller/collectioncontroller.dart';

class Collectionbinidng extends Bindings {
  @override
  void dependencies() {
    Get.put<Collectioncontroller>(
      Collectioncontroller(),
    );
  }
}
