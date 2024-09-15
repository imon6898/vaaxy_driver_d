import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../weidget/custom_container.dart';
import '../../weidget/custom_shining_button.dart';
import '../../weidget/custom_swicher_row.dart';
import '../../weidget/custom_text_field.dart';
import '../../weidget/customsecondaryappbar.dart';
import 'controller/payment_setting_controller.dart';


class PaymentSettingScreen extends StatelessWidget {
  PaymentSettingScreen({Key? key}) : super(key: key);

  final PaymentSettingController paymentSettingController = Get.put(PaymentSettingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentSettingController>(builder: (paymentSettingController) {
    return Scaffold(
      appBar: CustomSecondaryAppbar(
        onPressed: () {
          Get.back();
        },
        title: "Payment Settings",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() {
                if (paymentSettingController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (paymentSettingController.isError.value) {
                  return Center(child: Text("Failed to load data"));
                } else {
                  return buildCreditCardUI(
                    cardholderName: paymentSettingController
                        .getcardholderNameController.text,
                    accountNumber: paymentSettingController
                        .getcardNumberController.text,
                    expiryDate: paymentSettingController
                        .getexpirationDateController.text,
                    cvv: paymentSettingController.getcvvController.text,
                  );
                }
              }),
              SizedBox(height: 16),
              CustomContainer(
                height: 400,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: paymentSettingController
                            .cardholderNameController,
                        hintText: 'Cardholder Name',
                        filled: false,
                        disableOrEnable: true,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: paymentSettingController
                            .cardNumberController,
                        labelText: 'Card Number',
                        hintText: 'Enter card number',
                        filled: false,
                        disableOrEnable: true,
                        keyboardType: TextInputType.number,
                        onChange: (value) {
                          paymentSettingController.cardType.value =
                              paymentSettingController.getCardType(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Card number is required';
                          } else if (value.length != 16) {
                            return 'Card number must be 16 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: paymentSettingController
                            .expirationDateController,
                        labelText: 'Expiration Date',
                        hintText: 'MM/YY',
                        filled: false,
                        disableOrEnable: true,
                        keyboardType: TextInputType.number,
                        onChange: (value) {
                          if (value.length == 2 && !value.contains('/')) {
                            paymentSettingController.expirationDateController
                                .text = value + '/';
                            paymentSettingController.expirationDateController
                                .selection = TextSelection.fromPosition(
                              TextPosition(offset: paymentSettingController
                                  .expirationDateController.text.length),
                            );
                          } else if (value.length == 3 &&
                              !value.contains('/')) {
                            paymentSettingController.expirationDateController
                                .text =
                                value.substring(0, 2) + '/' +
                                    value.substring(2);
                            paymentSettingController.expirationDateController
                                .selection = TextSelection.fromPosition(
                              TextPosition(offset: paymentSettingController
                                  .expirationDateController.text.length),
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Expiration date is required';
                          } else if (!RegExp(r'^\d\d/\d\d$').hasMatch(value)) {
                            return 'Invalid format (MM/YY)';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: paymentSettingController.cvvController,
                        labelText: 'CVV',
                        filled: false,
                        disableOrEnable: true,
                        keyboardType: TextInputType.number,
                        onChange: (value) {
                          if (value.length > 3) {
                            paymentSettingController.cvvController.text =
                                value.substring(0, 3);
                            paymentSettingController.cvvController.selection =
                                TextSelection.fromPosition(
                                  TextPosition(offset: paymentSettingController
                                      .cvvController.text.length),
                                );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'CVV is required';
                          } else if (value.length != 3) {
                            return 'CVV must be 3 digits';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomSwitchRow(
                title: 'Same As Profile',
                switchValue: paymentSettingController.sameLoginAddress,
                toggleFunction: paymentSettingController.toggleAddress,
              ),
              Column(
                children: [
                  CustomTextField(
                    controller: paymentSettingController
                        .streetAddressController,
                    hintText: 'Street Address',
                    filled: false,
                    disableOrEnable: true,
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: paymentSettingController.cityController,
                    hintText: 'City',
                    filled: false,
                    disableOrEnable: true,
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: paymentSettingController.stateController,
                    hintText: 'State',
                    filled: false,
                    disableOrEnable: true,
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: paymentSettingController.zipCodeController,
                    hintText: 'Zip Code',
                    filled: false,
                    disableOrEnable: true,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    controller: paymentSettingController.countryController,
                    hintText: 'Country',
                    filled: false,
                    disableOrEnable: true,
                  ),
                  SizedBox(height: 20),
                  ShinyButton(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    onTap: () {
                     // paymentSettingController.submit(context);
                    },
                    color: Color(0xff95D4E5),
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
  }

  Widget buildCreditCardUI({
    required String cardholderName,
    required String accountNumber,
    required String expiryDate,
    required String cvv,
  }) {
    // Check if account number is at least 8 digits long to format correctly
    String formattedAccountNumber;
    if (accountNumber.length >= 8) {
      formattedAccountNumber = '${accountNumber.substring(0, 4)} **** **** ${accountNumber.substring(accountNumber.length - 4)}';
    } else {
      formattedAccountNumber = accountNumber; // Fallback to show the unformatted number if too short
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1E99), Color(0xFF3E3E99)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card Holder Name: ${cardholderName}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() => paymentSettingController.getCardTypeIcon(
                  paymentSettingController.cardType.value)),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "AccountNumber: ${formattedAccountNumber}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Expiry Date: ${expiryDate}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                'CVV: $cvv',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
