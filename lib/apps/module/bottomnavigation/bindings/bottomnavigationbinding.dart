import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/homescreen/controller/homecontroller.dart';
import 'package:maliaextention/apps/module/bottomnavigation/controller/bottomnavigationcontroller.dart';

class Bottomnavigationbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Bottomnavigationcontroller>(Bottomnavigationcontroller(), permanent: true);
    Get.lazyPut<Homecontroller>(() => Homecontroller());
  }
}
