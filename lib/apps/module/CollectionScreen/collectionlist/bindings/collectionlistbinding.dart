import 'package:get/get.dart';
import 'package:maliaextention/apps/module/CollectionScreen/collectionlist/controller/collectionlistcontroller.dart';

class Collectionlistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Collectionlistcontroller>(
      Collectionlistcontroller(),
    );
  }
}
