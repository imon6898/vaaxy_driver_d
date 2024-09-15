import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../weidget/customsecondaryappbar.dart';
import 'help_support_controller.dart';


class SupportDetailsScreen extends StatelessWidget {
  const SupportDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpAndSupportController>(builder: (controller) {
      return Scaffold(
        appBar: CustomSecondaryAppbar(
          title: "support".tr,
          onPressed: () {
            Get.back();
          },
        ),
        body: controller.isLoadingSupportDetails.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.supportDetails.length,
          itemBuilder: (context, index) {
            final supportDetail = controller.supportDetails[index];
            return CustomCard(
              name: supportDetail.name,
              message: supportDetail.message,
              createdAt: supportDetail.createdAt,
            );
          },
        ),
      );
    });
  }
}


class CustomCard extends StatelessWidget {
  final String name;
  final String message;
  final DateTime? createdAt;

  const CustomCard({
    Key? key,
    required this.name,
    required this.message,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_demo.png'), // Replace with your own image asset
                radius: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1000,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          timeFormat.format(createdAt ?? DateTime.now()), // Format time
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey, // Change color as needed
                            ),
                          ),
                        ),
                        Text(
                          dateFormat.format(createdAt ?? DateTime.now()), // Format date
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(thickness: .5, color: Colors.blue),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

