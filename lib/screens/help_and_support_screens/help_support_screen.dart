import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaaxy_driver/screens/help_and_support_screens/support_details_screen.dart';

import '../../routes/app_routes.dart';
import '../../weidget/LoadingOverlay.dart';
import '../../weidget/customsecondaryappbar.dart';
import 'help_support_controller.dart';


class HelpAndSupportScreen extends StatelessWidget {
  HelpAndSupportScreen({Key? key}) : super(key: key);

  final HelpAndSupportController controller = Get.put(HelpAndSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSecondaryAppbar(
        onPressed: () {
          Get.back();
        },
        title: "Help & Support",
      ),
      body: Obx(() {
        if (controller.isLoadingContactInfo.value || controller.isLoadingSupportData.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'If you are facing any issues, please contact us by calling +8809611-767676 (8am-10pm) or emailing us at care.ihossain6898@orion-group.net.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setSelectedButton(0);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedButton.value == 0 ? const Color(0xFF164194) : Colors.grey,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Create Support',
                            style: TextStyle(color: controller.selectedButton.value == 0 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Changed to width for Row
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setSelectedButton(1);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              controller.selectedButton.value == 1 ? const Color(0xFF164194) : Colors.grey,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Support History',
                            style: TextStyle(color: controller.selectedButton.value == 1 ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 16),
                Obx(() {
                  if (controller.selectedButton.value == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Select Issue',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          items: controller.dropdownValue
                              .map((value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                              .toList(),
                          hint: Text('Select an item'),
                          value: controller.dropdownValue[controller.selectedDropIndex.value],
                          onChanged: (newValue) {
                            controller.onDropdownValueChange(newValue!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Explain Your Issue',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: controller.issueDescriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color(0xffE8E8E8)),
                            ),
                            hintText: "Describe your issue",
                            hintStyle: TextStyle(color: Color(0xff8D8D8F)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Obx(() => LoadingOverlay(
                            isLoading: controller.isSubmitting.value,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: controller.isSubmitButtonEnabled.value
                                    ? () {
                                  controller.addSupport(
                                      controller.dropdownValue[controller.selectedDropIndex.value],
                                      controller.issueDescriptionController.text);
                                }
                                    : null,
                                child: Text("Submit"),
                              ),
                            ),
                          )),
                        ),
                      ],
                    );
                  } else {
                    final fetchAllSupportModel = controller.supportData;
                    if (fetchAllSupportModel.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final timeFormat = DateFormat.jm();
                          final dateFormat = DateFormat('dd/MM/yyyy');
                          final supportData = fetchAllSupportModel[index];
                          return IssueCard(
                            title: supportData.title,
                            time: timeFormat.format(supportData.createdAt),
                            date: "${supportData.createdAt.day}/${supportData.createdAt.month}/${supportData.createdAt.year}",
                            statusText: supportData.status,
                            messageCount: supportData.messageCount,
                            onTap: () {
                              controller.fetchDemoSupportDetails();
                              Get.toNamed(AppRoutes.SupportDetailsScreen, arguments: supportData.id);
                            },
                          );
                        },
                        itemCount: fetchAllSupportModel.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      );
                    } else {
                      return SizedBox(); // or return a placeholder widget or a loading indicator
                    }
                  }
                }),
              ],
            ),
          );
        }
      }),
    );
  }
}

class IssueCard extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String statusText;
  final VoidCallback onTap;
  final int messageCount;

  const IssueCard({
    required this.title,
    required this.time,
    required this.date,
    required this.statusText,
    required this.onTap,
    required this.messageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                //statusView(statusText: statusText),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                InkWell(
                  onTap: onTap,
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  "assets/svg/message_icon.svg",
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 4.0),
                Text(
                  messageCount.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
