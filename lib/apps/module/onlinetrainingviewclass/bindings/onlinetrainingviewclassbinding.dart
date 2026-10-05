import 'package:get/get.dart';
import 'package:maliaextention/apps/module/onlinetraining/controller/onlinetrainingcontroller.dart';
import 'package:maliaextention/apps/module/onlinetrainingviewclass/controller/onlinetrainingviewclasscontroller.dart';
import 'package:maliaextention/apps/module/search/controller/searchcontroller.dart';
import 'package:maliaextention/apps/module/viewclass/controller/viewclasscontroller.dart';

class Onlinetrainingviewclassbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Onlinetrainingviewclasscontroller>(
      Onlinetrainingviewclasscontroller(),
    );
  }
}
