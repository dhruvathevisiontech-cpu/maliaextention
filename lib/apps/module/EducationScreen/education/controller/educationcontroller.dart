
import 'dart:convert';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Educationcontroller extends GetxController {
  final RxMap<String, dynamic> education = <String, dynamic>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEducationPage();
  }

  Future<void> fetchEducationPage() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      const String query = r'''
        query GetEducationPage {
          metaobjects(type: "education_page", first: 1) {
            nodes {
              id
              handle
              fields {
                key
                value
                reference {
                  ... on MediaImage {
                    image {
                      url
                    }
                  }
                }
              }
            }
          }
        }
      ''';

      final data = await ShopifyCollectionService.query(query);

      final List<dynamic> nodes =
          data['metaobjects']?['nodes'] ?? [];

      if (nodes.isEmpty) {
        throw Exception('No education_page entry found.');
      }

      final List<dynamic> fields = nodes.first['fields'] ?? [];

      final Map<String, dynamic> result = {};

      for (final field in fields) {
        final String key = field['key'];

        final String? imageUrl =
        field['reference']?['image']?['url'];

        result[key] = imageUrl ?? field['value'];
      }

      // Decode JSON fields
      const jsonFields = [
        'benefits',
        'in_person_bullets',
        'online_bullets',
        'founder_benefits',
        'pro_benefits',
      ];

      for (final key in jsonFields) {
        final value = result[key];

        if (value is String && value.isNotEmpty) {
          try {
            result[key] = jsonDecode(value);
          } catch (e) {
            print('[EDUCATION JSON ERROR] $key: $e');
          }
        }
      }

      education.assignAll(result);

      print('[EDUCATION DATA] $education');
    } catch (e) {
      errorMessage.value = e.toString();
      print('[EDUCATION FETCH ERROR] $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get text
  String getText(String key, {String fallback = ''}) {
    return education[key]?.toString() ?? fallback;
  }

  // Get image URL
  String getImage(String key) {
    return education[key]?.toString() ?? '';
  }

  // Get JSON/list data
  List<dynamic> getList(String key) {
    final value = education[key];

    if (value is List) {
      return value;
    }

    return [];
  }
}
