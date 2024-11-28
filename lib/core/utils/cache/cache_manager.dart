import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  static SharedPreferences? _pref;

  static Future<void> initAuth(Function(SharedPreferences) onComplete) async {
    _pref = await SharedPreferences.getInstance();
    onComplete(_pref!);
  }


  // Getters with logs for debugging
  static String get token {
    var value = _getFromCache<String>(CacheKeys.token.name);
    print("Token: $value");
    return value;
  }

  static String get id {
    var value = _getFromCache<String>(CacheKeys.id.name);
    print("ID: $value");
    return value;
  }

  static String get email {
    var value = _getFromCache<String>(CacheKeys.email.name);
    print("Email: $value");
    return value;
  }

  static String get firstName {
    var value = _getFromCache<String>(CacheKeys.firstName.name);
    print("First Name: $value");
    return value;
  }

  static String get signUpAs {
    var value = _getFromCache<String>(CacheKeys.signUpAs.name);
    print("Sign Up As: $value");
    return value;
  }

  static String get driverId {
    var value = _getFromCache<String>(CacheKeys.driverId.name);
    print("Driver Id As: $value");
    return value;
  }

  static String get pictureBase64 {
    var value = _getFromCache<String>(CacheKeys.pictureBase64.name);
    print("Picture Base64: $value");
    return value ?? ""; // Handle null gracefully
  }



  // static String get token => _getFromCache<String>(CacheKeys.token.name);
  // static String get id => _getFromCache<String>(CacheKeys.id.name);
  // static String get email => _getFromCache<String>(CacheKeys.email.name);
  // static String get firstName => _getFromCache<String>(CacheKeys.firstName.name);
  // static String get signUpAs => _getFromCache<String>(CacheKeys.signUpAs.name);
  // static String get driverId => _getFromCache<String>(CacheKeys.driverId.name);




  static Future<bool> setToken(String tokenValue) async => await _saveToCache(CacheKeys.token.name, tokenValue);
  static Future<bool> setId(String id) async => await _saveToCache(CacheKeys.id.name, id);
  static Future<bool> setEmail(String email) async => await _saveToCache(CacheKeys.email.name, email);
  static Future<bool> setFirstName(String firstName) async => await _saveToCache(CacheKeys.firstName.name, firstName);
  static Future<bool> setSignUpAs(String signUpAs) async => await _saveToCache(CacheKeys.signUpAs.name, signUpAs);
  static Future<bool> setDriverId(String driverId) async => await _saveToCache(CacheKeys.driverId.name, driverId);
  static Future<bool> setPictureBase64(String pictureBase64Value) async => await _saveToCache(CacheKeys.pictureBase64.name, pictureBase64);

  static Future<bool> removeToken() async => _remove(CacheKeys.token.name);
  static Future<bool> removeId() async => _remove(CacheKeys.id.name);
  static Future<bool> removeEmail() async => _remove(CacheKeys.email.name);
  static Future<bool> removeFirstName() async => _remove(CacheKeys.firstName.name);
  static Future<bool> removeSignUpAs() async => _remove(CacheKeys.signUpAs.name);
  static Future<bool> removeDriverId() async => _remove(CacheKeys.driverId.name);
  static Future<bool> removePictureBase64() async => _remove(CacheKeys.pictureBase64.name);

  // Helper function to remove a value from cache
  static Future<bool> _remove(String key) async {
    if (_pref == null) {
      return false;
    }
    if (!_pref!.containsKey(key)) {
      return false;
    }
    return await _pref!.remove(key);
  }

  // Helper function to get data from cache
  static dynamic _getFromCache<T>(String key) {
    print("$T ${key} getting type: int -> ${T == int} | bool -> ${T == bool} | string -> ${T == String}");
    if (_pref == null) return '';
    if (T == int) {
      return _pref!.getInt(key) ?? 0;
    } else if (T == bool) {
      return _pref!.getBool(key) ?? false;
    }
    return _pref!.getString(key) ?? '';
  }

  // Helper function to save data to cache
  static Future<bool> _saveToCache(String key, dynamic value) async {
    print("${value.runtimeType} ${key} _saveToCache type: int -> ${value is int} | bool -> ${value is bool} | string -> ${value is String}");
    if (_pref == null || value == null) return false;
    if (value is bool) {
      return await _pref!.setBool(key, value);
    } else if (value is int) {
      return await _pref!.setInt(key, value);
    }
    return await _pref!.setString(key, value);
  }

}

enum CacheKeys {
  token,
  id,
  email,
  firstName,
  signUpAs,
  driverId,
  pictureBase64
}