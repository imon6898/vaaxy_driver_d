

import 'package:vaaxy_driver/core/domain/api_service.dart';
import 'package:vaaxy_driver/data/network/notification_api_service.dart';

class NotificationImpl extends NotificationApiService {


  @override
  Future getAllNotification(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future notificationStatusUpdateByID(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future updateMarkAllNotification(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }
}
