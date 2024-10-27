import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vaaxy_driver/methods/map_theme_methods.dart';
import '../../../Repository/home_repo.dart';
import '../../../core/utils/cache/cache_manager.dart';
import '../../../global/global_var.dart';
import '../../../model/online_nearby_drivers.dart';
import '../../../services/network/http_requests.dart';

class HomeController extends GetxController {
  var isSidebarOpen = false.obs;
  String stateOfApp = "normal";
  List<LatLng> polylineCoOrdinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  RxString humanReadableAddress = RxString('');
  GoogleMapController? controllerGoogleMap;
  MapThemeMethods mapThemeMethods = MapThemeMethods();
  Rx<Position?> positionOfUser = Rx<Position?>(null);
  Rx<MapType> currentMapType = MapType.normal.obs;
  List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  bool nearbyOnlineDriversKeysLoaded = false;

  var isDriverOnline = false.obs;
  var accountStatus = 'approved'.obs;

  final HomeRepo homeRepo = HomeRepo();

  @override
  void onInit() {
    getCurrentLiveLocationOfUser();
    super.onInit();
  }

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

  getCurrentLiveLocationOfUser() async {
    positionOfUser(await _determinePosition());
    initializeGeoFireListener();
    var responseFromAPI = await HttpRequests.get(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${positionOfUser.value?.latitude},${positionOfUser.value?.longitude}&key=$googleMapKey"
    );
    if(responseFromAPI != null) {
    }
    humanReadableAddress(responseFromAPI["results"][0]["formatted_address"] ?? '');
    LatLng positionofDriverInLatLag = LatLng(positionOfUser.value!.latitude, positionOfUser.value!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: positionofDriverInLatLag, zoom: 15);
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  initializeGeoFireListener() {
    Geofire.initialize("onlineDrivers");
    double radius = 22;
    Geofire.queryAtLocation(positionOfUser.value!.latitude, positionOfUser.value!.longitude, radius)!.listen((driverEvent) {
      if (driverEvent != null) {
        switch (driverEvent["callBack"]) {
          case Geofire.onKeyEntered:
            nearbyOnlineDriversList.add(OnlineNearbyDrivers(
                uidDriver: driverEvent["key"],
                latDriver: driverEvent["latitude"],
                lngDriver: driverEvent["longitude"]
            ));
            if (nearbyOnlineDriversKeysLoaded == true) {
              // if(Get.isRegistered<HireController>()) {
              //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
              // }
            }
            break;

          case Geofire.onKeyExited:
            removeDriverFromList(driverEvent["key"]);
            // if(Get.isRegistered<HireController>()) {
            //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
            // }
            break;

          case Geofire.onKeyMoved:
            updateOnlineNearbyDriversLocation(OnlineNearbyDrivers(
                uidDriver: driverEvent["key"],
                latDriver: driverEvent["latitude"],
                lngDriver: driverEvent["longitude"]
            ));
            // if(Get.isRegistered<HireController>()){
            //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
            // }
            break;

          case Geofire.onGeoQueryReady:
            nearbyOnlineDriversKeysLoaded = true;
            // if(Get.isRegistered<HireController>()) {
            //   Get.find<HireController>().updateAvailableNearbyOnlineDriversOnMap(); //update drivers on google map
            // }
            break;
        }
      }
    });
  }

  void removeDriverFromList(String driverID)
  {
    int index = nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == driverID);

    if(nearbyOnlineDriversList.isNotEmpty)
    {
      nearbyOnlineDriversList.removeAt(index);
    }
  }

  void updateOnlineNearbyDriversLocation(OnlineNearbyDrivers nearbyOnlineDriverInformation)
  {
    int index = nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);

    nearbyOnlineDriversList[index].latDriver = nearbyOnlineDriverInformation.latDriver;
    nearbyOnlineDriversList[index].lngDriver = nearbyOnlineDriverInformation.lngDriver;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  // void toggleDriverOnlineStatus() {
  //   isDriverOnline.value = !isDriverOnline.value;
  // }


  Future<void> toggleDriverOnlineStatus() async {
    if (positionOfUser.value != null) {
      // Set up parameters based on current online status
      Map<String, dynamic> params = {
        "driverId": CacheManager.driverId,
        "userId": CacheManager.id,
        "status": isDriverOnline.value ? "offline" : "online",
        "latitude": positionOfUser.value!.latitude,
        "longitude": positionOfUser.value!.longitude,
        "isOnline": isDriverOnline.value ? "0" : "1",
      };

      // Make the API call to go online/offline
      final response = await homeRepo.goOnlineOfflineRepo(params);

      if (response != null && response.statusCode == 200) { // Checking for 200 status code
        // Toggle the online status since the API call was successful
        isDriverOnline.value = !isDriverOnline.value;

        // Show confirmation based on new status
        Get.snackbar(
            'Success',
            isDriverOnline.value ? 'You are now online' : 'You are now offline'
        );
      } else {
        // Show error message if the API call was unsuccessful
        Get.snackbar('Error', 'Failed to update status');
      }
    } else {
      // Handle location error
      Get.snackbar('Location Error', 'Unable to get your current location');
    }
  }

}
