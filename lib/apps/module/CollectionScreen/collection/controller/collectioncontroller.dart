import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Collectioncontroller extends GetxController {
  final RxInt selectedCollection = (-1).obs;
  final RxList<Map<String, dynamic>> collections = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCollections();
  }
  Future<void> fetchCollections() async {
    final stopwatch = Stopwatch()..start();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      const String query = r'''
      query GetCollections {
        collections(first: 50, sortKey: TITLE) {
          nodes {
            id
            title
            handle
            description
            image {
              url
              altText
              width
              height
            }
          }
        }
      }
    ''';
      final data = await ShopifyCollectionService.queryTokenless(query);
      final collectionData = data['collections'];
      if (collectionData == null) {
        throw Exception('Shopify did not return collection data.');
      }
      final List nodes = collectionData['nodes'] as List? ?? [];
      final List<Map<String, dynamic>> result = [];
      for (final item in nodes) {
        final node = Map<String, dynamic>.from(item as Map);
        final image = node['image'] is Map ? Map<String, dynamic>.from(node['image'] as Map) : <String, dynamic>{};
        final String id = node['id']?.toString() ?? '';
        final String title = node['title']?.toString() ?? '';
        final String handle = node['handle']?.toString() ?? '';
        if (id.isEmpty || title.isEmpty || handle.isEmpty) {
          continue;
        }
        result.add({
          'id': id,
          'collectionId': id,
          'title': title,
          'collectionTitle': title,
          'handle': handle,
          'collectionHandle': handle,
          'description': node['description'] ?? '',
          'imageUrl': image['url']?.toString() ?? '',
          'imageAltText': image['altText']?.toString() ?? '',
          'imageWidth': image['width'],
          'imageHeight': image['height'],
          'sortOrder': result.length,
        });
      }
      collections.assignAll(result);
    } catch (e, stackTrace) {
      errorMessage.value = e.toString();
    } finally {
      stopwatch.stop();
      const minimumShimmerDuration = Duration(milliseconds: 1200);
      final remainingTime = minimumShimmerDuration - stopwatch.elapsed;
      if (remainingTime > Duration.zero) {
        await Future.delayed(remainingTime);
      }
      isLoading.value = false;
    }
  }
}