  import 'package:get/get.dart';
  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:maliaextention/apps/module/cartcontroller.dart';
  import 'package:maliaextention/apps/module/wishlist/controller/wishlistcontroller.dart';

  class Productdetailscontroller extends GetxController {
    final CarouselSliderController carouselController = CarouselSliderController();
    final RxInt currentIndex = 0.obs;
    final RxBool isWishlisted = false.obs;
    late Cartcontroller cartController;
    late Wishlistcontroller wishlistController;
    late Map<String, dynamic> product;
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

    final shadeNames = [
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

    void selectShade(int index) {
      selectedShade.value = index;
    }

    final selectedLength = 0.obs;

    final hairlength = <String>[
      "Straight",
      "Wavy",
    ];

    final selectedhairlength = 0.obs;

    final RxInt quantity = 1.obs;

    void increaseQty() {
      quantity.value++;
    }

    void decreaseQty() {
      if (quantity.value > 1) {
        quantity.value--;
      }
    }

    void updateQty() {
      print("Updated quantity: ${quantity.value}");
    }

    final RxBool isExpanded = false.obs;

    void toggleExpanded() {
      isExpanded.value = !isExpanded.value;
    }

    @override
    void onInit() {
      super.onInit();

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

    void addToCart() {
      print("========== PRODUCT ADD TO CART ==========");

      print("[PRODUCT] Product: $product");
      print("[PRODUCT] Product ID: ${product["id"]}");

      final selectedShadeName = shadeNames[selectedShade.value];
      final selectedLengthValue = lengths[selectedLength.value];
      final selectedHairType = hairlength[selectedhairlength.value];

      print("[PRODUCT] Selected Shade: $selectedShadeName");
      print("[PRODUCT] Selected Length: $selectedLengthValue");
      print("[PRODUCT] Selected Hair Type: $selectedHairType");
      print("[PRODUCT] Quantity: ${quantity.value}");

      print(
        "[PRODUCT] Cartcontroller registered: "
            "${Get.isRegistered<Cartcontroller>()}",
      );

      cartController.addToCart(
        product: product,
        shade: selectedShadeName,
        length: selectedLengthValue,
        hairType: selectedHairType,
        quantity: quantity.value,
      );

      print(
        "[PRODUCT] Cart items: ${cartController.cartItems.length}",
      );

      print(
        "[PRODUCT] Total items: ${cartController.totalItems}",
      );

      print("========== PRODUCT ADD TO CART END ==========");
    }
    void setProduct(Map<String, String> newProduct) {
      product = Map<String, dynamic>.from(newProduct);

      final productId = product["id"]?.toString();

      if (productId != null && productId.isNotEmpty) {
        isWishlisted.value =
            wishlistController.isWishlisted(productId);
      } else {
        isWishlisted.value = false;
      }

      currentIndex.value = 0;
      selectedShade.value = 0;
      selectedLength.value = 0;
      selectedhairlength.value = 0;
      quantity.value = 1;
      isExpanded.value = false;
    }

    void toggleWishlist() {
      final productId = product["id"]?.toString();

      if (productId == null || productId.isEmpty) {
        return;
      }

      wishlistController.toggleWishlist(product);

      isWishlisted.value =
          wishlistController.isWishlisted(productId);
    }
  }