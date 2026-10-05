import 'package:get/get.dart';
import 'package:maliaextention/apps/module/onlinetraining/controller/onlinetrainingcontroller.dart';
import 'package:maliaextention/apps/module/search/controller/searchcontroller.dart';
import 'package:maliaextention/apps/module/viewclass/controller/viewclasscontroller.dart';

class Onlinetrainingbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Onlinetrainingcontroller>(
      Onlinetrainingcontroller(),
    );
  }
}
