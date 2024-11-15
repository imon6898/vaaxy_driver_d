import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';


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
          ElevatedButton(onPressed: () {}, child: Text(
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