
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maliaextention/color/colorstheam.dart';

class Profiledetailscontroller extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Selected profile image
  final Rxn<File> profileImage = Rxn<File>();

  // Open gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Image Picker',
        'Unable to select image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  // Show image selection options


  void showImagePickerOptions() {
    Get.bottomSheet(
      SafeArea(
        child: Material(
          color: Colorstheam.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 25, 24, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROFILE PHOTO',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: Colorstheam.black,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  'Choose an option to manage your profile picture.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 12,
                    color: Colorstheam.grey,
                  ),
                ),
                const SizedBox(height: 22),
                // 1. Take a Photo
                _photoOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take a Photo',
                  subtitle: 'Capture a new profile picture',
                  onTap: () {
                    Get.back();
                    pickImage(ImageSource.camera);
                  },
                ),

                Divider(color: Colorstheam.clusterwhite),

                // 2. Choose from Gallery
                _photoOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle: 'Select a photo from your device',
                  onTap: () {
                    Get.back();
                    pickImage(ImageSource.gallery);
                  },
                ),

                Divider(color: Colorstheam.clusterwhite),

                // 3. Remove Profile Photo
                _photoOption(
                  icon: Icons.delete_outline,
                  title: 'Remove Profile Photo',
                  subtitle: 'Remove your current profile picture',
                  onTap: () {
                    profileImage.value = null;
                    Get.back();
                  },
                  iconColor: Colorstheam.Racingred,
                ),



              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

// Reusable photo option
  Widget _photoOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        size: 23,
        color: iconColor ?? Colorstheam.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: iconColor ?? Colorstheam.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 11,
          color: Colorstheam.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 13,
        color: Colorstheam.grey,
      ),
      onTap: onTap,
    );
  }
  // Date of birth
  final Rxn<DateTime> selectedDateOfBirth = Rxn<DateTime>();

  final TextEditingController dateOfBirthController =
  TextEditingController();
  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateOfBirth.value ??
          DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colorstheam.nobelblack,
              onPrimary: Colorstheam.white,
              surface: Colorstheam.white,
              onSurface: Colorstheam.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDateOfBirth.value = pickedDate;

      // Format date as DD/MM/YYYY
      dateOfBirthController.text =
      '${pickedDate.day.toString().padLeft(2, '0')}/'
          '${pickedDate.month.toString().padLeft(2, '0')}/'
          '${pickedDate.year}';
    }
  }

  @override
  void onClose() {
    dateOfBirthController.dispose();
    super.onClose();
  }


}
