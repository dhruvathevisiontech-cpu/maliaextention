import 'package:get/get.dart';
import 'package:maliaextention/apps/module/HomemainScreen/search/controller/searchcontroller.dart';


class Searchbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Searchdatacontroller>(
      Searchdatacontroller(),
    );
  }
}
