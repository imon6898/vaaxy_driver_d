
import 'package:vaaxy_driver/core/domain/api_service.dart';
import 'package:vaaxy_driver/data/network/app_api_service.dart';

class AppImpl extends AppApiService {


  ///Driver getCreditCardByUserId
  @override
  Future<Map<String, dynamic>> getCreditCardByUserId(String url, Map<String, dynamic> params) async {
    // Make the GET request with the endpoint URL and query parameters if any
    final response = await ApiService().get(url);
    return response.data; // Ensure this is a Map<String, dynamic>
  }
}

