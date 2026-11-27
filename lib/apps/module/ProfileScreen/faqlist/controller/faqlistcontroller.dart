
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Faqlistcontroller extends GetxController {
  final RxList<Map<String, String>> faqList =
      <Map<String, String>>[].obs;

  final RxInt expandedIndex = (-1).obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      const String query = r'''
        query GetGeneralFaqs {
          metaobjects(type: "faq", first: 50) {
            nodes {
              id
              fields {
                key
                value
              }
            }
          }
        }
      ''';

      final result = await ShopifyCollectionService.query(query);

      final List<dynamic> nodes =
          result['metaobjects']?['nodes'] ?? [];

      final List<Map<String, String>> tempList = [];

      for (final node in nodes) {
        final Map<String, String> fields = {};

        for (final field in (node['fields'] as List? ?? [])) {
          final key = field['key']?.toString() ?? '';
          final value = field['value']?.toString() ?? '';

          fields[key] = value;
        }

        final question = fields['question']?.trim() ?? '';
        final answer = fields['answer']?.trim() ?? '';
        final category =
            fields['category']?.trim().toLowerCase() ?? '';

        if (category != 'general questions') continue;
        if (question.isEmpty || answer.isEmpty) continue;

        tempList.add({
          'question': question,
          'answer': answer,
          'sort_order': fields['sort_order'] ?? '0',
        });
      }

      // Sort by Shopify sort_order
      tempList.sort((a, b) {
        final orderA = int.tryParse(a['sort_order'] ?? '0') ?? 0;
        final orderB = int.tryParse(b['sort_order'] ?? '0') ?? 0;
        return orderA.compareTo(orderB);
      });

      faqList.assignAll(
        tempList.map((faq) => {
          'question': faq['question'] ?? '',
          'answer': faq['answer'] ?? '',
        }),
      );
      expandedIndex.value = -1;
    } catch (e, stackTrace) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, String>> get filteredFaqs {
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) return faqList.toList();

    return faqList.where((faq) {
      return (faq['question'] ?? '').toLowerCase().contains(query) ||
          (faq['answer'] ?? '').toLowerCase().contains(query);
    }).toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
    expandedIndex.value = -1;
  }

  Future<void> refreshFaqs() async {
    expandedIndex.value = -1;
    await fetchFaqs();
  }
}
