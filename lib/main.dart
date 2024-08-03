import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/firebase_options.dart';
import 'package:vaaxy_driver/routes/app_pages.dart';
import 'package:vaaxy_driver/routes/app_routes.dart';
import 'package:vaaxy_driver/utlis/notification_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vaaxy_driver/utlis/text_const.dart';

import 'binding/view_model_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          translations: TextConst(),
          locale: const Locale('en', 'UK'),
          // translations will be displayed in that locale
          initialBinding: ViewModelBinding(),
          title: 'VaaXY Driver',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          // initialRoute: AppRoutes.WelcomeScreen,
          initialRoute: AppRoutes.SplashScreen,
          getPages: AppPages.list,
        );
      },
    );
  }
}

