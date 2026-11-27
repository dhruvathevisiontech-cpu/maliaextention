import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maliaextention/apps/module/cartcontroller.dart';
import 'package:maliaextention/typo/appsnackbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maliaextention/apps/module/shopify_collection_service.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
class Productdetailscontroller extends GetxController {
  final CarouselSliderController carouselController = CarouselSliderController();
  final RxInt currentIndex = 0.obs;
  final RxBool isWishlisted = false.obs;
  final RxBool isLoadingProduct = false.obs;
  final RxBool isLoadingRecommendations = false.obs;
  final RxBool isExpanded = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString productError = ''.obs;
  final RxDouble productRating = 0.0.obs;
  final RxInt productReviewCount = 0.obs;
  final RxBool isLoadingRating = false.obs;
  bool _isAddingToCart = false;
  static const String _judgeMeShopDomain = '7b4ae8-00.myshopify.com';
  static const String _judgeMePublicToken = '3L9Yqs1PNygPqhFA3P-d_Sf2TyU';
  final RxMap<String, dynamic> productDetails = <String, dynamic>{}.obs;
  final RxList<String> productImages = <String>[].obs;
  final RxList<Map<String, dynamic>> variants = <Map<String, dynamic>>[].obs;
  final Rxn<Map<String, dynamic>> selectedVariant = Rxn<Map<String, dynamic>>();
  final RxMap<String, String> selectedOptions = <String, String>{}.obs;
  final RxList<Map<String, dynamic>> recommendedProducts = <Map<String, dynamic>>[].obs;
  String get formattedRating => productRating.value.toStringAsFixed(1);
  final RxInt quantity = 1.obs;
  late Wishlistcontroller wishlistController;
  late Map<String, dynamic> product;
  static const String shippingPolicyQuery = '''
{
  shop {
    shippingPolicy {
      title
      body
      url
    }
  }
}
''';
  final RxString shippingTitle = ''.obs;
  final RxString shippingDescription = ''.obs;
  final RxString shippingUrl = ''.obs;
  final RxBool isLoadingShipping = false.obs;
  String _getSelectedOption(String optionName) {
    for (final entry in selectedOptions.entries) {
      if (entry.key.trim().toLowerCase() ==
          optionName.trim().toLowerCase()) {
        return entry.value;
      }
    }
    return '';
  }


  Future<void> addCurrentProductToCart() async {
    // Prevent duplicate Add to Cart calls.
    if (_isAddingToCart) {
      return;
    }

    _isAddingToCart = true;

    try {
      final variant = selectedVariant.value;

      if (variant == null) {
        AppSnackbar.error('Please select a product variant.');
        return;
      }

      if (variant['availableForSale'] != true) {
        AppSnackbar.error('This variant is currently unavailable.');
        return;
      }

      final variantId = variant['id']?.toString() ?? '';

      if (variantId.isEmpty) {
        AppSnackbar.error('Shopify variant ID is missing.');
        return;
      }

      final priceData = variant['price'] as Map? ?? {};

      final shade = _getSelectedOption('Shade');
      final length = _getSelectedOption('Length');
      final texture = _getSelectedOption('Texture');
      final hairType = _getSelectedOption('Hair Type');
      final cartController = Get.find<Cartcontroller>();
      await cartController.addToCart(
        product: wishlistProductData,
        shade: shade,
        length: length,
        hairType: hairType,
        texture: texture,
        quantity: quantity.value,
        variantId: variantId,
        variantPrice: priceData['amount']?.toString() ?? '0.00',
        currencyCode: priceData['currencyCode']?.toString() ?? 'USD',
      );
    } catch (e, stackTrace) {
    } finally {
      _isAddingToCart = false;
    }
  }

  Future<void> fetchShippingInfo() async {
    try {
      isLoadingShipping.value = true;
      final response = await ShopifyCollectionService.query(shippingPolicyQuery,);
      final shop = response['shop'] ?? response['data']?['shop'];
      final policy = shop?['shippingPolicy'];
      if (policy != null) {
        shippingTitle.value = policy['title']?.toString() ?? '';
        shippingDescription.value = policy['body']?.toString() ?? '';
        shippingUrl.value = policy['url']?.toString() ?? '';
      } else {
        shippingTitle.value = '';
        shippingDescription.value = '';
        shippingUrl.value = '';
      }
    } catch (e, stackTrace) {
    } finally {
      isLoadingShipping.value = false;
    }
  }
  String formatProductDescription(String description) {
    String text = description.trim();
    if (text.isEmpty) return '';
    text = text.replaceAll(
      'Each pack contains',
      '\n\nEach pack contains',
    );
    text = text.replaceAll(
      '18” is',
      '\n18” is',
    );
    text = text.replaceAll(
      '22” is',
      '\n22” is',
    );
    return text;
  }
  void selectVariant(Map<String, dynamic> variant) {
    _applySelectedVariant(variant);
  }
  List<String> get shadeNames {
    return shadeOptionValues.map((shade) => shade['name']?.toString() ?? '').where((name) => name.isNotEmpty).toList();
  }
  List<String> get shades => shadeNames;
  String? shadeImageUrl(String optionName, String optionValue) {
    for (final variant in variants) {
      final options = variant['selectedOptions'] as List? ?? [];
      final matches = options.any((option) {
        if (option is! Map) return false;
        return option['name']?.toString().trim().toLowerCase() == optionName.trim().toLowerCase() && option['value']?.toString().trim().toLowerCase() == optionValue.trim().toLowerCase();
      });
      if (!matches) continue;
      final imageUrl = variant['image']?['url']?.toString() ?? '';
      if (imageUrl.isNotEmpty) {
        return imageUrl;
      }
    }
    return null;
  }
  Future<void> fetchProductRating() async {
    final handle = productDetails['handle']?.toString() ?? '';
    final shopifyId = currentProductId.split('/').last;
    if (handle.isEmpty) return;
    isLoadingRating.value = true;
    try {
      final uri = Uri.https(
        'api.judge.me',
        '/api/v1/widgets/preview_badge',
        {
          'shop_domain': _judgeMeShopDomain,
          'api_token': _judgeMePublicToken,
          'handle': handle,
          'external_id': shopifyId,
        },
      );
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final badgeHtml = data['badge']?.toString() ?? '';
        final ratingMatch = RegExp(r"""data-average-rating=['"]([^'"]+)['"]""",).firstMatch(badgeHtml);
        final countMatch = RegExp(r"""data-number-of-reviews=['"]([^'"]+)['"]""",).firstMatch(badgeHtml);
        productRating.value = double.tryParse(ratingMatch?.group(1) ?? '') ?? 0.0;
        productReviewCount.value = int.tryParse(countMatch?.group(1) ?? '') ?? 0;
      } else {
        productRating.value = 0.0;
        productReviewCount.value = 0;
      }
    } catch (e, stackTrace) {
      productRating.value = 0.0;
      productReviewCount.value = 0;
    } finally {
      isLoadingRating.value = false;
    }
  }
  static const String _productDetailsQuery = r'''
  query GetProductDetails($handle: String!) {
    product(handle: $handle) {
      id
      title
      handle
      description
      descriptionHtml
      availableForSale
      featuredImage {
        url
        altText
      }
      images(first: 100) {
        nodes {
          url
          altText
        }
      }
      variants(first: 250) {
        nodes {
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
          image {
            url
            altText
          }
        }
      }
      options {
        name
        optionValues {
          id
          name
          swatch {
            color
            image {
              previewImage {
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
  static const String _recommendationsQuery = r'''
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
      }
    }
  ''';
  List<Map<String, dynamic>> get shadeOptionValues {
    final productOptions = productDetails['options'] as List? ?? [];
    final shadeOption = productOptions.firstWhereOrNull((option) {
      if (option is! Map) return false;
      final name = option['name']?.toString().trim().toLowerCase() ?? '';
      return name.contains('shade');
    });
    if (shadeOption == null) return [];
    final values = shadeOption['optionValues'] as List? ?? [];
    return values.whereType<Map>().map((value) => Map<String, dynamic>.from(value)).toList();
  }
  String? getShadeImage(String shadeName) {
    final shade = shadeOptionValues.firstWhereOrNull((item) {
      return (item['name']?.toString() ?? '').trim().toLowerCase() == shadeName.trim().toLowerCase();
    });
    if (shade == null) return null;
    final swatch = shade['swatch'];
    if (swatch is! Map) return null;
    final image = swatch['image'];
    if (image is! Map) return null;
    final previewImage = image['previewImage'];
    if (previewImage is! Map) return null;
    final url = previewImage['url']?.toString() ?? '';
    return url.isEmpty ? null : url;
  }
  @override
  void onInit() {
    super.onInit();
    fetchShippingInfo();
    checkLoginStatus();
    wishlistController = Get.find<Wishlistcontroller>();
    if (!Get.isRegistered<Cartcontroller>()) {
      Get.put(Cartcontroller(), permanent: true);
    }
  }
  void checkLoginStatus() {
    isLoggedIn.value = AuthSessionHelper.isLoggedIn();
  }
  String get productName => productDetails['title']?.toString() ?? product['name']?.toString() ?? 'Product';
  String get description => productDetails['description']?.toString() ?? '';
  String get descriptionHtml => productDetails['descriptionHtml']?.toString() ?? '';
  String get currencyCode => selectedVariant.value?['price']?['currencyCode']?.toString() ?? 'USD';
  String get price {
    final variantPrice = selectedVariant.value?['price']?['amount']?.toString();
    if (variantPrice != null && variantPrice.isNotEmpty) {
      return variantPrice;
    }
    return product['price']?.toString() ?? '0.00';
  }
  String get currentProductId => productDetails['id']?.toString() ?? product['id']?.toString() ?? '';
  String get currentProductImage {
    if (productImages.isNotEmpty) {
      final index = currentIndex.value;
      if (index >= 0 && index < productImages.length) {
        return productImages[index];
      }
    }
    return productDetails['featuredImage']?['url']?.toString() ?? product['image']?.toString() ?? '';
  }
  bool get isAvailable {
    if (selectedVariant.value != null) {
      return selectedVariant.value!['availableForSale'] == true;
    }
    return productDetails['availableForSale'] == true;
  }
  Map<String, dynamic> get wishlistProductData {
    return <String, dynamic>{
      ...product,
      'id': currentProductId,
      'name': productName,
      'title': productName,
      'handle': productDetails['handle']?.toString() ?? product['handle']?.toString() ?? '',
      'image': currentProductImage,
      'price': price,
      'currencyCode': currencyCode,
    };
  }
  List<Map<String, dynamic>> get optionDefinitions {
    final Map<String, Set<String>> options = {};
    for (final variant in variants) {
      final rawOptions = variant['selectedOptions'] as List? ?? [];
      for (final rawOption in rawOptions) {
        if (rawOption is! Map) continue;
        final name = rawOption['name']?.toString() ?? '';
        final value = rawOption['value']?.toString() ?? '';
        if (name.isEmpty || value.isEmpty) continue;
        options.putIfAbsent(name, () => <String>{});
        options[name]!.add(value);
      }
    }
    return options.entries.map((entry) {
      return <String, dynamic>{
        'name': entry.key,
        'values': entry.value.toList(),
      };
    }).toList();
  }
  List<String> optionValues(String optionName) {
    for (final option in optionDefinitions) {
      if (option['name'].toString().toLowerCase() ==
          optionName.toLowerCase()) {
        return List<String>.from(option['values'] as List);
      }
    }
    return [];
  }
  String selectedOptionValue(String optionName) {
    return selectedOptions[optionName] ?? '';
  }
  void selectOption(String optionName, String value) {
    if (!optionValues(optionName).contains(value)) return;
    final updatedOptions = Map<String, String>.from(selectedOptions);
    updatedOptions[optionName] = value;
    Map<String, dynamic>? matchingVariant;
    for (final variant in variants) {
      if (_variantMatches(variant, updatedOptions)) {
        matchingVariant = variant;
        break;
      }
    }
    if (matchingVariant == null) {
      int bestScore = -1;
      for (final variant in variants) {
        if (variant['availableForSale'] != true) continue;
        final variantOptions = _variantOptionsMap(variant);
        if (variantOptions[optionName] != value) continue;
        int score = 0;
        for (final entry in updatedOptions.entries) {
          if (variantOptions[entry.key] == entry.value) {
            score++;
          }
        }
        if (score > bestScore) {
          bestScore = score;
          matchingVariant = variant;
        }
      }
    }
    if (matchingVariant != null) {
      _applySelectedVariant(matchingVariant);
    }
  }
  bool _variantMatches(Map<String, dynamic> variant, Map<String, String> requestedOptions) {
    final variantOptions = _variantOptionsMap(variant);
    for (final entry in requestedOptions.entries) {
      if (variantOptions[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }
  Map<String, String> _variantOptionsMap(Map<String, dynamic> variant) {
    final result = <String, String>{};
    final rawOptions = variant['selectedOptions'] as List? ?? [];
    for (final option in rawOptions) {
      if (option is! Map) continue;
      final name = option['name']?.toString() ?? '';
      final value = option['value']?.toString() ?? '';
      if (name.isNotEmpty) {
        result[name] = value;
      }
    }
    return result;
  }
  void _applySelectedVariant(Map<String, dynamic> variant) {
    selectedVariant.value = variant;
    selectedOptions.assignAll(
      _variantOptionsMap(variant),
    );
    final variantImage = variant['image']?['url']?.toString() ?? '';
    if (variantImage.isNotEmpty) {
      final index = productImages.indexOf(variantImage);
      if (index >= 0) {
        currentIndex.value = index;
      } else {
        productImages.insert(0, variantImage);
        currentIndex.value = 0;
      }
    }
  }
  void setProduct(Map<String, String> newProduct) {
    product = Map<String, dynamic>.from(newProduct);
    productRating.value = 0.0;
    productReviewCount.value = 0;
    final productId = product['id']?.toString() ?? '';
    isWishlisted.value = productId.isNotEmpty && wishlistController.isProductInAnyWishlist(productId);
    currentIndex.value = 0;
    quantity.value = 1;
    isExpanded.value = false;
    productDetails.clear();
    productImages.clear();
    variants.clear();
    selectedOptions.clear();
    recommendedProducts.clear();
    selectedVariant.value = null;
    productError.value = '';
    fetchProductDetails();
  }
  Future<void> fetchProductDetails() async {
    final handle = product['handle']?.toString() ?? '';
    if (handle.isEmpty) {
      productError.value = 'This product has no Shopify handle.';
      return;
    }
    isLoadingProduct.value = true;
    productError.value = '';
    try {
      final response = await ShopifyCollectionService.queryTokenless(_productDetailsQuery, variables: {'handle': handle});
      final rawProduct = response['product'];
      if (rawProduct is! Map) {
        productError.value = 'Product not found in Shopify.';
        return;
      }
      final productData = Map<String, dynamic>.from(rawProduct);
      productDetails.assignAll(productData);
      final options = productDetails['options'] as List? ?? [];
      for (final option in options) {
        if (option is! Map) continue;
        final values = option['optionValues'] as List? ?? [];
        for (final value in values) {
          if (value is! Map) continue;
          final shadeName = value['name']?.toString() ?? '';
          final swatch = value['swatch'];
          String imageUrl = '';
          if (swatch is Map) {
            final image = swatch['image'];
            if (image is Map) {
              final previewImage = image['previewImage'];
              if (previewImage is Map) {
                imageUrl = previewImage['url']?.toString() ?? '';
              }
            }
          }
        }
      }
      final loadedImages = <String>[];
      final imageNodes = productData['images']?['nodes'] as List? ?? [];
      for (final rawImage in imageNodes) {
        if (rawImage is! Map) continue;
        final url = rawImage['url']?.toString() ?? '';
        if (url.isNotEmpty && !loadedImages.contains(url)) {
          loadedImages.add(url);
        }
      }
      final featuredImage = productData['featuredImage']?['url']?.toString() ?? '';
      if (featuredImage.isNotEmpty && !loadedImages.contains(featuredImage)) {
        loadedImages.insert(0, featuredImage);
      }
      productImages.assignAll(loadedImages);
      final rawVariants = productData['variants']?['nodes'] as List? ?? [];
      variants.assignAll(rawVariants.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList());
      final firstAvailable = variants.firstWhereOrNull((variant) => variant['availableForSale'] == true);
      final initialVariant = firstAvailable ?? (variants.isNotEmpty ? variants.first : null);
      if (initialVariant != null) {
        _applySelectedVariant(initialVariant);
      }
      isWishlisted.value = wishlistController.isProductInAnyWishlist(currentProductId);
      fetchProductRating();
      currentIndex.value = 0;
      await fetchRecommendations();
    } catch (e, stackTrace) {
      productError.value = 'Unable to load product details.';
    } finally {
      isLoadingProduct.value = false;
    }
  }
  void selectImage(int index) {
    if (index >= 0 && index < productImages.length) {
      currentIndex.value = index;
    }
  }
  Future<void> fetchRecommendations() async {
    final productId = productDetails['id']?.toString() ?? '';
    if (productId.isEmpty) return;
    isLoadingRecommendations.value = true;
    try {
      final response = await ShopifyCollectionService.queryTokenless(_recommendationsQuery, variables: {'productId': productId});
      final rawProducts = response['productRecommendations'] as List? ?? [];
      recommendedProducts.assignAll(rawProducts.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList(),
      );
    } catch (e) {
      recommendedProducts.clear();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }
  void addCurrentProductToWishlist(String wishlistId) {
    if (currentProductId.isEmpty) {
      AppSnackbar.error('Product details are not available yet.');
      return;
    }
    wishlistController.addProductToWishlist(wishlistId, wishlistProductData,);
    isWishlisted.value = wishlistController.isProductInAnyWishlist(currentProductId);
  }
  void toggleWishlist() {
    if (currentProductId.isEmpty) return;
    wishlistController.toggleWishlist(wishlistProductData);
    isWishlisted.value = wishlistController.isProductInAnyWishlist(currentProductId);
  }
  void increaseQty() {
    quantity.value++;
  }
  void decreaseQty() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}