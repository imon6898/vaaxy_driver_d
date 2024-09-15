import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaaxy_driver/global/global_var.dart';
import '../../routes/app_routes.dart';
import '../../utlis/pref/pref.dart';
import 'home_controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              padding: const EdgeInsets.only(top: 26),
              mapType: controller.currentMapType.value,
              myLocationEnabled: true,
              polylines: controller.polylineSet,
              markers: controller.markerSet,
              circles: controller.circleSet,
              initialCameraPosition: googlePlexInitialPosition,
              onMapCreated: (GoogleMapController mapController) {
                controller.controllerGoogleMap = mapController;
                controller.mapThemeMethods.updateMapTheme(mapController);
              },
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
            Positioned(
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
                              controller.toggleDriverOnlineStatus();
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          'Driver is now online',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
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
                              controller.toggleDriverOnlineStatus();
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
                        style: const TextStyle(
                            fontSize: 18, color: Colors.white),
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
                                                  child: SvgPicture.asset(
                                                    "assets/svg/avatar-svgrepo-com.svg",
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                const Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "User Name",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    Row(
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
                                                    Text(
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
                                  await Pref.removeAllLocalData();  // Clear all stored user data
                                  Get.offAllNamed('/authSelectScreen');  // Navigate to the login screen
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
