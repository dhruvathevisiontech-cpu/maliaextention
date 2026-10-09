import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/contactus/controller/contactuscontroller.dart';

class Contactusbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Contactuscontroller>(
      Contactuscontroller(),
    );
  }
}
