abstract class  NotificationApiService {
  Future<dynamic> notificationStatusUpdateByID(String url,Map<String, dynamic> params);
  Future<dynamic> getAllNotification(String url);
  Future<dynamic> updateMarkAllNotification(String url);
}