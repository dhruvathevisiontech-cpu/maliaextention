import 'package:get/get.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';
import 'package:maliaextention/apps/module/homescreen/controller/homecontroller.dart';

class Bottomnavigationbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Bottomnavigationcontroller>(Bottomnavigationcontroller(), permanent: true);
    Get.lazyPut<Homecontroller>(() => Homecontroller());
  }
}
