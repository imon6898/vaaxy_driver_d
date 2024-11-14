import '../../core/domain/api_service.dart';
import '../network/home_api_service.dart';

class HomeImpl extends HomeApiService {
  final ApiService _apiService = ApiService();

  @override
  Future<dynamic> goOnlineOffline(String url, Map<String, dynamic> params) async {
    final response = await _apiService.post(url, params);
    return response;
  }
}