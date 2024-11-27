class ApiRoutes {

  // static const baseUrl = "http://air.goldengroup-bd.com:89";
  static const baseUrl = "http://74.208.201.247:443";
  static const String prefix = "$baseUrl/api";
  static const login = "/login";
  static getRouteTemplateByDistributor(String id) => '/get-route-template-by-distributor/$id';
}