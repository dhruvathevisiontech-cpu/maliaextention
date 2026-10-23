
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

import 'package:maliaextention/apps/module/shopify_collection_service.dart';
import 'package:maliaextention/apps/module/WishlistScreen/wishlist/controller/wishlistcontroller.dart';
import 'package:maliaextention/apps/module/cartcontroller.dart';

import '../../../Authentication/auth_session_helper.dart';

class Productdetailscontroller extends GetxController {
  final CarouselSliderController carouselController =
  CarouselSliderController();

  final RxInt currentIndex = 0.obs;
  final RxBool isWishlisted = false.obs;
  final RxBool isLoadingProduct = false.obs;
  final RxString productError = ''.obs;

  final RxMap<String, dynamic> productDetails =
      <String, dynamic>{}.obs;

  final RxList<String> productImages = <String>[].obs;
  final RxList<Map<String, dynamic>> variants =
      <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedVariant =
  Rxn<Map<String, dynamic>>();

  late Cartcontroller cartController;
  late Wishlistcontroller wishlistController;
  late Map<String, dynamic> product;

  final RxList<Map<String, dynamic>> recommendedProducts =
      <Map<String, dynamic>>[].obs;

  final RxBool isLoadingRecommendations = false.obs;

  final lengths = <String>[
    '18" (40g)',
    '22" (50g)',
  ];

  final shades = <String>[
    "asset/image/one.png",
    "asset/image/two.png",
    "asset/image/three.png",
    "asset/image/four.png",
    "asset/image/five.png",
    "asset/image/six.png",
    "asset/image/seven.png",
    "asset/image/eight.png",
    "asset/image/nine.png",
    "asset/image/ten.png",
    "asset/image/eleven.png",
    "asset/image/twelve.png",
    "asset/image/thirteen.png",
    "asset/image/fourteen.png",
    "asset/image/fifthteen.png",
    "asset/image/sixteen.png",
    "asset/image/seventeen.png",
    "asset/image/eighteen.png",
    "asset/image/nineteen.png",
  ];

  final shadeNames = <String>[
    "Almond Cream",
    "Meech",
    "Coffee Bean",
    "Chocolate",
    "Toffee",
    "Raspberry",
    "Champagne",
    "Stella",
    "Buttercream Frosting",
    "Caramel Swirl",
    "Crème Brûlée",
    "Vanilla Bean",
    "Toasted Coconut",
    "Chocolate Covered Pretzel",
    "Chocolate Glazed",
    "Pecan Latte",
    "Oatmeal Cookie",
    "Cinnamon Sugar",
    "Truffle",
  ];

  final selectedShade = 0.obs;
  final selectedLength = 0.obs;
  final hairlength = <String>["Straight", "Wavy"];
  final selectedhairlength = 0.obs;
  final RxInt quantity = 1.obs;
  final RxBool isExpanded = false.obs;

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
        images(first: 20) {
          nodes {
            url
            altText
          }
        }
        variants(first: 100) {
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

  Future<void> fetchRecommendations() async {
    final productId = productDetails['id']?.toString() ?? '';

    if (productId.isEmpty) return;

    isLoadingRecommendations.value = true;

    try {
      final response = await ShopifyCollectionService.query(
        _recommendationsQuery,
        variables: {'productId': productId},
      );

      final rawProducts = response['productRecommendations'] as List? ?? [];

      recommendedProducts.assignAll(
        rawProducts
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList(),
      );
    } catch (e) {
      debugPrint('fetchRecommendations error: $e');
      recommendedProducts.clear();
    } finally {
      isLoadingRecommendations.value = false;
    }
  }

  String get productName =>
      productDetails['title']?.toString() ??
          product['name']?.toString() ??
          'Product';

  String get description =>
      productDetails['description']?.toString() ?? '';

  String get currencyCode =>
      selectedVariant.value?['price']?['currencyCode']?.toString() ??
          'USD';

  String get price {
    final variantPrice =
    selectedVariant.value?['price']?['amount']?.toString();

    if (variantPrice != null && variantPrice.isNotEmpty) {
      return variantPrice;
    }

    return product['price']?.toString() ?? '0.00';
  }

  bool get isAvailable {
    if (selectedVariant.value != null) {
      return selectedVariant.value!['availableForSale'] == true;
    }

    return productDetails['availableForSale'] == true;
  }

  List<Map<String, dynamic>> get optionDefinitions {
    final result = <String, Set<String>>{};

    for (final variant in variants) {
      final options = variant['selectedOptions'] as List? ?? [];

      for (final rawOption in options) {
        if (rawOption is! Map) continue;

        final name = rawOption['name']?.toString() ?? '';
        final value = rawOption['value']?.toString() ?? '';

        if (name.isEmpty || value.isEmpty) continue;

        result.putIfAbsent(name, () => <String>{}).add(value);
      }
    }

    return result.entries.map((entry) {
      return <String, dynamic>{
        'name': entry.key,
        'values': entry.value.toList(),
      };
    }).toList();
  }
  final RxBool isLoggedIn = false.obs;

  void checkLoginStatus() {
    isLoggedIn.value = AuthSessionHelper.isLoggedIn();
    print("Is User Logged In: ${isLoggedIn.value}");
  }
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    wishlistController = Get.find<Wishlistcontroller>();

    if (Get.isRegistered<Cartcontroller>()) {
      cartController = Get.find<Cartcontroller>();
    } else {
      cartController = Get.put<Cartcontroller>(
        Cartcontroller(),
        permanent: true,
      );
    }
  }

  void setProduct(Map<String, String> newProduct) {
    product = Map<String, dynamic>.from(newProduct);

    final productId = product['id']?.toString() ?? '';
    isWishlisted.value = productId.isNotEmpty &&
        wishlistController.isWishlisted(productId);

    currentIndex.value = 0;
    selectedShade.value = 0;
    selectedLength.value = 0;
    selectedhairlength.value = 0;
    quantity.value = 1;
    isExpanded.value = false;

    productDetails.clear();
    productImages.clear();
    variants.clear();
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
      final response = await ShopifyCollectionService.query(
        _productDetailsQuery,
        variables: {'handle': handle},
      );

      final rawProduct = response['product'];

      if (rawProduct is! Map<String, dynamic>) {
        productError.value = 'Product not found in Shopify.';
        return;
      }

      productDetails.assignAll(rawProduct);
      recommendedProducts.clear();
      await fetchRecommendations();
      final loadedImages = <String>[];
      final imageNodes =
          rawProduct['images']?['nodes'] as List? ?? [];

      for (final rawImage in imageNodes) {
        if (rawImage is! Map) continue;

        final url = rawImage['url']?.toString() ?? '';
        if (url.isNotEmpty && !loadedImages.contains(url)) {
          loadedImages.add(url);
        }
      }

      final featuredImage =
          rawProduct['featuredImage']?['url']?.toString() ?? '';

      if (featuredImage.isNotEmpty &&
          !loadedImages.contains(featuredImage)) {
        loadedImages.insert(0, featuredImage);
      }

      productImages.assignAll(loadedImages);

      final rawVariants =
          rawProduct['variants']?['nodes'] as List? ?? [];

      variants.assignAll(
        rawVariants
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList(),
      );

      // Initially choose the first available variant, if one exists.
      final firstAvailable = variants.firstWhereOrNull(
            (variant) => variant['availableForSale'] == true,
      );

      selectedVariant.value =
          firstAvailable ?? (variants.isNotEmpty ? variants.first : null);

      currentIndex.value = 0;

      debugPrint('Product details loaded: $productName');
      debugPrint('Product images: ${productImages.length}');
      debugPrint('Product variants: ${variants.length}');
    } catch (e, stackTrace) {
      productError.value = 'Unable to load product details.';
      debugPrint('fetchProductDetails error: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoadingProduct.value = false;
    }
  }

  void selectVariant(Map<String, dynamic> variant) {
    selectedVariant.value = variant;

    final variantImage =
        variant['image']?['url']?.toString() ?? '';

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

  void selectShade(int index) {
    if (index >= 0 && index < shades.length) {
      selectedShade.value = index;
    }
  }

  void increaseQty() {
    quantity.value++;
  }

  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void updateQty() {}

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleWishlist() {
    final productId = product['id']?.toString() ?? '';
    if (productId.isEmpty) return;

    wishlistController.toggleWishlist(product);
    isWishlisted.value = wishlistController.isWishlisted(productId);
  }

  void addToCart() {
    final variant = selectedVariant.value;

    if (variant == null) {
      Get.snackbar(
        'Unavailable',
        'No Shopify variant is available for this product.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (variant['availableForSale'] != true) {
      Get.snackbar(
        'Out of Stock',
        'This variant is currently unavailable.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final selectedShadeName = shadeNames[selectedShade.value];
    final selectedLengthValue = lengths[selectedLength.value];
    final selectedHairType = hairlength[selectedhairlength.value];

    final cartProduct = <String, dynamic>{
      ...product,
      'id': productDetails['id']?.toString() ?? product['id']?.toString() ?? '',
      'name': productName,
      'handle': productDetails['handle']?.toString() ?? product['handle'] ?? '',
      'image': productImages.isNotEmpty
          ? productImages.first
          : product['image'] ?? '',
      'price': price,
      'currencyCode': currencyCode,
      'variantId': variant['id']?.toString() ?? '',
      'variantTitle': variant['title']?.toString() ?? '',
      'variantPrice': price,
      'variantAvailableForSale':
      variant['availableForSale'] == true ? 'true' : 'false',
      'selectedOptions': variant['selectedOptions'] ?? [],
    };

    cartController.addToCart(
      product: cartProduct,
      shade: selectedShadeName,
      length: selectedLengthValue,
      hairType: selectedHairType,
      quantity: quantity.value,
      variantId: variant['id']?.toString() ?? '',
      variantPrice: price,
      currencyCode: currencyCode,
    );
  }
}
