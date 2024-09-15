import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class MapThemeMethods {
  void updateMapTheme(GoogleMapController controller) {
    String mapStylePath = Get.isDarkMode ? "assets/json/dark_style.json" : "assets/json/light_style.json";
    getJsonFileFromThemes(mapStylePath).then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  void setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }
}
