//import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
//String userID = FirebaseAuth.instance.currentUser!.uid;
//String googleMapKey = "AIzaSyB6-msHcoCjg_BmE4swmhMdDPKBD9zesks";//"AIzaSyANojwy5oioz4xdHRm3ORDPUh89cfzt4B0";
String googleMapKey = "AIzaSyCef4A4prSy0xx2JGG2YEe1PEjxgJvRgEo";//"AIzaSyANojwy5oioz4xdHRm3ORDPUh89cfzt4B0";
String serverKeyFCM = "key=AAAAVINg-2I:APA91bG-716tdiPwuWKslwDmbHFGU1NHSvqDXuN0A25v2VBYxnI3xsYT30cb-4ISWLzlsWtYzLpRbCOxlhTa_A7hScvY-7uaPtEJ2wSC9hsV-vtt8EIeY10tUUgz-w8gfLIapeNSqs1O";//"AIzaSyANojwy5oioz4xdHRm3ORDPUh89cfzt4B0";
 CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(23.777176, 90.399452),
  zoom: 14.4746,
);

