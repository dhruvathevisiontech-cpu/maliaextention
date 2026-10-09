import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maliaextention/typo/apptext.dart';

class Hostclasscontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonenumbercontroller = TextEditingController();
  final salonamecontroller = TextEditingController();
  final salonaddresscontroller = TextEditingController();
  final instagramController = TextEditingController();
  final hostcomfortablecontroller = TextEditingController();
  final monthhostcontroller = TextEditingController();
  final salonandcomunitycontroller = TextEditingController();


  final salonRoleError = ''.obs;
  final stylistCountError = ''.obs;
  final stylistExtensionError = ''.obs;
  final extensionMethodError = ''.obs;
  final educationError = ''.obs;
  final previouslyError = ''.obs;

  final selectedSalonRoles = <String>[].obs;

  final salonRoles = [
    "Salon Owner",
    "Salon Manager",
    "Independent Stylist",
    "Commission Stylist",
    "Educator",
  ];


  final selecthowmanystylist = <String>[].obs;

  final howmanystylistwork = [
    "1-5",
    "6-10",
    "11-20",
    "21+",
  ];

  final selecthowmanystylist1 = <String>[].obs;

  final howmanystylistwork1 = [
    "One",
    "A Few",
    "All",
  ];

  final selectextentionmethod = <String>[].obs;

  final extentionmenthod = [
    "Sew-Ins",
    "Tape/Tape Wefts",
    "K-Tips/I-Tips",
    "None",
    "Other:"
  ];


  final selecteducation = <String>[].obs;

  final education = [
    "Yes",
    "Possibly",
    "No (Have an off-site option)",
  ];

  final selectpreviously = <String>[].obs;

  final previously = [
    "Yes",
    "No",
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailcontroller.dispose();
    phonenumbercontroller.dispose();
    salonamecontroller.dispose();
    salonaddresscontroller.dispose();
    instagramController.dispose();
    hostcomfortablecontroller.dispose();
    monthhostcontroller.dispose();
    salonandcomunitycontroller.dispose();
    super.dispose();
  }

  void submitForm() {
    // Validate TextFormFields
    final isFormValid = formKey.currentState?.validate() ?? false;

    // Reset checkbox errors first
    salonRoleError.value = '';
    stylistCountError.value = '';
    stylistExtensionError.value = '';
    extensionMethodError.value = '';
    educationError.value = '';
    previouslyError.value = '';

    // Validate Your role
    if (selectedSalonRoles.isEmpty) {
      salonRoleError.value = Apptext.yourrolerror;
    }

    // Validate total stylists
    if (selecthowmanystylist.isEmpty) {
      stylistCountError.value = Apptext.hwmanysylisterror;
    }

    // Validate stylists offering extensions
    if (selecthowmanystylist1.isEmpty) {
      stylistExtensionError.value = Apptext.stylistcurrentlyerror;
    }

    // Validate extension methods
    if (selectextentionmethod.isEmpty) {
      extensionMethodError.value = Apptext.currentlyusederror;
    }

    // Validate education space
    if (selecteducation.isEmpty) {
      educationError.value = Apptext.saloneducationerror;
    }

    // Validate previously trained
    if (selectpreviously.isEmpty) {
      previouslyError.value = Apptext.previouslytrainederror;
    }

    // Stop submission if anything is invalid
    if (!isFormValid ||
        selectedSalonRoles.isEmpty ||
        selecthowmanystylist.isEmpty ||
        selecthowmanystylist1.isEmpty ||
        selectextentionmethod.isEmpty ||
        selecteducation.isEmpty ||
        selectpreviously.isEmpty) {
      return;
    }

    // =========================
    // Form is valid
    // =========================

  }

}