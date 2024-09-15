import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/web_view_screens/web_view_screen_controller.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../weidget/LoadingOverlay.dart';
import '../../weidget/customsecondaryappbar.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewScreenController>(builder: (controller) {
      return Scaffold(
        appBar: CustomSecondaryAppbar(
          onPressed: () {
            Get.back();
          },
          title: controller.title,
        ),
        body: LoadingOverlay(
          isLoading: controller.isLoading,
          child: WebViewWidget(controller: controller.webController),
        ),
      );
    });
  }
}
