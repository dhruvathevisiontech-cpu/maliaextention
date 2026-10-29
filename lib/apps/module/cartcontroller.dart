import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
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

  int get totalQuantity => cartItems.fold<int>(
    0,
        (sum, item) =>
    sum + ((item['quantity'] as num?)?.toInt() ?? 0),
  );
  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[SHOPIFY CART] $message');
    }
  }
  String get _cartId =>
      _storage.read<String>('malia_shopify_cart_id') ?? '';

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
    debugPrint('🛒 Cart items count: ${cartItems.length}');

    isLoadingRecommendations.value = true;

    try {
      // Empty cart: show general products.
      if (cartItems.isEmpty) {
        debugPrint(
          '🛒 Cart is empty. Loading fallback recommendations...',
        );

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

          final rawProducts =
              response['productRecommendations'] as List? ?? [];

          debugPrint(
            '🔎 Related products for $productId: '
                '${rawProducts.length}',
          );

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
          debugPrint(
            '❌ Related products query failed for $productId: $e',
          );
          debugPrintStack(stackTrace: stackTrace);
        }

        if (results.length >= 10) break;
      }

      if (results.isNotEmpty) {
        recommendedProducts.assignAll(results.take(10).toList());

        debugPrint(
          '✅ Shopify recommendations loaded: '
              '${recommendedProducts.length}',
        );
      } else {
        debugPrint(
          '⚠️ No usable Shopify recommendations. '
              'Loading fallback products...',
        );

        await fetchFallbackRecommendations();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Recommendation error: $e');
      debugPrintStack(stackTrace: stackTrace);

      // Attempt fallback if the related-product request fails.
      await fetchFallbackRecommendations();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _log('Cartcontroller initialized.');
    _log('Saved cart ID exists: ${_cartId.isNotEmpty}');
    loadCart();
  }


  String _errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }

  void _checkUserErrors(dynamic result, String operation) {
    if (result is! Map) {
      _log('$operation failed: invalid response object.');
      throw Exception('$operation returned an invalid Shopify response.');
    }

    final errors = result['userErrors'] as List? ?? [];

    if (errors.isNotEmpty) {
      for (final error in errors) {
        if (error is Map) {
          _log(
            '$operation userError: '
                'field=${error['field']}, '
                'message=${error['message']}',
          );
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
    _log('$operation: no Shopify userErrors.');
  }

  Future<void> _saveCartId(String id) async {
    await _storage.write('malia_shopify_cart_id', id);
    _log('Cart ID saved to local storage.');
  }

  Future<void> _clearCartId() async {
    await _storage.remove('malia_shopify_cart_id');
    _log('Saved cart ID cleared.');
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

    _log('Product attributes: $attributes');

    return attributes;
  }


  Future<void> _createCart({
    required String variantId,
    required int quantity,
    required List<Map<String, String>> attributes,
  }) async {
    _log('Creating a new Shopify cart...');
    _log('Variant ID: $variantId');
    _log('Quantity: $quantity');
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
    _log('cartCreate response keys: ${response.keys.toList()}');
    final result = response['cartCreate'];
    _checkUserErrors(result, 'Create cart');

    final cart = result['cart'];

    if (cart is! Map || cart['id'] == null) {
      _log('cartCreate did not return a cart ID.');
      throw Exception('Shopify did not return a cart ID.');
    }
    final newCartId = cart['id'].toString();

    await _saveCartId(newCartId);

    _log('Cart created successfully.');
    _log('New cart ID saved: ${newCartId.isNotEmpty}');
    _log('Checkout URL returned: '
        '${(cart['checkoutUrl']?.toString().isNotEmpty ?? false)}');
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
    _log('========== ADD TO CART START ==========');
    _log('Product: ${product['name'] ?? product['title'] ?? 'Unknown'}');
    _log('Variant ID: $variantId');
    _log('Quantity requested: $quantity');
    _log('Variant price supplied: $variantPrice $currencyCode');
    _log('Existing cart ID: ${_cartId.isNotEmpty ? 'available' : 'missing'}');

    if (variantId.isEmpty) {
      _log('FAILED: Shopify variant ID is empty.');
      AppSnackbar.error('Shopify variant ID is missing.');
      return;
    }

    if (quantity < 1) {
      _log('FAILED: Invalid quantity $quantity.');
      AppSnackbar.error('Select a valid quantity.');
      return;
    }

    if (isUpdating.value) {
      _log('Another cart update is running. Ignoring this request.');
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
        _log('No existing cart found. Calling cartCreate.');
        await _createCart(
          variantId: variantId,
          quantity: quantity,
          attributes: attributes,
        );
      } else {
        _log('Existing cart found. Calling cartLinesAdd.');
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
      debugPrint('addToCart error: $e');
      debugPrintStack(stackTrace: stackTrace);
      AppSnackbar.error('Unable to Add Item ${cartError.value}');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void>  loadCart({bool showLoader = true}) async {
    final cartId = _cartId;

    _log('========== LOAD CART START ==========');
    _log('Saved cart ID exists: ${cartId.isNotEmpty}');


    if (cartId.isEmpty) {
      _log('No saved cart ID. Clearing cart state.');

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
      _log('Requesting cart from Shopify...');

      final response = await ShopifyCollectionService.query(
        _cartQuery,
        variables: {'cartId': cartId},
      );

      _log('GetCart response keys: ${response.keys.toList()}');

      final rawCart = response['cart'];

      if (rawCart is! Map) {
        _log('Shopify returned a null or invalid cart.');
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

      _log('Cart successfully retrieved.');
      _log('Shopify totalQuantity: ${cart['totalQuantity']}');
      _log('Checkout URL available: ${checkoutUrl.value.isNotEmpty}');

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

      _currencyCode =
          totalData['currencyCode']?.toString() ?? 'USD';

      _log('Subtotal: $_subtotal $_currencyCode');
      _log('Total: $_total $_currencyCode');

      final lines = cart['lines'] as Map? ?? {};
      final nodes = lines['nodes'] as List? ?? [];

      _log('Cart lines received: ${nodes.length}');

      final parsedItems = <Map<String, dynamic>>[];

      for (final rawLine in nodes) {
        if (rawLine is! Map) {
          _log('Skipping invalid cart line.');
          continue;
        }

        final line = Map<String, dynamic>.from(rawLine);
        final rawMerchandise = line['merchandise'];

        if (rawMerchandise is! Map) {
          _log('Skipping line because merchandise is missing.');
          continue;
        }

        final variant = Map<String, dynamic>.from(rawMerchandise);

        final rawProduct = variant['product'];
        final product = rawProduct is Map
            ? Map<String, dynamic>.from(rawProduct)
            : <String, dynamic>{};

        final variantImage = variant['image'] as Map? ?? {};
        final featuredImage = product['featuredImage'] as Map? ?? {};

        final variantImageUrl =
            variantImage['url']?.toString().trim() ?? '';

        final featuredImageUrl =
            featuredImage['url']?.toString().trim() ?? '';

        final imageUrl = variantImageUrl.isNotEmpty
            ? variantImageUrl
            : featuredImageUrl;

        _log('Cart product: ${product['title']}');
        _log('Variant title: ${variant['title']}');
        _log('Variant image URL: $variantImageUrl');
        _log('Featured image URL: $featuredImageUrl');
        _log('Final image URL: $imageUrl');

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
          'currencyCode':
          price['currencyCode']?.toString() ?? _currencyCode,
          'quantity': (line['quantity'] as num?)?.toInt() ?? 1,
          'availableForSale': variant['availableForSale'] == true,
          'selectedOptions': variant['selectedOptions'] ?? [],
          'shade': attributes['Shade'] ?? '',
          'length': attributes['Length'] ?? '',
          'hairType': attributes['Hair Type'] ?? '',
          'attributes': attributes,
        };

        parsedItems.add(item);

        _log(
          'Parsed item: '
              'name=${item['name']}, '
              'variant=${item['variantTitle']}, '
              'quantity=${item['quantity']}, '
              'price=${item['price']} ${item['currencyCode']}, '
              'available=${item['availableForSale']}',
        );
      }

      cartItems.assignAll(parsedItems);
      await fetchCartRecommendations();
      _log('Cart items assigned to RxList.');
      _log('Final item count: ${cartItems.length}');
      _log('Calculated total quantity: $totalQuantity');
      _log('Final subtotal: $_subtotal $_currencyCode');
      _log('Final total: $_total $_currencyCode');
      _log('========== LOAD CART SUCCESS ==========');
    } catch (e, stackTrace) {
      cartError.value = _errorMessage(e);

      _log('========== LOAD CART FAILED ==========');
      _log('Error: $e');
      debugPrintStack(stackTrace: stackTrace);
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
    _log('========== UPDATE QUANTITY START ==========');
    _log('Index: $index');
    _log('Requested quantity: $newQuantity');

    if (index < 0 || index >= cartItems.length) {
      _log('FAILED: Invalid cart item index.');
      return;
    }

    if (isUpdating.value) {
      _log('Another cart update is in progress.');
      return;
    }

    final lineId = cartItems[index]['lineId']?.toString() ?? '';
    final itemName = cartItems[index]['name']?.toString() ?? 'Unknown';

    _log('Product: $itemName');
    _log('Line ID available: ${lineId.isNotEmpty}');

    if (lineId.isEmpty) {
      AppSnackbar.error('Shopify cart line ID is missing.');
      return;
    }

    isUpdating.value = true;

    try {
      if (newQuantity < 1) {
        _log('Quantity below 1. Removing item instead.');
        await _removeLine(lineId);
        return;
      }

      _log('Sending cartLinesUpdate request...');

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

      _log('Update response keys: ${response.keys.toList()}');

      _checkUserErrors(
        response['cartLinesUpdate'],
        'Update cart quantity',
      );

      _log('Shopify accepted the quantity update.');

      await loadCart(showLoader: false);

      _log('Quantity update completed.');
      _log('Updated total quantity: $totalQuantity');
      _log('Updated subtotal: $_subtotal $_currencyCode');
      _log('========== UPDATE QUANTITY SUCCESS ==========');
    } catch (e, stackTrace) {
      _log('========== UPDATE QUANTITY FAILED ==========');
      _log('Error: $e');
      debugPrintStack(stackTrace: stackTrace);

      AppSnackbar.error(_errorMessage(e));
    } finally {
      isUpdating.value = false;
      _log('Quantity update loading state cleared.');
    }
  }
  Future<void> increaseQuantity(int index) async {
    if (index < 0 || index >= cartItems.length) {
      _log('Increase quantity failed: invalid index $index.');
      return;
    }

    final current =
        (cartItems[index]['quantity'] as num?)?.toInt() ?? 1;

    _log('Increase quantity: $current -> ${current + 1}');

    await _updateQuantity(index, current + 1);
  }

  Future<void> decreaseQuantity(int index) async {
    if (index < 0 || index >= cartItems.length) {
      _log('Decrease quantity failed: invalid index $index.');
      return;
    }

    final current =
        (cartItems[index]['quantity'] as num?)?.toInt() ?? 1;

    if (current > 1) {
      _log('Decrease quantity: $current -> ${current - 1}');
      await _updateQuantity(index, current - 1);
    } else {
      _log('Quantity is already 1; keeping minimum quantity.');
    }
  }

  Future<void> _removeLine(String lineId) async {
    _log('Removing Shopify cart line...');
    _log('Line ID available: ${lineId.isNotEmpty}');

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

    _log('Remove response keys: ${response.keys.toList()}');

    _checkUserErrors(
      response['cartLinesRemove'],
      'Remove cart item',
    );

    _log('Shopify accepted the remove operation.');

    await loadCart(showLoader: false);

    _log('Cart refreshed after removal.');
    _log('Remaining item count: ${cartItems.length}');
    _log('Remaining quantity: $totalQuantity');
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

      // Reload the cart from Shopify.
      // loadCart() already refreshes recommendations.
      await loadCart(showLoader: false);

      _log('Removed "$itemName" successfully.');
    } catch (e, stackTrace) {
      debugPrint('removeFromCart error: $e');
      debugPrintStack(stackTrace: stackTrace);

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
      debugPrint('🛍️ Fetching fallback recommendations...');

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
        final minimumPrice =
            priceRange['minVariantPrice'] as Map? ?? {};
        final variantPrice = availableVariant['price'] as Map? ?? {};

        results.add({
          'id': id,
          'name': product['title']?.toString() ?? '',
          'title': product['title']?.toString() ?? '',
          'handle': product['handle']?.toString() ?? '',
          'image': imageData['url']?.toString() ?? '',
          'variantId': availableVariant['id']?.toString() ?? '',
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

      recommendedProducts.assignAll(results);

      debugPrint(
        '✅ Fallback recommendations loaded: '
            '${recommendedProducts.length}',
      );

      if (results.isEmpty) {
        debugPrint(
          '⚠️ No fallback products passed the availability '
              'and cart-exclusion filters.',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Fallback recommendations failed: $e');
      debugPrintStack(stackTrace: stackTrace);
      recommendedProducts.clear();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }



}
