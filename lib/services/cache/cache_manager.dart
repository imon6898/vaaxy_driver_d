import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  static SharedPreferences? _pref;

  static Future<void> initAuth(Function(SharedPreferences) onComplete) async {
    _pref = await SharedPreferences.getInstance();
    onComplete(_pref!);
  }


  static String get token => _getFromCache<String>(CacheKeys.token.name);
  static bool get working => _getFromCache<bool>(CacheKeys.working.name);
  static String get languageCode => _getFromCache<String>(CacheKeys.languageCode.name);
  static String get countryCode => _getFromCache<String>(CacheKeys.countryCode.name);



  static Future<bool> setToken(String tokenValue) async => await _saveToCache(CacheKeys.token.name, tokenValue);
  static Future<bool> setWorking(bool value) async => await _saveToCache(CacheKeys.working.name, value);
  static Future<bool> setLanguageCode(String languageCodeValue) async => await _saveToCache(CacheKeys.languageCode.name, languageCodeValue);
  static Future<bool> setCountryCode(String countryCodeValue) async => await _saveToCache(CacheKeys.countryCode.name, countryCodeValue);

  static Future<bool> removeToken() async => _remove(CacheKeys.token.name);
  static Future<bool> removeWorking() async => _remove(CacheKeys.working.name);

  static Future<bool> _remove(String key) async {
    if(_pref == null) {
      return false;
    }
    if(!_pref!.containsKey(key)) {
      return false;
    }
    return await _pref!.remove(key);
  }

  static dynamic _getFromCache<T>(String key) {
    print("$T ${key} getting type: int -> ${T == int} | bool -> ${T == bool} | string -> ${T == String}");
    if(_pref == null) return '';
    if(T == int) {
      return  _pref!.getInt(key) ?? 0;
    }else if(T == bool) {
      return  _pref!.getBool(key) ?? false;
    }
    return  _pref!.getString(key) ?? '';
  }

  static Future<bool> _saveToCache(String key, dynamic value) async {
    print("${value.runtimeType} ${key} _saveToCache type: int -> ${value is int} | bool -> ${value is bool} | string -> ${value is String}");

    if(_pref == null || value == null) return false;
    if(value is bool) {
      return await _pref!.setBool(key, value);
    }else if(value is int) {
      return await _pref!.setInt(key, value);
    }
    return await _pref!.setString(key, value);
  }

}

enum CacheKeys {
  token,
  working,
  languageCode,
  countryCode
}