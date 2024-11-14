class ApiRoutes {

  // static const baseUrl = "http://air.goldengroup-bd.com:89";
  static const baseUrl = "https://api.goldengroup-bd.com";
  static const String prefix = "$baseUrl/api";
  static const login = "/login";
  static getRouteTemplateByDistributor(String id) => '/get-route-template-by-distributor/$id';
}