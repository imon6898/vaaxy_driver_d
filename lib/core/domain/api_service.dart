import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as res;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/utlis/pref/pref.dart';

import '../../di/user_di.dart';

class ApiService {
  late Dio _dio;
  UserDi userDi = Get.find<UserDi>();

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
    );

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    try {
      options.headers["Authorization"] = "Bearer ${userDi.authToken}";
    } catch (e) {
      log("Authorization header error = $e");
    }

    _dio = Dio(options);
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 290,
      ));
    }
  }

  Future<dynamic> get(String endpoint, [Map<String, dynamic>? params]) async {
    res.Response response;
    try {
      // Send the GET request with query parameters if provided
      response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } on res.DioException catch (e) {
      // Handle error
      errorHandle(e: e, requestMethod: "get = $endpoint");

      log("Get api error data = ${e.response}");
      log("Get api error data status code = ${e.response?.statusCode}");
      if (e.response?.statusCode == 401) {
        Pref.removeAllLocalData();
        //Get.offAllNamed(AppRoutes.LoginScreen);
      }

      Get.dialog(
        AlertDialog(
          title: Text('${e.response?.data['message'] ?? "timeout".tr}'),
          content: Text("${e.response?.data['error'] ?? 'serverTimeOutMsg'.tr}"),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> params, {Function()? beforeSend, required Function(dynamic data) onSuccess, required Function(dynamic error) onError,}) async {
    await _dio.put(endpoint, data: params).then((res) {
      onSuccess(res.data);
    }).catchError((error) {
      onError(error);
    });
  }

  Future<dynamic> post(String endpoint, dynamic params) async {
    res.Response response;
    try {

        response = await _dio.post(endpoint, data: params);

      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "post = $endpoint");
      log("check response Repo api service e = $e");
      log("check response Repo api service status code = ${e.response?.statusCode}");
      log("check response Repo api service e.message = ${e.message}");
      if (e.response?.statusCode == null) {
        //Get.offAllNamed(AppRoutes.LoginScreen);
      }

      log("check response Repo api service = ${e.response?.data['error']}");
    }
  }

  Future<dynamic> postTrue(String endpoint, dynamic params) async {
    res.Response response;
    try {
      response = await _dio.post(endpoint, data: params);
      return response.data;  // Return only the data from the response
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "post = $endpoint");
      log("Error in API request: $e");
      if (e.response != null) {
        log("Status code: ${e.response?.statusCode}");
        log("Response data: ${e.response?.data}");
      }
      return null;  // Return null or handle accordingly
    }
  }


  Future<dynamic> patch(String endpoint, dynamic params) async {
    res.Response response;
    try {
      response = await _dio.patch(endpoint, data: params);
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "patch = $endpoint");


      log("check response Repo api service patch method  = ${e.response?.data['error']}");
    }
  }

  Future<dynamic> delete(String endpoint) async {
    res.Response response;
    try {
      response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "delete= $endpoint");
      log("check response Repo api service = $e");
      log("check response Repo api service = ${e.response?.statusCode}");
      log("check response Repo api service = ${e.message}");

      log("check response Repo api service = ${e.response?.data['error']}");
    }
  }

  // Future<dynamic?> multipleFileUpload(
  //     String path, Map<String, dynamic> body,
  //     {required String key, required List<String> files}) async {
  //   FormData formData = FormData.fromMap(body);
  //   for (String file in files) {
  //     log("file: ${file.split("/").last}");
  //     formData.files.add(MapEntry(
  //         key, await MultipartFile.fromFile(file, filename: file.split("/").last)));
  //   }
  //
  //   try {
  //     final response = await _dio.post(path, data: formData);
  //     log("payload: ${formData.fields}\n$path --> $response");
  //     return response;
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       if (kDebugMode) {
  //         log(e.response!.data.toString());
  //         log(e.response!.headers.toString());
  //         log(e.response!.requestOptions.toString());
  //       }
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       if (kDebugMode) {
  //         log(e.requestOptions.toString());
  //         log(e.message);
  //       }
  //     }
  //     return null;
  //   }
  // }


  // Future multipleFileUpload(String path, Map<String, dynamic> body, {required String key, required List<String> files}) async {
  //   FormData formData = FormData.fromMap(body);
  //   for(String file in files) {
  //     print("file: ${file.split("/").last}");
  //     formData.files.addAll([MapEntry(key, await MultipartFile.fromFile(file, filename: file.split("/").last))]);
  //   }
  //   try{
  //     final response = await _dio.post(
  //       path,
  //       data: formData,
  //     );
  //     print("payload: ${formData.fields}\n$path --> $response");
  //     return response;
  //   }
  //   on DioException catch(e){
  //     if (e.response != null) {
  //       if (kDebugMode) {
  //         print(e.response!.data);
  //         print(e.response!.headers);
  //         print(e.response!.requestOptions);
  //       }
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       if (kDebugMode) {
  //         print(e.requestOptions);
  //         print(e.message);
  //       }
  //     }
  //   }
  // }


  Future<bool> multipleFileUpload(String path, Map<String, dynamic> body, {required Map<String, File> files}) async {
    var formData = res.FormData.fromMap(body);

    for (var entry in files.entries) {
      formData.files.add(MapEntry(
        entry.key,
        await res.MultipartFile.fromFile(entry.value.path, filename: entry.value.path.split("/").last),
      ));
    }

    try {
      final response = await _dio.post(path, data: formData);
      // Assuming the response is a boolean
      return response.data as bool;
    } on DioException catch (e) {
      errorHandle(e: e, requestMethod: "POST $path");
      return false; // Handle the error appropriately
    }
  }



}

errorHandle({required DioException e, required String requestMethod}) {
  log(" Api Request Method: $requestMethod");
  log(" Api Request Method: ${e.type}");
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      log("DioErrorType.connectTimeout");
      break;
    case DioExceptionType.sendTimeout:
      log("DioErrorType.sendTimeout");
      break;
    case DioExceptionType.receiveTimeout:
      log("DioErrorType.receiveTimeout");
      break;
    case DioExceptionType.cancel:
      log("DioErrorType.cancel");
      break;
    case DioExceptionType.connectionError:
      log("DioErrorType.cancel");
      break;
    case DioExceptionType.unknown:
      log("DioErrorType.other");
      break;
    case DioExceptionType.badCertificate:
      log("DioErrorType.badCertificate");

      // TODO: Handle this case.
      break;
    case DioExceptionType.badResponse:

      if(requestMethod.contains("/api/v1/send-otp") ){
        showErrorSnackbar(message: e.response?.data['message']['phone'][0]);
      }else if (requestMethod.contains("/api/v1/verify-otp")){
        showErrorSnackbar(message: e.response?.data['message']);
      }else if(requestMethod.contains("/api/v1/register")){
        showErrorSnackbar(message: e.response!.data['message'].toString());
      }else{
        showErrorSnackbar(message: e.type.name);
      }

      log("DioErrorType.badResponse ${e.response?.data['message']['phone'][0]}");
      log("DioErrorType.badResponse ${e.response?.data['message'] ?? "timeout"}");

      break;
  }
}

SnackbarController showErrorSnackbar({required String message}) {
  return Get.showSnackbar(
    GetSnackBar(
      title: 'Error',
      message: '$message',
      icon: Icon(Icons.error, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.slowMiddle,
    ),
  );
}



SnackbarController showSuccessSnackbar({required String message}) {
  return Get.showSnackbar(
    GetSnackBar(
      title: 'Success',
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black), // Set text color to black
      ),
      icon: Icon(Icons.check_circle, color: Colors.green),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent, // Make background transparent
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.slowMiddle,
    ),
  );
}

