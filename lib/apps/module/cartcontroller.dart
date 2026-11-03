import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';

class Cartcontroller extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> recommendedProducts = <Map<String, dynamic>>[].obs;
  final RxBool isLoadingRecommendations = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxString cartError = ''.obs;
  final RxString checkoutUrl = ''.obs;
  double _subtotal = 0;
  double _total = 0;
  String _currencyCode = 'USD';
  double get subtotal => _subtotal;
  double get total => _total;
  String get currencyCode => _currencyCode;
  int get totalQuantity => cartItems.fold<int>(0, (sum, item) => sum + ((item['quantity'] as num?)?.toInt() ?? 0));
  String get _cartId => _storage.read<String>('malia_shopify_cart_id') ?? '';

  static const String _createCartMutation = r'''
    mutation CreateCart($input: CartInput!) {
      cartCreate(input: $input) {
        cart {
          id
          checkoutUrl
        }
        userErrors {
          field
          message
        }
      }
    }
  ''';

  static const String _addLinesMutation = r'''
    mutation AddCartLines(
      $cartId: ID!,
      $lines: [CartLineInput!]!
    ) {
      cartLinesAdd(cartId: $cartId, lines: $lines) {
        cart {
          id
        }
        userErrors {
          field
          message
        }
      }
    }
  ''';

  static const String _updateLinesMutation = r'''
    mutation UpdateCartLines(
      $cartId: ID!,
      $lines: [CartLineUpdateInput!]!
    ) {
      cartLinesUpdate(cartId: $cartId, lines: $lines) {
        cart {
          id
        }
        userErrors {
          field
          message
        }
      }
    }
  ''';

  static const String _removeLinesMutation = r'''
    mutation RemoveCartLines(
      $cartId: ID!,
      $lineIds: [ID!]!
    ) {
      cartLinesRemove(cartId: $cartId, lineIds: $lineIds) {
        cart {
          id
        }
        userErrors {
          field
          message
        }
      }
    }
  ''';

  static const String _cartQuery = r'''
    query GetCart($cartId: ID!) {
      cart(id: $cartId) {
        id
        checkoutUrl
        totalQuantity
        cost {
          subtotalAmount {
            amount
            currencyCode
          }
          totalAmount {
            amount
            currencyCode
          }
        }
        lines(first: 100) {
          nodes {
            id
            quantity
            attributes {
              key
              value
            }
            merchandise {
              ... on ProductVariant {
                id
                title
                availableForSale
                price {
                  amount
                  currencyCode
                }
                selectedOptions {
                  name
                  value
                }
                product {
                  id
                  title
                  handle
                  featuredImage {
                    url
                    altText
                  }
                }
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
  ''';

  static const String _cartRecommendationsQuery = r'''
  query GetProductRecommendations($productId: ID!) {
    productRecommendations(productId: $productId) {
      id
      title
      handle
      availableForSale
      featuredImage {
        url
        altText
      }
      priceRange {
        minVariantPrice {
          amount
          currencyCode
        }
      }
      variants(first: 10) {
        nodes {
          id
          availableForSale
          price {
            amount
            currencyCode
          }
        }
      }
    }
  }
''';



  Future<void> fetchCartRecommendations() async {
    isLoadingRecommendations.value = true;
    try {
      if (cartItems.isEmpty) {
        await fetchFallbackRecommendations();
        return;
      }
      final cartProductIds = cartItems
          .map((item) => item['id']?.toString() ?? '')
          .where((id) => id.isNotEmpty)
          .toSet();
      final results = <Map<String, dynamic>>[];
      final seenIds = <String>{...cartProductIds};
      for (final cartItem in cartItems.toList()) {
        final productId = cartItem['id']?.toString() ?? '';
        if (productId.isEmpty) continue;
        try {
          final response = await ShopifyCollectionService.query(
            _cartRecommendationsQuery,
            variables: {'productId': productId},
          );
          final rawProducts = response['productRecommendations'] as List? ?? [];
          for (final rawProduct in rawProducts) {
            if (rawProduct is! Map) continue;

            final product = Map<String, dynamic>.from(rawProduct);
            final id = product['id']?.toString() ?? '';

            if (id.isEmpty || seenIds.contains(id)) continue;
            if (product['availableForSale'] != true) continue;

            final variantsData = product['variants'] as Map? ?? {};
            final variants = variantsData['nodes'] as List? ?? [];

            Map<String, dynamic>? availableVariant;

            for (final rawVariant in variants) {
              if (rawVariant is! Map) continue;

              final variant = Map<String, dynamic>.from(rawVariant);

              if (variant['availableForSale'] == true) {
                availableVariant = variant;
                break;
              }
            }

            if (availableVariant == null) continue;

            final variantPrice =
                availableVariant['price'] as Map? ?? {};

            final priceRange = product['priceRange'] as Map? ?? {};
            final minimumPrice =
                priceRange['minVariantPrice'] as Map? ?? {};
            final image = product['featuredImage'] as Map? ?? {};

            results.add({
              'id': id,
              'name': product['title']?.toString() ?? '',
              'title': product['title']?.toString() ?? '',
              'handle': product['handle']?.toString() ?? '',
              'image': image['url']?.toString() ?? '',
              'variantId':
              availableVariant['id']?.toString() ?? '',
              'price': variantPrice['amount']?.toString() ??
                  minimumPrice['amount']?.toString() ??
                  '0.00',
              'currencyCode':
              variantPrice['currencyCode']?.toString() ??
                  minimumPrice['currencyCode']?.toString() ??
                  _currencyCode,
            });

            seenIds.add(id);

            if (results.length >= 10) break;
          }
        } catch (e, stackTrace) {
        }

        if (results.length >= 10) break;
      }

      if (results.isNotEmpty) {
        recommendedProducts.assignAll(results.take(10).toList());
      } else {
        await fetchFallbackRecommendations();
      }
    } catch (e, stackTrace) {
      await fetchFallbackRecommendations();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }


  String _errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }

  void _checkUserErrors(dynamic result, String operation) {
    if (result is! Map) {
      throw Exception('$operation returned an invalid Shopify response.');
    }

    final errors = result['userErrors'] as List? ?? [];

    if (errors.isNotEmpty) {
      for (final error in errors) {
        if (error is Map) {
        }
      }
      final messages = errors
          .whereType<Map>()
          .map((e) => e['message']?.toString() ?? '')
          .where((e) => e.isNotEmpty)
          .join(', ');

      throw Exception(
        messages.isEmpty ? '$operation failed.' : messages,
      );
    }
  }

  Future<void> _saveCartId(String id) async {
    await _storage.write('malia_shopify_cart_id', id);
  }

  Future<void> _clearCartId() async {
    await _storage.remove('malia_shopify_cart_id');
  }


  List<Map<String, String>> _buildAttributes({
    required String shade,
    required String length,
    required String hairType,
  }) {
    final attributes = <Map<String, String>>[];
    if (shade.isNotEmpty) {
      attributes.add({'key': 'Shade', 'value': shade});
    }
    if (length.isNotEmpty) {
      attributes.add({'key': 'Length', 'value': length});
    }
    if (hairType.isNotEmpty) {
      attributes.add({'key': 'Hair Type', 'value': hairType});
    }
    return attributes;
  }


  Future<void> _createCart({
    required String variantId,
    required int quantity,
    required List<Map<String, String>> attributes,
  }) async {
    final response = await ShopifyCollectionService.query(
      _createCartMutation,
      variables: {
        'input': {
          'lines': [
            {
              'merchandiseId': variantId,
              'quantity': quantity,
              'attributes': attributes,
            }
          ],
        },
      },
    );
    final result = response['cartCreate'];
    _checkUserErrors(result, 'Create cart');
    final cart = result['cart'];
    if (cart is! Map || cart['id'] == null) {
      throw Exception('Shopify did not return a cart ID.');
    }
    final newCartId = cart['id'].toString();
    await _saveCartId(newCartId);
  }

  Future<void> addToCart({
    required Map<String, dynamic> product,
    required String shade,
    required String length,
    required String hairType,
    required int quantity,
    required String variantId,
    required String variantPrice,
    required String currencyCode,
  }) async {
    if (variantId.isEmpty) {
      AppSnackbar.error('Shopify variant ID is missing.');
      return;
    }

    if (quantity < 1) {
      AppSnackbar.error('Select a valid quantity.');
      return;
    }

    if (isUpdating.value) {
      return;
    }

    isUpdating.value = true;
    cartError.value = '';

    try {
      final attributes = _buildAttributes(
        shade: shade,
        length: length,
        hairType: hairType,
      );

      if (_cartId.isEmpty) {
        await _createCart(
          variantId: variantId,
          quantity: quantity,
          attributes: attributes,
        );
      } else {
        final response = await ShopifyCollectionService.query(
          _addLinesMutation,
          variables: {
            'cartId': _cartId,
            'lines': [
              {
                'merchandiseId': variantId,
                'quantity': quantity,
                'attributes': attributes,
              }
            ],
          },
        );

        _checkUserErrors(
          response['cartLinesAdd'],
          'Add product to cart',
        );
      }

      await loadCart(showLoader: false);

      AppSnackbar.success('Added to Cart ${product['name'] ?? product['title'] ?? 'Product'} added successfully.');
    } catch (e, stackTrace) {
      cartError.value = _errorMessage(e);
      AppSnackbar.error('Unable to Add Item ${cartError.value}');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void>  loadCart({bool showLoader = true}) async {
    final cartId = _cartId;
    if (cartId.isEmpty) {
      cartItems.clear();
      recommendedProducts.clear();
      isLoadingRecommendations.value = false;
      checkoutUrl.value = '';
      _subtotal = 0;
      _total = 0;
      _currencyCode = 'USD';
      return;
    }
    if (showLoader) isLoading.value = true;
    cartError.value = '';

    try {
      final response = await ShopifyCollectionService.query(
        _cartQuery,
        variables: {'cartId': cartId},
      );
      final rawCart = response['cart'];
      if (rawCart is! Map) {
        await _clearCartId();
        cartItems.clear();
        checkoutUrl.value = '';
        _subtotal = 0;
        _total = 0;
        _currencyCode = 'USD';

        return;
      }
      final cart = Map<String, dynamic>.from(rawCart);
      checkoutUrl.value = cart['checkoutUrl']?.toString() ?? '';
      final cost = cart['cost'] as Map? ?? {};
      final subtotalData = cost['subtotalAmount'] as Map? ?? {};
      final totalData = cost['totalAmount'] as Map? ?? {};
      _subtotal = double.tryParse(
        subtotalData['amount']?.toString() ?? '',
      ) ??
          0;
      _total = double.tryParse(
        totalData['amount']?.toString() ?? '',
      ) ??
          0;
      _currencyCode = totalData['currencyCode']?.toString() ?? 'USD';
      final lines = cart['lines'] as Map? ?? {};
      final nodes = lines['nodes'] as List? ?? [];
      final parsedItems = <Map<String, dynamic>>[];
      for (final rawLine in nodes) {
        if (rawLine is! Map) {
          continue;
        }
        final line = Map<String, dynamic>.from(rawLine);
        final rawMerchandise = line['merchandise'];
        if (rawMerchandise is! Map) {
          continue;
        }
        final variant = Map<String, dynamic>.from(rawMerchandise);
        final rawProduct = variant['product'];
        final product = rawProduct is Map
            ? Map<String, dynamic>.from(rawProduct)
            : <String, dynamic>{};
        final variantImage = variant['image'] as Map? ?? {};
        final featuredImage = product['featuredImage'] as Map? ?? {};
        final variantImageUrl = variantImage['url']?.toString().trim() ?? '';
        final featuredImageUrl = featuredImage['url']?.toString().trim() ?? '';
        final imageUrl = variantImageUrl.isNotEmpty ? variantImageUrl : featuredImageUrl;
        final attributes = <String, String>{};
        final rawAttributes = line['attributes'] as List? ?? [];
        for (final attribute in rawAttributes) {
          if (attribute is! Map) continue;
          final key = attribute['key']?.toString() ?? '';
          final value = attribute['value']?.toString() ?? '';
          if (key.isNotEmpty) attributes[key] = value;
        }
        final price = variant['price'] as Map? ?? {};
        final item = <String, dynamic>{
          'lineId': line['id']?.toString() ?? '',
          'id': product['id']?.toString() ?? '',
          'name': product['title']?.toString() ?? '',
          'title': product['title']?.toString() ?? '',
          'handle': product['handle']?.toString() ?? '',
          'image': imageUrl,
          'variantId': variant['id']?.toString() ?? '',
          'variantTitle': variant['title']?.toString() ?? '',
          'price': price['amount']?.toString() ?? '0',
          'currencyCode': price['currencyCode']?.toString() ?? _currencyCode,
          'quantity': (line['quantity'] as num?)?.toInt() ?? 1,
          'availableForSale': variant['availableForSale'] == true,
          'selectedOptions': variant['selectedOptions'] ?? [],
          'shade': attributes['Shade'] ?? '',
          'length': attributes['Length'] ?? '',
          'hairType': attributes['Hair Type'] ?? '',
          'attributes': attributes,
        };
        parsedItems.add(item);
      }
      cartItems.assignAll(parsedItems);
      await fetchCartRecommendations();
    } catch (e, stackTrace) {
      cartError.value = _errorMessage(e);
    } finally {
      if (showLoader) isLoading.value = false;
    }
  }

  Future<void> addRecommendedProduct(
      Map<String, dynamic> item,
      ) async {
    final variantId = item['variantId']?.toString() ?? '';

    if (variantId.isEmpty) {
      AppSnackbar.error('No available Shopify variant was found.');
      return;
    }

    await addToCart(
      product: item,
      shade: '',
      length: '',
      hairType: '',
      quantity: 1,
      variantId: variantId,
      variantPrice: item['price']?.toString() ?? '0',
      currencyCode:
      item['currencyCode']?.toString() ?? _currencyCode,
    );
  }

  Future<void> _updateQuantity(int index, int newQuantity) async {
    if (index < 0 || index >= cartItems.length) {
      return;
    }
    if (isUpdating.value) {
      return;
    }
    final lineId = cartItems[index]['lineId']?.toString() ?? '';
    final itemName = cartItems[index]['name']?.toString() ?? 'Unknown';
    if (lineId.isEmpty) {
      AppSnackbar.error('Shopify cart line ID is missing.');
      return;
    }
    isUpdating.value = true;
    try {
      if (newQuantity < 1) {
        await _removeLine(lineId);
        return;
      }
      final response = await ShopifyCollectionService.query(
        _updateLinesMutation,
        variables: {
          'cartId': _cartId,
          'lines': [
            {
              'id': lineId,
              'quantity': newQuantity,
            }
          ],
        },
      );
      _checkUserErrors(
        response['cartLinesUpdate'],
        'Update cart quantity',
      );
      await loadCart(showLoader: false);
    } catch (e, stackTrace) {
      AppSnackbar.error(_errorMessage(e));
    } finally {
      isUpdating.value = false;
    }
  }
  Future<void> increaseQuantity(int index) async {
    if (index < 0 || index >= cartItems.length) {
      return;
    }
    final current = (cartItems[index]['quantity'] as num?)?.toInt() ?? 1;
    await _updateQuantity(index, current + 1);
  }
  Future<void> decreaseQuantity(int index) async {
    if (index < 0 || index >= cartItems.length) {
      return;
    }
    final current = (cartItems[index]['quantity'] as num?)?.toInt() ?? 1;
    if (current > 1) {
      await _updateQuantity(index, current - 1);
    } else {
    }
  }

  Future<void> _removeLine(String lineId) async {
    if (_cartId.isEmpty) {
      throw Exception('Cannot remove item: Shopify cart ID is missing.');
    }
    final response = await ShopifyCollectionService.query(
      _removeLinesMutation,
      variables: {
        'cartId': _cartId,
        'lineIds': [lineId],
      },
    );
    _checkUserErrors(
      response['cartLinesRemove'],
      'Remove cart item',
    );
    await loadCart(showLoader: false);
  }
  Future<void> removeFromCart(int index) async {
    if (index < 0 || index >= cartItems.length) return;
    if (isUpdating.value) return;
    final removedItem = Map<String, dynamic>.from(cartItems[index]);
    final lineId = removedItem['lineId']?.toString() ?? '';
    final itemName = removedItem['name']?.toString() ?? 'Item';
    if (lineId.isEmpty || _cartId.isEmpty) {
      AppSnackbar.error('Unable to remove this item.');
      return;
    }
    isUpdating.value = true;
    try {
      final response = await ShopifyCollectionService.query(
        _removeLinesMutation,
        variables: {
          'cartId': _cartId,
          'lineIds': [lineId],
        },
      );
      _checkUserErrors(
        response['cartLinesRemove'],
        'Remove cart item',
      );
      await loadCart(showLoader: false);
    } catch (e, stackTrace) {
      AppSnackbar.error(
        _errorMessage(e),
      );
    } finally {
      isUpdating.value = false;
    }
  }
  static const String _fallbackRecommendationsQuery = r'''
  query GetFallbackRecommendations {
    products(first: 10) {
      nodes {
        id
        title
        handle
        availableForSale
        featuredImage {
          url
          altText
        }
        priceRange {
          minVariantPrice {
            amount
            currencyCode
          }
        }
        variants(first: 10) {
          nodes {
            id
            availableForSale
            price {
              amount
              currencyCode
            }
          }
        }
      }
    }
  }
''';


  Future<void> fetchFallbackRecommendations() async {
    isLoadingRecommendations.value = true;
    try {
      final response = await ShopifyCollectionService.query(
        _fallbackRecommendationsQuery,
        variables: {},
      );
      final productsData = response['products'] as Map? ?? {};
      final nodes = productsData['nodes'] as List? ?? [];
      final cartProductIds = cartItems
          .map((item) => item['id']?.toString() ?? '')
          .where((id) => id.isNotEmpty)
          .toSet();
      final results = <Map<String, dynamic>>[];
      final seenIds = <String>{...cartProductIds};
      for (final item in nodes) {
        if (item is! Map) continue;
        final product = Map<String, dynamic>.from(item);
        final id = product['id']?.toString() ?? '';
        if (id.isEmpty || seenIds.contains(id)) continue;
        if (product['availableForSale'] != true) continue;
        final variantsData = product['variants'] as Map? ?? {};
        final variants = variantsData['nodes'] as List? ?? [];
        Map<String, dynamic>? availableVariant;
        for (final rawVariant in variants) {
          if (rawVariant is! Map) continue;
          final variant = Map<String, dynamic>.from(rawVariant);
          if (variant['availableForSale'] == true) {
            availableVariant = variant;
            break;
          }
        }
        if (availableVariant == null) continue;
        final imageData = product['featuredImage'] as Map? ?? {};
        final priceRange = product['priceRange'] as Map? ?? {};
        final minimumPrice = priceRange['minVariantPrice'] as Map? ?? {};
        final variantPrice = availableVariant['price'] as Map? ?? {};
        results.add({
          'id': id,
          'name': product['title']?.toString() ?? '',
          'title': product['title']?.toString() ?? '',
          'handle': product['handle']?.toString() ?? '',
          'image': imageData['url']?.toString() ?? '',
          'variantId': availableVariant['id']?.toString() ?? '',
          'price': variantPrice['amount']?.toString() ?? minimumPrice['amount']?.toString() ?? '0.00',
          'currencyCode': variantPrice['currencyCode']?.toString() ?? minimumPrice['currencyCode']?.toString() ?? _currencyCode,
        });
        seenIds.add(id);
        if (results.length >= 10) break;
      }
      recommendedProducts.assignAll(results);
      if (results.isEmpty) {
      }
    } catch (e, stackTrace) {
      recommendedProducts.clear();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }
}
