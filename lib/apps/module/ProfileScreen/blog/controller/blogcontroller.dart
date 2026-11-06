import 'package:get/get.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Blogcontroller extends GetxController {
  final isLoading = false.obs;

  final blog = <String, String>{}.obs;

  static const String blogType = "blog_article";

  @override
  void onInit() {
    super.onInit();
    fetchBlogData();
  }

  Future<void> fetchBlogData() async {
    try {
      isLoading.value = true;

      final String query = '''
        query GetBlogArticles {
          metaobjects(type: "$blogType", first: 10) {
            nodes {
              id
              handle
              fields {
                key
                value
              }
            }
          }
        }
      ''';

      final response = await ShopifyCollectionService.query(query);

      print("========== BLOG API RESPONSE ==========");
      print(response);

      // Your service already returns the data object.
      final nodes = response['metaobjects']?['nodes'];

      if (nodes == null || nodes.isEmpty) {
        print("BLOG ERROR: No blog entries found");
        blog.clear();
        return;
      }

      // Get the first blog entry.
      final entry = nodes.first;

      print("BLOG HANDLE: ${entry['handle']}");

      final List fields = entry['fields'] ?? [];

      final Map<String, String> blogData = {};

      for (final field in fields) {
        final key = field['key']?.toString() ?? '';
        final value = field['value']?.toString() ?? '';

        blogData[key] = value;

        print("BLOG FIELD: $key = $value");
      }

      blog.assignAll(blogData);

      print("========== FINAL BLOG DATA ==========");
      print(blog);
      print("BLOG COUNT: ${blog.length}");

    } catch (e, stackTrace) {
      print("BLOG FETCH ERROR: $e");
      print(stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  String getBlogText(String key) {
    return blog[key] ?? '';
  }
}