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

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
  }

  void toggleMapType() {
    if (currentMapType.value == MapType.normal) {
      currentMapType.value = MapType.hybrid;
    } else {
      currentMapType.value = MapType.normal;
    }
  }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  Future<void> getCurrentLiveLocationofDriver(BuildContext context) async {
    Position positioneofDriver = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionofDriver = positioneofDriver;

    LatLng positionofDriverInLatLag = LatLng(
        currentPositionofDriver!.latitude, currentPositionofDriver!.longitude);

    // await CommonMethods.convertGeoGraphicCoOrdinatesIntoHumanReadableAddress(
    //     currentPositionofDriver!, context);

    CameraPosition cameraPosition = CameraPosition(
        target: positionofDriverInLatLag, zoom: 15);
    controllerGoogleMap!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }

  void toggleDriverOnlineStatus() {
    isDriverOnline.value = !isDriverOnline.value;
  }
}
