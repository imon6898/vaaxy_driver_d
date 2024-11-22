import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:vaaxy_driver/services/api_service.dart';
import 'package:vaaxy_driver/services/network/http_requests.dart';

import '../../screens/my_account/controller/my_account_controller.dart';

class SignalRConnection {
  static HubConnection? connection;
  static init(){
    connection = HubConnectionBuilder().withUrl('http://74.208.201.247:443/api/v1/notificationHub',
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        )).build();

    startListening();
  }

  static startListening() async {
    if(connection == null){
      return;
    }
    await connection!.start();

    connection!.on('ReceiveNotification', (message) {
      print("ReceiveMessage: ${message.toString()}");
      if(message == null) {
        return;
      }
      if(message!.isEmpty) {
        return;
      }
      List targetMessage = message.first;
      if(targetMessage.isEmpty) {
        return;
      }
      print("targetMessage: ${targetMessage.first}");
      Map finalMessage = targetMessage.first ?? {};
      Get.dialog(AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have new ride request',
              style: TextStyle(
                 color: Colors.green,
                 fontWeight: FontWeight.w600,
                 fontSize: 16
              ),
            )
          ],
        ),
        actions: [
          ElevatedButton(onPressed: () async {
            MyAccountController myAccount = Get.put(MyAccountController());
            await Future.delayed(const Duration(seconds: 5));
            var result = await HttpRequests.post("${BaseUrl.baseUrl}/api/v1/driver-approve",body: json.encode( {
              {
                "riderId": "${finalMessage['riderId']}",
                "driverInfoList": [
                  {
                    "driverId": myAccount.driverId.toString(),
                    "userId": myAccount.userId.toString(),
                    "driverName": myAccount.driverId.toString(),
                    "email": myAccount.email.toString(),
                    "phoneNumber": myAccount.phoneNumber.toString(),
                    "gender": myAccount.gender.toString(),
                    "picture": myAccount.picture.toString(),
                    "pictureBase64": myAccount.picture.toString(),
                    "licenseNumber": myAccount.licenseNumber.toString(),
                    "launchhYear": myAccount.launchYear.toString(),
                    "color": myAccount.color.toString(),
                    "modal": myAccount.modal.toString(),
                    "brand": myAccount.brand.toString(),
                    "numberPlate": myAccount.numberPlate.toString(),
                    "expirationDate": myAccount.expirationDate.toString(),
                    "rattingLower": "5",
                    "rattingUpper": '5'
                  }
                ]
              }
            }));
            print('accept result Result: $result');
          }, child: Text(
            'Accept',
            style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.w600,
               fontSize: 16
            ),
          )),
          ElevatedButton(onPressed: () {}, child: Text(
            'Reject',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16
            ),
          ))
        ],
      ));
      print("ReceiveMessage: ${targetMessage!.first}");
    });
  }
}