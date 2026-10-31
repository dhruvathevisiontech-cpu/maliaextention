
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Inpersoncontroller extends GetxController {
  final RxMap<String, dynamic> education = <String, dynamic>{}.obs;

  final RxBool isLoadingEducation = false.obs;
  final RxString educationError = ''.obs;
  final RxList<String> galleryImages = <String>[].obs;
  final RxList<String> carouselImages = <String>[].obs;

  final PageController carouselController = PageController();

  final RxInt currentCarouselIndex = 0.obs;

  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }
  static const String getInPersonEducationQuery = r'''
  query GetInPersonEducation {
    metaobjects(type: "in_person_education", first: 1) {
      nodes {
        id
        handle
        fields {
          key
          value

          reference {
            __typename
            ... on MediaImage {
              image {
                url
                altText
              }
            }
          }

          references(first: 20) {
            nodes {
              __typename
              ... on MediaImage {
                image {
                  url
                  altText
                }
              }
            }
          }
        }
      }
    }
  }
''';


  Future<void> loadEducation() async {
    isLoadingEducation.value = true;
    educationError.value = '';

    try {
      final response = await ShopifyCollectionService.query(
        getInPersonEducationQuery,
      );

      final nodes = response['metaobjects']?['nodes'] as List? ?? [];

      if (nodes.isNotEmpty) {
        final fields = nodes.first['fields'] as List? ?? [];

        education.clear();
        galleryImages.clear();
        carouselImages.clear();

        for (final field in fields) {
          final key = field['key']?.toString();

          if (key == null) continue;

          final value = field['value']?.toString() ?? '';

          // Carousel images
          if (key == 'carousel_images1') {
            final references = field['references'];

            if (references is Map) {
              final imageNodes = references['nodes'] as List? ?? [];

              carouselImages.assignAll(
                imageNodes
                    .where((node) => node is Map && node['image'] is Map)
                    .map((node) => node['image']['url']?.toString() ?? '')
                    .where((url) => url.startsWith('https://')),
              );
            }
          }

          // Gallery images
          else if (key == 'gallery_images1') {
            final references = field['references'];

            if (references is Map) {
              final imageNodes = references['nodes'] as List? ?? [];

              galleryImages.assignAll(
                imageNodes
                    .where((node) => node is Map && node['image'] is Map)
                    .map((node) => node['image']['url']?.toString() ?? '')
                    .where((url) => url.startsWith('https://')),
              );
            }
          }

          // Single image and normal text fields
          else {
            final reference = field['reference'];

            if (reference is Map) {
              final image = reference['image'];

              if (image is Map && image['url'] != null) {
                education[key] = image['url'];
              } else {
                education[key] = value;
              }
            } else {
              education[key] = value;
            }
          }

          print('FIELD: $key');
          print('VALUE: $value');
        }

        print('Education Data: $education');
        print('Carousel Images: $carouselImages');
        print('Gallery Images: $galleryImages');
      } else {
        education.clear();
        galleryImages.clear();
        carouselImages.clear();
        educationError.value = 'No education data found.';
      }
    } catch (e) {
      educationError.value = e.toString();
      print('Education Error: $e');
    } finally {
      isLoadingEducation.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    loadEducation();
  }
}
