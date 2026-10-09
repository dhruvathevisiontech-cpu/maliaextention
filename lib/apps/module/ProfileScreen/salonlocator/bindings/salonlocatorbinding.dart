import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/salonlocator/controller/salonlocatorcontroller.dart';

class Salonlocatorbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Salonlocatorcontroller>(
      Salonlocatorcontroller(),
    );
  }
}
