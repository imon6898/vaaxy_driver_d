abstract class  SupportApiService {
  Future<dynamic> getContactInfo(String url);
  Future<dynamic> addSupport(String url,Map<String, dynamic> params);
  Future<dynamic> getAllSupport(String url);
  Future<dynamic> getSupportDetails(String url);
}