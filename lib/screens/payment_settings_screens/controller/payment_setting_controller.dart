import 'dart:convert';
import 'dart:developer';
import 'dart:developer';
import 'dart:developer';
import 'dart:developer';
import 'dart:developer';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:vaaxy_driver/core/utils/cache/cache_manager.dart';

import '../../../Repository/app_repo.dart';
import '../../../model/get_credit_card_by_userId.dart';


class PaymentSettingController extends GetxController {
  var cardType = ''.obs;

  TextEditingController getcardholderNameController = TextEditingController();
  TextEditingController getcardNumberController = TextEditingController();
  TextEditingController getexpirationDateController = TextEditingController();
  TextEditingController getcvvController = TextEditingController();

  TextEditingController cardholderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  RxBool sameLoginAddress = false.obs; // Track toggle state
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;

  String getCardType(String cardNumber) {
    if (cardNumber.startsWith(RegExp(r'4'))) {
      return 'Visa';
    } else if (cardNumber.startsWith(RegExp(r'5[1-5]'))) {
      return 'Mastercard';
    } else if (cardNumber.startsWith(RegExp(r'3[47]'))) {
      return 'American Express';
    } else if (cardNumber.startsWith(RegExp(r'6'))) {
      return 'Discover';
    } else {
      return 'Unknown';
    }
  }

  Widget getCardTypeIcon(String cardType) {
    switch (cardType) {
      case 'Visa':
        return SvgPicture.asset(
          'assets/svg/visa-svgrepo-com.svg',
          height: 16,
        );
      case 'Mastercard':
        return SvgPicture.asset(
          'assets/svg/mastercard-svgrepo-com.svg',
          height: 16,
        );
      case 'American Express':
        return SvgPicture.asset(
          'assets/svg/amex-svgrepo-com.svg',
          height: 16,
        );
      default:
        return Container();
    }
  }

  final AppRepo _appRepo = AppRepo();

  @override
  void onInit() {
    super.onInit();
    log("id: ${CacheManager.id}");
    log("token: ${CacheManager.token}");
    log("email: ${CacheManager.email}");
    log("firstName: ${CacheManager.firstName}");
    log("signUpAs: ${CacheManager.signUpAs}");
    log("driverIdAs: ${CacheManager.driverId}");
    fetchCardDetails();
  }


  Future<void> fetchCardDetails() async {
    isLoading(true);
    try {
      final Map<String, dynamic> responseData = await _appRepo.getCreditCardByUserId(CacheManager.id);
      if (responseData != null) {
        final cardDetails = GetCreditCardByUserIdModel.fromJson(responseData);

        // Update the UI with fetched data
        getcardholderNameController.text = cardDetails.cardholderName ?? '';
        getcardNumberController.text = cardDetails.cardNumber ?? '';
        getexpirationDateController.text = cardDetails.expiDate ?? '';
        getcvvController.text = cardDetails.cardSecurityCode ?? '';

        cardType.value = getCardType(cardDetails.cardNumber ?? '');
      }
    } catch (e) {
      isError(true);
      log('Error fetching card details: $e');
    } finally {
      isLoading(false);
    }
  }






  Future<void> toggleAddress() async {
    sameLoginAddress.toggle(); // Toggle the boolean

    if (sameLoginAddress.value) {

    } else {
      // Clear address fields
      streetAddressController.clear();
      cityController.clear();
      stateController.clear();
      zipCodeController.clear();
      countryController.clear();
    }
  }

  bool _validateFields() {
    if (cardholderNameController.text.isEmpty ||
        cardNumberController.text.isEmpty ||
        expirationDateController.text.isEmpty ||
        cvvController.text.isEmpty ||
        streetAddressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        zipCodeController.text.isEmpty) {
      return false;
    }

    if (cardNumberController.text.length != 16 ||
        !RegExp(r'^\d{16}$').hasMatch(cardNumberController.text)) {
      return false;
    }

    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expirationDateController.text)) {
      return false;
    }

    if (cvvController.text.length != 3 ||
        !RegExp(r'^\d{3}$').hasMatch(cvvController.text)) {
      return false;
    }

    return true;
  }
}
