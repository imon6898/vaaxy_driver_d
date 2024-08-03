import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaaxy_driver/global/global_var.dart';
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
              padding: EdgeInsets.only(top: 26),
              mapType: controller.currentMapType.value,
              myLocationEnabled: true,
              polylines: controller.polylineSet,
              markers: controller.markerSet,
              circles: controller.circleSet,
              initialCameraPosition: googlePlexInitialPosition,
              onMapCreated: (GoogleMapController mapController) {
                controller.controllerGoogleMap = mapController;
                //controller.googleMapCompletercontroller.complete(controller.controllerGoogleMap);

                //Update map theme based on dark mode setting
                controller.mapThemeMethods.updateMapTheme(mapController);

                // Pass the context here
                //controller.getCurrentLiveLocationofUser(context);
              },
            ),
            Obx(() {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: controller.isSidebarOpen.value ? 0 : -250, // Sidebar width
                top: 0,
                bottom: 0,
                child: Material(
                  elevation: 8,
                  child: Container(
                    width: 250, // Sidebar width
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () {
                            // Handle sidebar menu tap
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            // Handle sidebar menu tap
                          },
                        ),
                        // Add more menu items here
                      ],
                    ),
                  ),
                ),
              );
            }),
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: Tween(begin: 0.0, end: 1.0).animate(
                    controller.isSidebarOpen.value
                        ? AlwaysStoppedAnimation(1.0)
                        : AlwaysStoppedAnimation(0.0),
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
              right: 16,
              child: Obx(() {
                return FloatingActionButton(
                  onPressed: () {
                    if (controller.isDriverOnline.value) {
                      // Handle offline logic here
                      controller.toggleDriverOnlineStatus();
                    } else {
                      // Handle online logic here
                      controller.toggleDriverOnlineStatus();
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Driver is now online',
                                  style: TextStyle(fontSize: 18),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  backgroundColor: controller.isDriverOnline.value ? Colors.red : Colors.green,
                  child: Icon(controller.isDriverOnline.value ? Icons.cloud_off : Icons.cloud_queue),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
