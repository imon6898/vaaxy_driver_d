import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HelpAndSupportController extends GetxController {
  final isLoadingContactInfo = true.obs;
  final isLoadingSupportData = true.obs;

  final RxInt selectedButton = 0.obs;
  final RxList<String> dropdownValue = ['Option 1', 'Option 2', 'Option 3'].obs;
  final RxInt selectedDropIndex = 0.obs;
  final issueDescriptionController = TextEditingController();

  final isSubmitButtonEnabled = false.obs;
  final isLoadingSupportDetails = false.obs;
  final isSubmitting = false.obs;

  // Demo data lists
  final RxList<ContactInfo> contacts = <ContactInfo>[].obs;
  final RxList<SupportData> supportData = <SupportData>[].obs;
  final RxList<SupportDetail> supportDetails = <SupportDetail>[].obs;

  @override
  void onClose() {
    issueDescriptionController.removeListener(onTextFieldChange);
    issueDescriptionController.dispose();
    super.onClose();
  }

  void onDropdownValueChange(String newValue) {
    selectedDropIndex.value = dropdownValue.indexOf(newValue);
    _checkSubmitButtonState();
  }

  void onTextFieldChange() {
    _checkSubmitButtonState();
  }

  void _checkSubmitButtonState() {
    isSubmitButtonEnabled.value = selectedDropIndex.value != null && issueDescriptionController.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch demo data
    fetchDemoContactInfo();
    fetchDemoSupportData();
    fetchDemoSupportDetails();

    issueDescriptionController.addListener(onTextFieldChange);
  }

  void setSelectedButton(int i) {
    selectedButton.value = i;
  }

  void fetchDemoContactInfo() async {
    isLoadingContactInfo.value = true; // Set loading state
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay

    // Populate demo contact info
    contacts.addAll([
      ContactInfo(contactName: 'John Doe', contactEmail: 'john.doe@example.com', contactPhone: '+1234567890'),
      ContactInfo(contactName: 'Jane Smith', contactEmail: 'jane.smith@example.com', contactPhone: '+9876543210'),
      ContactInfo(contactName: 'Alice Brown', contactEmail: 'alice.brown@example.com', contactPhone: '+1112223333'),
      ContactInfo(contactName: 'Bob Johnson', contactEmail: 'bob.johnson@example.com', contactPhone: '+4445556666'),
      ContactInfo(contactName: 'Eve White', contactEmail: 'eve.white@example.com', contactPhone: '+7778889999'),
    ]);

    isLoadingContactInfo.value = false; // Set loading state
  }

  void fetchDemoSupportData() async {
    isLoadingSupportData.value = true; // Set loading state
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay

    // Populate demo support data
    supportData.addAll([
      SupportData(id: 1, title: 'Issue 1', createdAt: DateTime.now().subtract(Duration(days: 2)), status: 'Open', messageCount: 3),
      SupportData(id: 2, title: 'Issue 2', createdAt: DateTime.now().subtract(Duration(days: 5)), status: 'Closed', messageCount: 5),
      SupportData(id: 3, title: 'Issue 3', createdAt: DateTime.now().subtract(Duration(days: 7)), status: 'Pending', messageCount: 2),
    ]);

    isLoadingSupportData.value = false; // Set loading state
  }

  void fetchDemoSupportDetails() async {
    supportDetails.clear(); // Clear previous details
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay

    // Populate demo support details
    supportDetails.addAll([
      SupportDetail(name: 'John Doe', message: 'Lorem ipsum dolor sit amet.', createdAt: DateTime.now().subtract(Duration(hours: 2))),
      SupportDetail(name: 'Jane Smith', message: 'Consectetur adipiscing elit.', createdAt: DateTime.now().subtract(Duration(hours: 1))),
      SupportDetail(name: 'Alice Brown', message: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', createdAt: DateTime.now().subtract(Duration(minutes: 30))),
    ]);
  }

  void addSupport(String selectedValue, String description) {
    isSubmitting.value = true; // Set submitting state
    // Simulate API call delay
    Future.delayed(Duration(seconds: 2), () {
      // Upon success, reset fields and update UI
      isSubmitting.value = false;
      issueDescriptionController.clear();
      selectedDropIndex.value = 0;
    });
  }
}





class ContactInfo {
  final String contactName;
  final String contactEmail;
  final String contactPhone;

  ContactInfo({
    required this.contactName,
    required this.contactEmail,
    required this.contactPhone,
  });
}

class SupportData {
  final int id;
  final String title;
  final DateTime createdAt;
  final String status;
  final int messageCount;

  SupportData({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.status,
    required this.messageCount,
  });
}

class SupportDetail {
  final String name;
  final String message;
  final DateTime createdAt;

  SupportDetail({
    required this.name,
    required this.message,
    required this.createdAt,
  });
}

