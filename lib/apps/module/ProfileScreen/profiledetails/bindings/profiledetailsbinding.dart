import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/profiledetails/controller/profiledetailscontroller.dart';

class Profiledetailsbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Profiledetailscontroller>(
      Profiledetailscontroller(),
    );
  }
}
