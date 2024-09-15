class ApiConstant {

  //BASE URL
  static const String baseUrl = "http://74.208.201.247:443";

  //END POINT
  static const String sendOtpPhone = "/api/v1/send-otp-phone";
  static const String verifyOtpPhone = "/api/v1/verify-otp-phone";

  static const String sendOtpMail = "/api/v1/send-otp-email";
  static const String verifyOtpMail = "/api/v1/verify-otp-email";

  static const String signInDriver = "/api/v1/login";
  static const String signUpDriver = "/api/v1/signUp-driver";

  static const String setCreditCardByUserId = "/api/v1/credit-card-setup";
  static const String getCreditCardByUserId = "/api/v1/get-credit-card-by-userId";





  static const String endPointSendOTP= "/api/v1/send-otp";
  static const String endPointSubmitOTP= "/api/v1/verify-otp";
  static const String endPointRegister= "/api/v1/register";
  static const String endPointGetVehicle= "/api/v1/vehicle";
  static const String endPointDeleteVehicle= "/api/v1/vehicle/";
  static const String endPointAddVehicle= "/api/v1/vehicle";
  static const String endPointGetContactInfo= "/api/v1/contact-info";
  static const String endPointAddSupport= "/api/v1/add-support";
  static const String endPointGetAllSupport= "/api/v1/support";
  static const String endPointGetGetSupportDetails= "/api/v1/support-detail/#supportId#";


  static const String endPointGetAllNotification= "/api/v1/notification";
  static const String endPointNotificationUpdate= "/api/v1/notification-status-update";
  static const String endPointNotificationMarked= "/api/v1/notification-mark-all-as-read";


  static const String endPointGetMyProfile= "/api/v1/profile";
  static const String endPointGetOffers= "/api/v1/get-offers";
  static const String endPointGetQrCollectionPoint= "/api/v1/qr-collection-point";

  static const String endPointGetPassPrice= "/api/v1/get-pass-price?passes=#passesID#";
  static const String endPointGetQRCodeCollectionPoint= "/api/v1/qr-collection-point";
  static const String endPointGetTransactionHistory= "/api/v1/get-transaction-history";
  static const String endPointGetUsageHistory= "";
  static const String endPointGeGallery= "/api/v1/gallery";





  static const String endPointLogOut= "/api/v1/logout";


}