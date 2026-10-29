
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/model/in_person_education_model.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Inpersoncontroller extends GetxController {
  final PageController carouselController = PageController();
  final RxInt currentCarouselIndex = 0.obs;
  final Rxn<InPersonEducationModel> education = Rxn<InPersonEducationModel>();
  final RxBool isLoadingEducation = false.obs;
  final RxString educationError = ''.obs;

  // Keep the API query inside this controller.
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
              ... on MediaImage {
                image {
                  url
                  altText
                }
              }
            }

            references(first: 20) {
              nodes {
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

  // Convenience getters for the view.
  InPersonEducationModel? get pageData => education.value;

  List<String> get carouselImages =>
      pageData?.images('carousel_images') ?? [];

  List<String> get galleryImages =>
      pageData?.images('gallery_images') ?? [];

  @override
  void onInit() {
    super.onInit();
    loadEducation();
  }

  // All In-Person Education fetching logic stays here.
  Future<void> loadEducation() async {
    isLoadingEducation.value = true;
    educationError.value = '';

    try {
      final data = await ShopifyCollectionService.query(
        getInPersonEducationQuery,
      );

      final metaobjects = data['metaobjects'];
      final nodes = metaobjects is Map
          ? metaobjects['nodes'] as List? ?? []
          : <dynamic>[];

      if (nodes.isEmpty || nodes.first is! Map) {
        education.value = null;
        educationError.value =
        'Education content was not found in Shopify.';
        return;
      }

      education.value = InPersonEducationModel.fromJson(
        Map<String, dynamic>.from(nodes.first as Map),
      );

      currentCarouselIndex.value = 0;

      debugPrint('[IN PERSON] Education loaded successfully');
      debugPrint('[IN PERSON] Gallery images: ${galleryImages.length}');
      debugPrint('[IN PERSON] Carousel images: ${carouselImages.length}');
    } catch (e, stackTrace) {
      educationError.value = 'Unable to load education content. Please try again.';
      debugPrint('[IN PERSON] Error loading education: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoadingEducation.value = false;
    }
  }

  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }

  @override
  void onClose() {
    carouselController.dispose();
    super.onClose();
  }
}
