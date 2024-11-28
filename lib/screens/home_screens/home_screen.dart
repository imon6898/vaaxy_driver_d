import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaaxy_driver/global/global_var.dart';
import 'package:vaaxy_driver/services/network/signar_connection.dart';
import '../../routes/app_routes.dart';
import '../../utlis/pref/pref.dart';
import '../auth_screens/login_screen.dart';
import 'home_controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  RxBool isRideCardVisible = false.obs;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (controller) {
      Uint8List? decodedImage = controller.decodedImage;

      return Scaffold(
        body: Stack(
          children: [
            if(controller.positionOfUser.value!=null)Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: controller.isRideCardVisible.value
                  ? MediaQuery.of(context).size.height * 0.45
                  : 0,
              child: GoogleMap(
                padding: const EdgeInsets.only(top: 26),
                mapType: controller.currentMapType.value,
                myLocationEnabled: true,
                polylines: controller.polylineSet.value,
                markers: Set<Marker>.of(controller.markerSet.values),
                circles: controller.circleSet.value,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.positionOfUser.value!.latitude,
                    controller.positionOfUser.value!.longitude,
                  ),
                  zoom: 12,
                ),
                onMapCreated: controller.onMapCreated,
              ),
            ),
            // Card displaying rider information
            if (controller.isRideCardVisible.value)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Rider details
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.memory(
                                    base64Decode(controller.rideData['pictureBase64']),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.rideData['riderName'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        controller.rideData['phoneNumber'] ?? '',
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.phone, color: Colors.green),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Pickup: ${controller.rideData['from'] ?? ''}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Drop-off: ${controller.rideData['to'] ?? ''}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Distance',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse(controller.rideData['distance'].toString()).toStringAsFixed(2)}km',
                                      //'${controller.rideData['distance']} km',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Price',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse(controller.rideData['ridePrice'].toString()).toStringAsFixed(2)}',

                                      //'\$${controller.rideData['ridePrice']}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Start Ride Button
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  ),
                                  onPressed: () {
                                    controller.cancelRide();
                                  },
                                  child: const Text(
                                    'Cancel Ride',
                                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  ),
                                  onPressed: () {
                                    controller.startRide();
                                  },
                                  child: const Text(
                                    'Start Ride',
                                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 60,
              left: 20,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  size: 40,
                  progress: Tween(begin: 0.0, end: 1.0).animate(
                    controller.isSidebarOpen.value
                        ? const AlwaysStoppedAnimation(1.0)
                        : const AlwaysStoppedAnimation(0.0),
                  ),
                ),
                onPressed: () {
                  controller.toggleSidebar();
                },
              ),
            ),
            Positioned(
              left: 16.0,
              bottom: 25.0,
              child: GestureDetector(
                onTap: () {
                  controller.toggleMapType();
                },
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return controller.currentMapType.value == MapType.normal
                        ? Image.asset(
                      'assets/image/hybrid_map.jpg',
                      width: 30.0,
                      height: 30.0,
                    )
                        : Image.asset(
                      'assets/image/normal_map.jpg',
                      width: 30.0,
                      height: 30.0,
                    );
                  }),
                ),
              ),
            ),

            if(!controller.isRideCardVisible.value)Positioned(
              top: 60,
              left: 100,
              right: 100,
              child: Obx(() {
                if (controller.accountStatus.value == 'approved') {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Online Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isDriverOnline.value
                                ? Colors.green
                                : Colors.grey,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (!controller.isDriverOnline.value) {
                              // Show Modal Bottom Sheet to confirm going online
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          "GO TO ONLINE",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'You are about to go online, you will become available to receive trip requests from users.',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Cancel Button
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            // Ok Button
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              onPressed: () async {
                                                // Toggle the driver online status
                                                SignalRConnection.sendMessage(<Object>['gfttyjghu']);
                                                controller.toggleDriverOnlineStatus();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Online'),
                        ),
                      ),
                      // Offline Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isDriverOnline.value
                                ? Colors.black12
                                : Colors.redAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (controller.isDriverOnline.value) {
                              // Show Modal Bottom Sheet to confirm going offline
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          'GO TO OFFLINE',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'You are about to go offline, you will stop receiving new trip requests from users.',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Cancel Button
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            // Ok Button
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                // Toggle the driver offline status
                                                controller.toggleDriverOnlineStatus();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Offline'),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Handle UI when account status is pending or rejected
                  Color statusColor;
                  String statusText;
                  if (controller.accountStatus.value == 'pending') {
                    statusColor = Colors.yellow;
                    statusText = 'Account Pending';
                  } else if (controller.accountStatus.value == 'rejected') {
                    statusColor = Colors.red;
                    statusText = 'Account Rejected';
                  } else {
                    statusColor = Colors.grey;
                    statusText = 'Status Unknown';
                  }

                  return Container(
                    color: statusColor,
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        statusText,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                }
              }),
            ),


            // Sidebar
            Obx(() {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: controller.isSidebarOpen.value ? 0 : -350,
                top: 0,
                bottom: 0,
                child: Material(
                  elevation: 8,
                  child: Stack(
                    children: [
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              Get.isDarkMode
                                  ? "assets/image/drawer_background_image_black.png"
                                  : "assets/image/drawer_background_image.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: 350,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black12,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 50.0, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/myAccount');
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: decodedImage != null
                                                  // Display the image if decodedImage is not null
                                                      ? Image.memory(
                                                    decodedImage,
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : SvgPicture.asset(
                                                    "assets/svg/avatar-svgrepo-com.svg",  // Fallback SVG
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.driverName.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    const Row(
                                                      children: [
                                                        Icon(Icons.star,
                                                            color: Colors.yellow,
                                                            size: 16.0),
                                                        SizedBox(width: 4.0),
                                                        Text(
                                                          "4.8",
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      "Vehicle Name",
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        controller.toggleSidebar();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                trailing: const Icon(Icons.inbox_outlined,  color: Colors.blue,),
                                title: const Text('Inbox'),
                                onTap: () {
                                  // Handle sidebar menu tap
                                },
                              ),
                              ListTile(
                                title: const Text('Theme'),
                                trailing: const Icon(Icons.dark_mode_outlined),
                                onTap: () {
                                  controller.showPopupMenu(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Payment Settings'),
                                trailing: SvgPicture.asset(
                                  'assets/svg/payment_settings.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                onTap: () {
                                  Get.toNamed('/paymentSettingScreen');
                                },
                              ),
                              ListTile(
                                trailing: const Icon(Icons.settings),
                                title: const Text('Security and Password'),
                                onTap: () {
                                  // Handle sidebar menu tap
                                },
                              ),

                              ListTile(
                                title: const Text('Terms & Condition'),
                                trailing: SvgPicture.asset(
                                  'assets/svg/terms_condition.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                onTap: () {
                                  Get.toNamed('/webViewScreen', arguments: ["Terms And Condition", "https://www.termsfeed.com/blog/sample-terms-and-conditions-template/"]);
                                },
                              ),
                              ListTile(
                                title: const Text('Privacy Statements'),
                                trailing: SvgPicture.asset(
                                  'assets/svg/privecy.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                onTap: () {
                                  Get.toNamed('/webViewScreen', arguments: ["Privacy Statements", "https://www.termsfeed.com/blog/sample-terms-and-conditions-template/"]);
                                },
                              ),
                              ListTile(
                                title: const Text('Help & Support'),
                                trailing: SvgPicture.asset(
                                  'assets/svg/customer_service.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                onTap: () {
                                  Get.toNamed('/helpAndSupportScreen');
                                },
                              ),
                              ListTile(
                                title: const Text('Log Out'),
                                trailing: const Icon(Icons.logout),
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await Pref.removeAllLocalData();  // Clear all stored user data
                                  await prefs.clear();
                                  // Get.offAllNamed('/authSelectScreen');  // Navigate to the login screen
                                  Get.offAll(LoginScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Gray out and disable UI when account status is pending or rejected
            if (controller.accountStatus.value == 'pending' ||
                controller.accountStatus.value == 'rejected')
              Positioned.fill(
                child: Container(
                  color: Colors.black45.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      'Account ${controller.accountStatus.value == 'pending' ? 'is pending approval' : 'has been rejected'}.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

}
