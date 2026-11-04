
import 'dart:convert';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Aboutuscontroller extends GetxController {
  final RxMap<String, dynamic> aboutData = <String, dynamic>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      const String query = r'''
        query GetAboutUsPage {
          metaobjects(type: "about_us_page", first: 1) {
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
                  ... on GenericFile {
                    url
                  }
                }
              }
            }
          }
        }
      ''';
      final response = await ShopifyCollectionService.query(query);
      final metaobjects = response['metaobjects'];
      if (metaobjects == null || metaobjects['nodes'] == null || (metaobjects['nodes'] as List).isEmpty) {
        aboutData.clear();
        errorMessage.value = 'About Us content not found.';
        return;
      }
      final entry = metaobjects['nodes'][0];
      final List fields = entry['fields'] ?? [];
      final Map<String, dynamic> fetchedData = {};
      for (final field in fields) {
        final String key = field['key']?.toString() ?? '';
        if (key.isEmpty) continue;
        dynamic value = field['value'];
        final reference = field['reference'];
        if (reference != null) {
          final imageUrl = reference['image']?['url'];
          final fileUrl = reference['url'];
          if (imageUrl != null) {
            value = imageUrl;
          } else if (fileUrl != null) {
            value = fileUrl;
          }
        }

        if (value is String && value.trim().isNotEmpty) {
          final trimmedValue = value.trim();
          if (trimmedValue.startsWith('[') ||
              trimmedValue.startsWith('{')) {
            try {
              value = jsonDecode(trimmedValue);
            } catch (e) {
              print('JSON parsing error for $key: $e');
            }
          }
        }
        fetchedData[key] = value;
      }
      aboutData.assignAll(fetchedData);
      print('ABOUT US DATA FETCHED SUCCESSFULLY');
      print(aboutData);
    } catch (e, stackTrace) {
      errorMessage.value = 'Unable to load About Us content.';
      print('ABOUT US FETCH ERROR: $e');
      print(stackTrace);
    } finally {
      isLoading.value = false;
    }
  }
  String text(
      String key, {
        String fallback = '',
      }) {
    final value = aboutData[key];
    if (value == null || value.toString().trim().isEmpty) {
      return fallback;
    }
    return value.toString();
  }

  List<String> stringList(
      String key, {
        List<String> fallback = const [],
      }) {
    final value = aboutData[key];
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return fallback;
  }

  List<Map<String, dynamic>> objectList(
      String key, {
        List<Map<String, dynamic>> fallback = const [],
      }) {
    final value = aboutData[key];
    if (value is List) {
      return value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return fallback;
  }
}
