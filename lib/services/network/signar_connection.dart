import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:vaaxy_driver/photo-base-64.dart';
import 'package:vaaxy_driver/screens/home_screens/home_controllers/home_controller.dart';
import 'package:vaaxy_driver/screens/home_screens/rider_Info_dialog.dart';
import 'package:vaaxy_driver/services/api_service.dart';
import 'package:vaaxy_driver/services/network/http_requests.dart';

import '../../screens/my_account/controller/my_account_controller.dart';
import '../../utlis/pref/pref.dart';

class SignalRConnection {
  static HubConnection? connection;
  static HomeController homeController = Get.put(HomeController());
  static init() {
    connection = HubConnectionBuilder()
        .withUrl(
            'http://74.208.201.247:443/api/v1/notificationHub',
            HttpConnectionOptions(
              logging: (level, message) => print(message),
            ))
        .build();

    startListening();
  }

  static startListening() async {
    if (connection == null) {
      return;
    }
    await connection!.start();

    connection!.on('ReceiveNotification', (message) {
      print("ReceiveMessage: ${message.toString()}");
      if (message == null) {
        return;
      }
      if (message!.isEmpty) {
        return;
      }
      List targetMessage = message.first;
      if (targetMessage.isEmpty) {
        return;
      }
      print("targetMessage: ${targetMessage.first}");
      Map finalMessage = targetMessage.first ?? {};
      homeController.rideData = finalMessage;
      Get.dialog(
          RiderInfoDialog(
          riderData: homeController.rideData as Map<String, dynamic>,
          onAccept: () => homeController.approveRequest("${finalMessage['riderId']}"),
          onReject: () {
            Get.back();
            homeController.cancelRide();},
      ),
          barrierDismissible: false
      );
      print("ReceiveMessage: ${targetMessage!.first}");
    });
  }

  static sendMessage(List<Object> data) async {
    final result =
        await connection!.invoke("ReceiveApprovalNotification", args: data);
    print('invoke ReceiveApprovalNotification: $result');
  }
}
