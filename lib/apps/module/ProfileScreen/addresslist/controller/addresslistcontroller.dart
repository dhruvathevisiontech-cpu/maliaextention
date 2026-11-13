
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Addresslistcontroller extends GetxController {
  final GetStorage storage = GetStorage();

  static const String customerId = '9310057726208';

  String get addressStorageKey => 'addresses_$customerId';

  final RxInt selectedAddress = 0.obs;

  final RxList<Map<String, dynamic>> addresses =
      <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }
  Future<void> setDefaultAddress(int index) async {
    try {
      if (index < 0 || index >= addresses.length) return;

      // Get selected address
      final Map<String, dynamic> selected =
      Map<String, dynamic>.from(addresses[index]);

      // Make all addresses non-default
      for (int i = 0; i < addresses.length; i++) {
        addresses[i]['isDefault'] = false;
      }

      // Set selected address as default
      selected['isDefault'] = true;

      // Remove selected address from its old position
      addresses.removeAt(index);

      // Move default address to the first position
      addresses.insert(0, selected);

      // Save updated list
      await storage.write(
        addressStorageKey,
        addresses.toList(),
      );

      // Update selected index
      selectedAddress.value = 0;

      addresses.refresh();

      Get.snackbar(
        'Success',
        'Default address pinned to the top.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colorstheam.nobelblack,
        colorText: Colorstheam.white,
        margin: const EdgeInsets.all(12),
      );

      debugPrint('DEFAULT ADDRESS PINNED TO TOP');
      debugPrint('UPDATED ADDRESSES: ${addresses.toList()}');
    } catch (e) {
      debugPrint('SET DEFAULT ADDRESS ERROR: $e');
      await loadAddresses();
    }
  }
  Future<void> deleteAddress(int index) async {
    try {
      if (index < 0 || index >= addresses.length) return;

      final bool wasDefault =
          addresses[index]['isDefault'] == true;

      addresses.removeAt(index);

      // Update default address if the removed address was default.
      if (addresses.isNotEmpty && wasDefault) {
        for (int i = 0; i < addresses.length; i++) {
          addresses[i]['isDefault'] = i == 0;
        }
      }

      // Update selected address.
      if (addresses.isEmpty) {
        selectedAddress.value = -1;
      } else {
        selectedAddress.value = 0;
      }

      // Save updated list to local storage.
      await storage.write(
        addressStorageKey,
        addresses.toList(),
      );

      addresses.refresh();

      Get.snackbar(
        "Success",
        "Address removed successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colorstheam.nobelblack,
        colorText: Colorstheam.white,
        margin: const EdgeInsets.all(12),
      );

      debugPrint("ADDRESS REMOVED SUCCESSFULLY");
      debugPrint("REMAINING ADDRESSES: ${addresses.length}");
    } catch (e) {
      debugPrint("DELETE ADDRESS ERROR: $e");

      Get.snackbar(
        "Error",
        "Unable to remove address. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );

      // Reload the saved list if storage update fails.
      await loadAddresses();
    }
  }
  // LOAD ADDRESSES FROM GETSTORAGE
  Future<void> loadAddresses() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<dynamic> savedData = storage.read<List<dynamic>>(addressStorageKey) ?? [];
      final List<Map<String, dynamic>> savedAddresses =
      savedData.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
      addresses.assignAll(savedAddresses);
      final int defaultIndex = addresses.indexWhere(
            (address) => address['isDefault'] == true,
      );
      selectedAddress.value = defaultIndex != -1
          ? defaultIndex
          : (addresses.isNotEmpty ? 0 : -1);
      debugPrint('LOCAL ADDRESSES LOADED: ${addresses.length}');
      debugPrint('ADDRESS DATA: ${addresses.toList()}');
    } catch (e, stackTrace) {
      errorMessage.value = 'Unable to load saved addresses.';
      debugPrint('LOAD ADDRESS ERROR: $e');
      debugPrint('STACK TRACE: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }
  void retryFetchAddresses() {
    loadAddresses();
  }
  void selectAddress(int index) {
    if (index < 0 || index >= addresses.length) return;

    selectedAddress.value = index;

    debugPrint('SELECTED ADDRESS INDEX: ${selectedAddress.value}');
  }
}
