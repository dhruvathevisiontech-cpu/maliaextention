
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Educationfaqcontroller extends GetxController {
  // Online Education FAQs
  final RxList<Map<String, String>> faqList =
      <Map<String, String>>[].obs;

  // In-Person Education FAQs
  final RxList<Map<String, String>> faqList1 =
      <Map<String, String>>[].obs;

  // Search
  final RxString searchQuery = ''.obs;

  // Separate expanded indexes
  final RxInt onlineExpandedIndex = (-1).obs;
  final RxInt inPersonExpandedIndex = (-1).obs;

  // Loading and error
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEducationFaqs();
  }

  // FETCH FAQ DATA FROM SHOPIFY
  Future<void> fetchEducationFaqs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      const String query = r'''
        query GetEducationFaqs {
          metaobjects(type: "education_faq", first: 50) {
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

      // Shopify API call
      final result = await ShopifyCollectionService.query(query);

      // Get all entries
      final List<dynamic> nodes =
          result['metaobjects']?['nodes'] ?? [];

      final List<Map<String, String>> onlineList = [];
      final List<Map<String, String>> inPersonList = [];

      // Loop through entries
      for (final node in nodes) {
        final Map<String, dynamic> fields = {};

        for (final field in node['fields'] ?? []) {
          final String key =
              field['key']?.toString() ?? '';

          final String value =
              field['value']?.toString() ?? '';

          if (key.isNotEmpty) {
            fields[key] = value;
          }
        }

        // Extract Shopify values
        final String question =
            fields['question']?.trim() ?? '';

        final String answer =
            fields['answer']?.trim() ?? '';

        final String category =
            fields['category']?.trim().toLowerCase() ?? '';

        final String sortOrder =
            fields['sort_order'] ?? '999';

        // Ignore incomplete entries
        if (question.isEmpty || answer.isEmpty) {
          continue;
        }

        final Map<String, String> faq = {
          'question': question,
          'answer': answer,
          'category': category,
          'sort_order': sortOrder,
        };

        // Separate categories
        if (category == 'online education') {
          onlineList.add(faq);
        } else if (category == 'in-person education') {
          inPersonList.add(faq);
        }
      }

      // Sort FAQ entries
      int compareFaq(
          Map<String, String> a,
          Map<String, String> b,
          ) {
        final int aOrder =
            int.tryParse(a['sort_order'] ?? '') ?? 999;

        final int bOrder =
            int.tryParse(b['sort_order'] ?? '') ?? 999;

        return aOrder.compareTo(bOrder);
      }
      onlineList.sort(compareFaq);
      inPersonList.sort(compareFaq);
      faqList.assignAll(onlineList);
      faqList1.assignAll(inPersonList);
    } catch (e, stackTrace) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // ONLINE FAQ SEARCH
  List<Map<String, String>> get filteredOnlineFaqs {
    return _filterFaqs(faqList);
  }

  // IN-PERSON FAQ SEARCH
  List<Map<String, String>> get filteredInPersonFaqs {
    return _filterFaqs(faqList1);
  }

  // COMMON SEARCH FUNCTION
  List<Map<String, String>> _filterFaqs(
      List<Map<String, String>> faqs,
      ) {
    final String query =
    searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      return faqs.toList();
    }

    return faqs.where((faq) {
      final String question =
          faq['question']?.toLowerCase() ?? '';

      final String answer =
          faq['answer']?.toLowerCase() ?? '';

      return question.contains(query) ||
          answer.contains(query);
    }).toList();
  }

  // UPDATE SEARCH
  void updateSearch(String value) {
    searchQuery.value = value.trim().toLowerCase();

    onlineExpandedIndex.value = -1;
    inPersonExpandedIndex.value = -1;
  }

  // REFRESH DATA
  Future<void> refreshFaqs() async {
    onlineExpandedIndex.value = -1;
    inPersonExpandedIndex.value = -1;

    await fetchEducationFaqs();
  }
}
