import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/select_auth_screens/auth_controller.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/login_controller.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/signup_controller.dart';
import 'package:vaaxy_driver/screens/home_screens/home_controllers/home_controller.dart';
import 'package:vaaxy_driver/screens/mail_otp_screens/controller/mail_otp_controller.dart';
import 'package:vaaxy_driver/screens/phone_otp_screens/controller/phone_otp_controller.dart';
import 'package:vaaxy_driver/screens/splash_screens/controller/splash_controller.dart';

class ViewModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController(), fenix: true);
    Get.lazyPut<AuthSelectController>(() => AuthSelectController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<MailOtpController>(() => MailOtpController(), fenix: true);
    Get.lazyPut<PhoneOtpController>(() => PhoneOtpController(), fenix: true);
    Get.lazyPut<SignupController>(() => SignupController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    // Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    // Get.lazyPut<HomeScreenController>(() => HomeScreenController(), fenix: true);
    // Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
    // Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
    // Get.lazyPut<SupportScreenController>(() => SupportScreenController(), fenix: true);
    // Get.lazyPut<MoreScreenController>(() => MoreScreenController(), fenix: true);
    // Get.lazyPut<BuyTripPassScreenController>(() => BuyTripPassScreenController(), fenix: true);
    // Get.lazyPut<MyAccountController>(() => MyAccountController(), fenix: true);
    // Get.lazyPut<MyGalleryController>(() => MyGalleryController(), fenix: true);
    // Get.lazyPut<MyVehiclesController>(() => MyVehiclesController(), fenix: true);
    // Get.lazyPut<UsagesHistoryScreenController>(() => UsagesHistoryScreenController(), fenix: true);
    // Get.lazyPut<RegisterForNewVehicleController>(() => RegisterForNewVehicleController(), fenix: true);
    // Get.lazyPut<QrCodeCollectionController>(() => QrCodeCollectionController(), fenix: true);
    // Get.lazyPut<WebViewScreenController>(() => WebViewScreenController(), fenix: true);
    // Get.put(UserDi());
    // Get.put(NotificationControllerForApp());
  }
}