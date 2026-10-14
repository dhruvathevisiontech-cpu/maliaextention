import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/privacypolicy/controller/privacypolicycontroller.dart';

class Privacypolicybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Privacypolicycontroller>(
      Privacypolicycontroller(),
    );
  }
}
