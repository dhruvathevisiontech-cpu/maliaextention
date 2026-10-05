import 'package:get/get.dart';
import 'package:maliaextention/apps/module/search/controller/searchcontroller.dart';

class Searchbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Searchcontroller>(
      Searchcontroller(),
    );
  }
}
