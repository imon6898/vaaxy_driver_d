import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../config/api_routes.dart';
import '../../utlis/utils.dart';
import '../cache/cache_manager.dart';

class HttpRequests {

  static bool isLogin = false, isWorking = false;
  static String _token = "";


  static void logout() {
    CacheManager.removeToken();
    CacheManager.removeWorking();
    _token = CacheManager.token;
    isWorking = CacheManager.working;
    isLogin = _token.isEmpty ? false : true ;
  }

  static Future init() async {
    await CacheManager.initAuth((p) {
      _token = CacheManager.token;
      isWorking = CacheManager.working;
      isLogin = _token.isEmpty ? false : true ;
    });

    print("the token: $_token");
  }

  static String setToken(String token) {
    CacheManager.setToken(token);
    isLogin = token.isEmpty ? false : true ;
    _token = token;
    return _token;
  }

  static Future post(String path, {body}) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
    var request = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: body
    );

    print("$path-> ${request.body}");

    if(request.statusCode == 400) {
      return jsonDecode(request.body);
    }

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }

  static Future postJson(String path, {body}) async {
    try{
      Uri uri = Uri.parse(path);
      var request = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: body);

      print("$path-> ${request.body}");

      if (request.statusCode == 400) {
        return jsonDecode(request.body);
      }

      if (request.statusCode != 200) {
        return;
      }

      return jsonDecode(request.body);
    }catch(e) {
      MainUtils.showErrorSnackBar("Something went wrong!");
      return;
    }
  }

  static Future get(String path) async {
    Uri uri = Uri.parse(path);
    var request = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
    );

    print("uri: $uri Res: ${request.body}");

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }




  static Future multipartPostRequest(String path, {File? file, required Map<String, String> body}) async {
    try {
      Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
      var request = http.MultipartRequest('POST', uri)
        ..headers['Accept'] = "application/json"
        ..headers['Authorization'] = "Bearer $_token";

      request.fields.addAll(body);

      print("payloads: ${request.fields}");

      if(file != null){
        request.files.add(
            http.MultipartFile.fromBytes(
                "image",
                file.readAsBytesSync(),
                filename: file.path.split("/").last)
        );
      }
      var response = (await http.Response.fromStream(await request.send()));
      print("multipartPostRequest: ${response.body}");
      if(response.statusCode != 200) {
        return;
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('error due to post leave');
      return;
    }
  }

  static Future filesMultipartPostRequest(String path, { Map<String, File> files = const {}, required Map<String, String> body}) async {
    try {
      Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
      var request = http.MultipartRequest('POST', uri)
        ..headers['Accept'] = "application/json"
        ..headers['Authorization'] = "Bearer $_token";

      request.fields.addAll(body);

      print("payloads: ${request.fields}");

      if(files.isNotEmpty){
        files.forEach((key, file) {
          request.files.add(
              http.MultipartFile.fromBytes(
                  key,
                  file.readAsBytesSync(),
                  filename: file.path.split("/").last)
          );
        });
      }
      var response = (await http.Response.fromStream(await request.send()));
      print("$path --> ${response.body}");
      if(response.statusCode != 200) {
        return;
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('error due to post leave');
      return;
    }
  }


}