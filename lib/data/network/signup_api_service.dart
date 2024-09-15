import 'dart:io';

abstract class SignupApiService {
  Future<dynamic> signUpDriver(String url, Map<String, dynamic> params, Map<String, File> files);
}
