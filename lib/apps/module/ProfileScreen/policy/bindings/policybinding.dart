import 'package:get/get.dart';
import 'package:maliaextention/apps/module/ProfileScreen/policy/controller/policycontoller.dart';

class Policybinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Policycontoller>(
      Policycontoller(),
    );
  }
}
