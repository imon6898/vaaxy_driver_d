import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/auth_screens/login_screen.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/select_auth_screens/select_auth_screen.dart';
import 'package:vaaxy_driver/screens/auth_screens/signup_screen.dart';
import 'package:vaaxy_driver/screens/home_screens/home_screen.dart';
import 'package:vaaxy_driver/screens/mail_otp_screens/mail_sent_otp_screen.dart';
import 'package:vaaxy_driver/screens/my_account/my_account_screen.dart';
import 'package:vaaxy_driver/screens/my_account/my_account_screen.dart';
import 'package:vaaxy_driver/screens/phone_otp_screens/phone_sent_otp_screen.dart';
import 'package:vaaxy_driver/screens/splash_screens/splash_screen.dart';
import '../screens/help_and_support_screens/help_support_screen.dart';
import '../screens/help_and_support_screens/support_details_screen.dart';
import '../screens/my_account/my_account_screen.dart';
import '../screens/my_account/my_account_screen.dart';
import '../screens/my_account/my_account_screen.dart';
import '../screens/payment_settings_screens/payment_settings_screen.dart';
import '../screens/web_view_screens/web_view_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.AuthSelectScreen,
      page: () => const AuthSelectScreen(),
    ),

    GetPage(
      name: AppRoutes.LoginScreen,
      page: () => const LoginScreen(),
    ),

    GetPage(
      name: AppRoutes.PhoneSentOtpScreen,
      page: () => const PhoneSentOtpScreen(),
    ),


    GetPage(
      name: AppRoutes.MailSentOtpScreen,
      page: () => const MailSentOtpScreen(),
    ),


    GetPage(
      name: AppRoutes.SignupScreen,
      page: () => const SignupScreen(),
    ),

    GetPage(
      name: AppRoutes.HomeScreen,
      page: () => const HomeScreen(),
    ),

    GetPage(
      name: AppRoutes.WebViewScreen,
      page: () => const WebViewScreen(),
    ),

    GetPage(
      name: AppRoutes.MyAccount,
      page: () => const MyAccount(),
    ),

    GetPage(
      name: AppRoutes.PaymentSettingScreen,
      page: () =>  PaymentSettingScreen(),
    ),

    GetPage(
      name: AppRoutes.HelpAndSupportScreen,
      page: () =>  HelpAndSupportScreen(),
    ),

    GetPage(
      name: AppRoutes.SupportDetailsScreen,
      page: () =>  SupportDetailsScreen(),
    ),

  ];
}
