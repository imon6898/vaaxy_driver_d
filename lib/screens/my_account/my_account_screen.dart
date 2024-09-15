import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/my_account_controller.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Account"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileOverview(context),
                const SizedBox(height: 20),
                _buildAccountStatus(context),
                const SizedBox(height: 20),
                _buildContactInformation(context),
                const SizedBox(height: 20),
                _buildVehicleInformation(context),
                const SizedBox(height: 20),
                _buildOperationalDetails(context),
                const SizedBox(height: 20),
                _buildPersonalization(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileOverview(BuildContext context) {
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.png'),
              // You can use Image.network for a remote image
            ),
          ),
          SizedBox(height: 10),
          Text("Name: John Doe", style: TextStyle(fontSize: 16)),
          Text("Rating: ⭐⭐⭐⭐ (4.5)", style: TextStyle(fontSize: 16)),
          Text("Rides Completed: 120", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildAccountStatus(BuildContext context) {
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
          const Text(
            "Status: Approved", // Or "Pending" based on the account's status
            style: TextStyle(
              fontSize: 16,
              color: Colors.green, // Change color based on status
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInformation(BuildContext context) {
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
          const Text("Phone Number: (123) 456-7890", style: TextStyle(fontSize: 16)),
          const Text("Email Address: johndoe@example.com", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildVehicleInformation(BuildContext context) {
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
          const Text("Make and Model: Toyota Camry", style: TextStyle(fontSize: 16)),
          const Text("License Plate: ABC1234", style: TextStyle(fontSize: 16)),
          const Text("Color: Blue", style: TextStyle(fontSize: 16)),
          const Text("Insurance: Valid until 12/2024", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildOperationalDetails(BuildContext context) {
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
          const Text("Driver ID: DR123456", style: TextStyle(fontSize: 16)),
          const Text("Status: Available", style: TextStyle(fontSize: 16)),
          const Text("Earnings: \$500 (Last Week)", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          const Text("Trip History:", style: TextStyle(fontSize: 16)),
          // You can add a ListView here for trip details
        ],
      ),
    );
  }

  Widget _buildPersonalization(BuildContext context) {
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
          const Text("Bio: Experienced driver with a passion for providing excellent service.", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          const Text("Vehicle Photo:", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[300],
            child: const Center(child: Text("Upload Vehicle Photo")),
          ),
        ],
      ),
    );
  }
}
