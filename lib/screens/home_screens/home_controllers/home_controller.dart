import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaaxy_driver/methods/map_theme_methods.dart';

class HomeController extends GetxController {
  var isSidebarOpen = false.obs;
  String stateOfApp = "normal";
  List<LatLng> polylineCoOrdinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  GoogleMapController? controllerGoogleMap;
  MapThemeMethods mapThemeMethods = MapThemeMethods();
  Position? currentPositionofDriver;
  Rx<MapType> currentMapType = MapType.normal.obs;
  var isDriverOnline = false.obs;
  var accountStatus = 'approved'.obs;

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
  }

  void toggleMapType() {
    if (currentMapType.value == MapType.normal) {
      currentMapType.value = MapType.hybrid;
      update();
    } else {
      currentMapType.value = MapType.normal;
      update();
    }
  }

  Future<void> showPopupMenu(BuildContext context) async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          value: 'light_mode',
          child: ListTile(
            leading: Icon(Icons.light_mode),
            title: Text('Light Mode'),
          ),
        ),
        PopupMenuItem(
          value: 'dark_mode',
          child: ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'light_mode') {
        Get.changeTheme(ThemeData.light());
        String lightMapStyle = await mapThemeMethods.getJsonFileFromThemes("assets/json/light_style.json");
        controllerGoogleMap!.setMapStyle(lightMapStyle);
        update();
      } else if (value == 'dark_mode') {
        Get.changeTheme(ThemeData.dark());
        String darkMapStyle = await mapThemeMethods.getJsonFileFromThemes("assets/json/dark_style.json");
        controllerGoogleMap!.setMapStyle(darkMapStyle);
        update();
      }
    });
  }


  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getCurrentLiveLocationofDriver(BuildContext context) async {
    Position positioneofDriver = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionofDriver = positioneofDriver;

    LatLng positionofDriverInLatLag = LatLng(
        currentPositionofDriver!.latitude, currentPositionofDriver!.longitude);

    CameraPosition cameraPosition = CameraPosition(
        target: positionofDriverInLatLag, zoom: 15);
    controllerGoogleMap!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }

  void toggleDriverOnlineStatus() {
    isDriverOnline.value = !isDriverOnline.value;
  }
}
