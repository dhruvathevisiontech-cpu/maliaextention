import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Privacypolicycontroller extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString policyTitle = ''.obs;
  final RxString policyBody = ''.obs;
  final RxString policyUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      const query = '''
        query GetPrivacyPolicy {
          shop {
            privacyPolicy {
              title
              body
              url
            }
          }
        }
      ''';
      final response = await ShopifyCollectionService.query(query);
      final policy = response['shop']?['privacyPolicy'];
      if (policy == null) {
        errorMessage.value = 'Privacy policy not found in Shopify.';
        return;
      }
      policyTitle.value = policy['title']?.toString() ?? 'Privacy Policy';
      policyBody.value = policy['body']?.toString() ?? '';
      policyUrl.value = policy['url']?.toString() ?? '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
