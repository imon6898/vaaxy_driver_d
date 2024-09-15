
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//
// import '../appinfo/app_info.dart';
// import '../global/global_var.dart';
// import '../models/address_model.dart';
// import '../models/direction_details.dart';

class CommonMethods
{
  checkConnectivity(BuildContext context) async
  {
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult != ConnectivityResult.mobile && connectionResult != ConnectivityResult.wifi)
    {
      if(!context.mounted) return;
      displaySnackBar("Your Internet is not Available. Check Your connection. Try Again.", context);
    }
  }
  displaySnackBar(String messageText, BuildContext context)
  {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static sendRequestToAPI(String apiUrl) async
  {
    http.Response responseFromAPI = await http.get(Uri.parse(apiUrl));

    try{
      if(responseFromAPI.statusCode == 200)
      {
        String dataFromApi = responseFromAPI.body;
        var dataDecoded = jsonDecode(dataFromApi);
        return dataDecoded;
      }
      else
      {
        return "Error";
      }
    }
    catch(errorMsg)
    {
      return "Error";
    }
  }

  // /// Reverse GeoCoding
  // static Future<String> convertGeoGraphicCoOrdinatesIntoHumanReadableAddress(Position position, BuildContext context) async
  // {
  //   String humanReadableAddress = "";
  //   String apiGeoCodingUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleMapKey";
  //
  //   var responseFromAPI = await sendRequestToAPI(apiGeoCodingUrl);
  //
  //   if (responseFromAPI != "error") {
  //     try {
  //       humanReadableAddress = responseFromAPI["results"][0]["formatted_address"];
  //       print("humanReadableAddress = " + humanReadableAddress);
  //
  //       AddressModel model =  AddressModel();
  //       model.humanReadableAddress = humanReadableAddress;
  //       model.placeName = humanReadableAddress;
  //       model.latitudePosition = position.latitude;
  //       model.longitudePosition = position.longitude;
  //
  //       Provider.of<AppInfo>(context, listen: false).updatePickUpLocation(model);
  //     } catch (e) {
  //       print("Error parsing API response: $e");
  //     }
  //   } else {
  //     print("Error in API response");
  //   }
  //
  //   return humanReadableAddress;
  // }
  //
  // /// Direction Api
  // static Future<DirectionDetails?> getDirectionDetailsFromApi(LatLng source, LatLng destination) async
  // {
  //   String urlDirectionAPI = "https://maps.googleapis.com/maps/api/directions/json?destination=${destination.latitude},${destination.longitude}&origin=${source.latitude},${source.longitude}&mode=driving&key=$googleMapKey";
  //
  //   var responseFromDirectionsAPI = await sendRequestToAPI(urlDirectionAPI);
  //
  //   if(responseFromDirectionsAPI == "error")
  //   {
  //     return null;
  //   }
  //
  //   DirectionDetails detailsModel = DirectionDetails();
  //
  //   detailsModel.distanceTextString = responseFromDirectionsAPI["routes"][0]["legs"][0]["distance"]["text"];
  //   detailsModel.distanceValueDigits = responseFromDirectionsAPI["routes"][0]["legs"][0]["distance"]["value"];
  //
  //   detailsModel.durationTextString = responseFromDirectionsAPI["routes"][0]["legs"][0]["duration"]["text"];
  //   detailsModel.durationValueDigits = responseFromDirectionsAPI["routes"][0]["legs"][0]["duration"]["value"];
  //
  //   detailsModel.encodedPoints = responseFromDirectionsAPI["routes"][0]["overview_polyline"]["points"];
  //
  //   return detailsModel;
  // }
  //
  //
  // calculateFareAmount(DirectionDetails directionDetails)
  // {
  //   double distancePerKmAmount = 18;
  //   double durationPerMinuteAmount = 2;
  //   double baseFareAmount = 2;
  //
  //   double totalDistanceTravelFareAmount = (directionDetails.distanceValueDigits! / 1000) * distancePerKmAmount;
  //   double totalDurationSpendFareAmount = (directionDetails.durationValueDigits! / 60) * durationPerMinuteAmount;
  //
  //   double overAllTotalFareAmount = baseFareAmount + totalDistanceTravelFareAmount + totalDurationSpendFareAmount;
  //
  //   return overAllTotalFareAmount.toStringAsFixed(0);
  // }
  //
  //
  //
  //
  //
  //
  //
  // displaySnackBarGreen(String messageText, BuildContext context)
  // {
  //   var snackBar = SnackBar(content: Text(messageText),backgroundColor: Colors.green,);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
  // displaySnackBarRed(String messageText, BuildContext context)
  // {
  //   var snackBar = SnackBar(content: Text(messageText),backgroundColor: Colors.red,);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }


}



/*static Future<String> convertGeoGraphicCoOrdinatesIntoHumanReadableAddress(Position position, BuildContext context) async
  {

    String humanReadableAddress = "";

    String apiGeoCodingUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlag=${position.latitude},${position.longitude}&key=$googleMapKey";

    var responseFromAPI = await sendRequestToAPI(apiGeoCodingUrl);

    if(responseFromAPI != "error")
      {
        humanReadableAddress = responseFromAPI["results"][0]["formatted_address"];
        print("humanReadableAddress = " + humanReadableAddress);

        AddressModel model =  AddressModel();
        model.humanReadableAddress = humanReadableAddress;
        model.latitudePosition = position.latitude;
        model.longitudePosition = position.longitude;

        Provider.of<AppInfo>(context, listen: false).updatePickUpLocation(model);
      }

    return humanReadableAddress;
  }*/