import 'package:get/get.dart';
import 'package:maliaextention/apps/module/search/controller/searchcontroller.dart';
import 'package:maliaextention/apps/module/viewclass/controller/viewclasscontroller.dart';

class Viewclassbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Viewclasscontroller>(
      Viewclasscontroller(),
    );
  }
}
