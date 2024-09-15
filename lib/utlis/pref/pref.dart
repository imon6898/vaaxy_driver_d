import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class Pref {
  static const String notifications = 'notifications';
  static const String authToken = "authToken";
  static const String userName = "userName";
  static const String userPhoneNumber = "userPhoneNumber";
  static const String userProfilePicture = "userProfilePicture"; // Added key for profile picture

  static String getValue(String keyWord) {
    final box = GetStorage();
    return box.read(keyWord) ?? "";
  }

  static Future<void> setValue(String keyWord, String value) async {
    final box = GetStorage();
    await box.write(keyWord, value);
  }

  static Future<void> removeValue(String keyWord) async {
    final box = GetStorage();
    await box.remove(keyWord);
  }

  /// Save an object as a JSON string.
  static Future<void> setObject(String keyWord, dynamic object) async {
    final box = GetStorage();
    await box.write(keyWord, json.encode(object));
  }

  /// Retrieve an object from JSON string.
  static dynamic getObject(String keyWord) {
    try {
      final box = GetStorage();
      final String? jsonString = box.read(keyWord);
      return jsonString != null ? json.decode(jsonString) : null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> removeAllLocalData() async {
    final box = GetStorage();
    await box.erase();
  }
}
