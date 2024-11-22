import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/my_account_controller.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Account"),
            ),
            body: controller.isProfileLoading.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileOverview(context, controller),
                    const SizedBox(height: 20),
                    _buildAccountStatus(context, controller),
                    const SizedBox(height: 20),
                    _buildContactInformation(context, controller),
                    const SizedBox(height: 20),
                    _buildVehicleInformation(context, controller),
                    const SizedBox(height: 20),
                    _buildOperationalDetails(context, controller),
                    const SizedBox(height: 20),
                    _buildPersonalization(context, controller),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildProfileOverview(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(controller.picture.value ?? ''),
            ),
          ),
          const SizedBox(height: 10),
          Text("Name: ${controller.firstName.value ?? ''} ${controller.lastName.value ?? ''}",
              style: const TextStyle(fontSize: 16)),
          Text("Rating: ⭐⭐⭐⭐ (4.5)", style: const TextStyle(fontSize: 16)),
          Text("Rides Completed: 120", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildAccountStatus(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Account Status", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(
            "Status: Approved", // Or "Pending" based on the account's status
            style: const TextStyle(
              fontSize: 16,
              color: Colors.green, // Change color based on status
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contact Information", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Phone Number: ${controller.phoneNumber.value ?? ''}", style: const TextStyle(fontSize: 16)),
          Text("Email Address: ${controller.email.value ?? ''}", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildVehicleInformation(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vehicle Information", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Make and Model: ${controller.modal.value ?? ''}", style: const TextStyle(fontSize: 16)),
          Text("License Plate: ${controller.numberPlate.value ?? ''}", style: const TextStyle(fontSize: 16)),
          Text("Color: ${controller.color.value ?? ''}", style: const TextStyle(fontSize: 16)),
          Text("Insurance: Valid until ${controller.expirationDate.value ?? ''}", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildOperationalDetails(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Operational Details", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Driver ID: ${controller.driverId.value ?? ''}", style: const TextStyle(fontSize: 16)),
          Text("Status: Available", style: const TextStyle(fontSize: 16)),
          Text("Earnings: \$500 (Last Week)", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPersonalization(BuildContext context, MyAccountController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personalization", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const Text("Bio: Experienced driver with a passion for providing excellent service.",
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          const Text("Vehicle Photo:", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                controller.vehicleCopy.value ?? 'Upload Vehicle Photo',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
