

import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/Notification_impl.dart';
import 'package:vaaxy_driver/data/network/notification_api_service.dart';

class NotificationRepo {
  NotificationApiService notificationApiService = NotificationImpl();

  Future<dynamic>? updateMarkAllNotificationRepo() async {
    dynamic responseData = await notificationApiService.updateMarkAllNotification(ApiConstant.endPointNotificationMarked);
    return responseData = responseData.data;
  }

  Future<dynamic>? notificationStatusUpdateByIDRepo(Map<String, dynamic> params) async {
    dynamic responseData = await notificationApiService.notificationStatusUpdateByID(ApiConstant.endPointNotificationUpdate, params);
    return responseData = responseData.data;
  }

  Future<dynamic>? getAllNotificationRepo() async {
    dynamic responseData = await notificationApiService.getAllNotification(ApiConstant.endPointGetAllNotification);
    return responseData = responseData.data;
  }

}
