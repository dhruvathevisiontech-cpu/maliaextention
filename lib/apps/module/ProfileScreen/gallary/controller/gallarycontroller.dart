
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Gallarycontroller extends GetxController {
  final RxList<String> galleryImages = <String>[].obs;

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGalleryImages();
  }

  Future<void> fetchGalleryImages() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<String> images = await ShopifyCollectionService.getGalleryImages();
      galleryImages.assignAll(images);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
