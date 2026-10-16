import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/blog/controller/blogcontroller.dart';

class Blogbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Blogcontroller>(
      Blogcontroller(),
    );
  }
}
