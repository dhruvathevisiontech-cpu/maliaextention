import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/faqlist/controller/faqlistcontroller.dart';

class Faqlistbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Faqlistcontroller>(
      Faqlistcontroller(),
    );
  }
}
