import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:share_plus/share_plus.dart';

class Wishlistcontroller extends GetxController {
  final GetStorage _storage = GetStorage();

  final RxList<Map<String, dynamic>> wishlists =
      <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> wishlistProducts =
      <Map<String, dynamic>>[].obs;

  final RxString activeWishlistId = ''.obs;

  static const String _storageKey = 'malia_wishlists';
  static const String _activeKey = 'malia_active_wishlist';

  @override
  void onInit() {
    super.onInit();
    _loadWishlists();
  }

  void _loadWishlists() {
    final saved = _storage.read<List>(_storageKey);

    if (saved != null) {
      wishlists.assignAll(
        saved.map(
              (item) => Map<String, dynamic>.from(item as Map),
        ),
      );
    }

    final savedActiveId = _storage.read<String>(_activeKey);

    if (wishlists.isEmpty) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();

      wishlists.add({
        'id': id,
        'name': 'My Wishlist',
        'products': <Map<String, dynamic>>[],
      });

      activeWishlistId.value = id;
    } else {
      final exists = wishlists.any(
            (item) => item['id'].toString() == savedActiveId,
      );

      activeWishlistId.value = exists
          ? savedActiveId!
          : wishlists.first['id'].toString();
    }

    _loadActiveProducts();
    _saveWishlists();
  }

  Map<String, dynamic>? get activeWishlist {
    for (final wishlist in wishlists) {
      if (wishlist['id'].toString() == activeWishlistId.value) {
        return wishlist;
      }
    }
    return null;
  }

  void _loadActiveProducts() {
    final wishlist = activeWishlist;
    final savedProducts = wishlist?['products'];

    wishlistProducts.assignAll(
      savedProducts is List
          ? savedProducts.map(
            (item) => Map<String, dynamic>.from(item as Map),
      )
          : <Map<String, dynamic>>[],
    );
  }

  void addProductToWishlist(
      String wishlistId,
      Map<String, dynamic> product,
      ) {
    final productId = product['id']?.toString() ?? '';

    if (productId.isEmpty) {
      AppSnackbar.error('Product ID is missing.');
      return;
    }

    final index = wishlists.indexWhere(
          (item) => item['id'].toString() == wishlistId,
    );

    if (index == -1) return;

    final rawProducts = wishlists[index]['products'];
    final products = rawProducts is List
        ? rawProducts
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList()
        : <Map<String, dynamic>>[];

    if (products.any(
          (item) => item['id']?.toString() == productId,
    )) {
      AppSnackbar.error('This product is already in this wishlist.',);
      return;
    }

    products.add(Map<String, dynamic>.from(product));
    wishlists[index]['products'] = products;

    if (activeWishlistId.value == wishlistId) {
      wishlistProducts.assignAll(products);
    }

    _saveWishlists();
    wishlists.refresh();
  }

  bool isProductInAnyWishlist(String productId) {
    return wishlists.any((wishlist) {
      final products = wishlist['products'];

      return products is List &&
          products.whereType<Map>().any(
                (item) => item['id']?.toString() == productId,
          );
    });
  }

  Future<void> shareWishlist() async {
    final wishlistId = activeWishlistId.value;
    final wishlist = wishlists.firstWhereOrNull((item) => item['id'].toString() == wishlistId,);
    if (wishlist == null) {
      AppSnackbar.error('Please select a wishlist first.');
      return;
    }
    final wishlistName = wishlist['name']?.toString() ?? 'My Wishlist';
    final savedProducts = wishlist['products'] as List? ?? [];
    if (savedProducts.isEmpty) {
      AppSnackbar.error('Add some products before sharing this wishlist.',);
      return;
    }
    final message = StringBuffer();
    message.writeln('My Malia Extensions Wishlist');
    message.writeln(wishlistName);
    message.writeln('');
    message.writeln(
      'Here are my ${savedProducts.length} favorite products:',
    );
    message.writeln('');
    for (var i = 0; i < savedProducts.length; i++) {
      final item = savedProducts[i];
      if (item is! Map) continue;
      final name = item['name']?.toString() ?? 'Product';
      final variant = item['variant']?.toString() ?? '';
      final price = item['price']?.toString() ?? '';
      final handle = item['handle']?.toString() ?? '';
      message.writeln('${i + 1}. $name');
      if (variant.isNotEmpty) {
        message.writeln('   Variant: $variant');
      }
      if (price.isNotEmpty) {
        message.writeln('   Price: $price');
      }
      if (handle.isNotEmpty) {
        message.writeln(
          '   https://maliaextensions.com/products/$handle',
        );
      }
      message.writeln('');
    }
    message.writeln('Explore more at https://maliaextensions.com');

    await SharePlus.instance.share(
      ShareParams(
        text: message.toString(),
        subject: '$wishlistName - Malia Extensions',
      ),
    );
  }

  bool isProductInWishlist(String wishlistId, String productId) {
    final index = wishlists.indexWhere(
          (wishlist) => wishlist['id'].toString() == wishlistId,
    );

    if (index == -1) return false;

    final products = wishlists[index]['products'] as List? ?? [];

    return products.any(
          (item) => (item as Map)['id']?.toString() == productId,
    );
  }


  void _saveWishlists() {
    for (final wishlist in wishlists) {
      if (wishlist['id'].toString() == activeWishlistId.value) {
        wishlist['products'] = wishlistProducts
            .map((product) => Map<String, dynamic>.from(product))
            .toList();
        break;
      }
    }

    _storage.write(_storageKey, wishlists.toList());
    _storage.write(_activeKey, activeWishlistId.value);
  }

  void createWishlist(String name) {
    final cleanName = name.trim();

    if (cleanName.isEmpty) return;

    // Preserve the current list before switching.
    _saveWishlists();

    final id = DateTime.now().microsecondsSinceEpoch.toString();

    wishlists.add({
      'id': id,
      'name': cleanName,
      'products': <Map<String, dynamic>>[],
    });

    activeWishlistId.value = id;
    wishlistProducts.clear();

    _saveWishlists();
    wishlists.refresh();
  }

  void selectWishlist(String id) {
    if (activeWishlistId.value == id) return;

    _saveWishlists();

    activeWishlistId.value = id;
    _loadActiveProducts();

    _saveWishlists();
  }

  void addToWishlist(Map<String, dynamic> product) {
    final productId = product['id']?.toString();

    if (productId == null || productId.isEmpty) return;

    final alreadyExists = wishlistProducts.any(
          (item) => item['id']?.toString() == productId,
    );

    if (alreadyExists) return;

    wishlistProducts.add(Map<String, dynamic>.from(product));
    _saveWishlists();
  }

  void removeFromWishlist(String productId) {
    wishlistProducts.removeWhere(
          (item) => item['id']?.toString() == productId,
    );

    _saveWishlists();
  }

  bool isWishlisted(String productId) {
    return wishlistProducts.any(
          (item) => item['id']?.toString() == productId,
    );
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final productId = product['id']?.toString();

    if (productId == null || productId.isEmpty) return;

    if (isWishlisted(productId)) {
      removeFromWishlist(productId);
    } else {
      addToWishlist(product);
    }
  }

  void deleteWishlist(String id) {
    if (wishlists.length <= 1) {
      AppSnackbar.error('Keep at least one wishlist.',);
      return;
    }

    wishlists.removeWhere(
          (item) => item['id'].toString() == id,
    );

    if (activeWishlistId.value == id) {
      activeWishlistId.value = wishlists.first['id'].toString();
      _loadActiveProducts();
    }

    _saveWishlists();
    wishlists.refresh();
  }

  void renameWishlist(String id, String newName) {
    final cleanName = newName.trim();

    if (cleanName.isEmpty) return;

    final index = wishlists.indexWhere(
          (item) => item['id'].toString() == id,
    );

    if (index == -1) return;

    wishlists[index]['name'] = cleanName;
    _saveWishlists();
    wishlists.refresh();
  }
}
