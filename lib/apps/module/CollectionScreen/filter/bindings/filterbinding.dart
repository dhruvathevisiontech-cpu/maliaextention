import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/filter/controller/filtercontroller.dart';

class Filterbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Filtercontroller>(
      Filtercontroller(),
    );
  }
}
