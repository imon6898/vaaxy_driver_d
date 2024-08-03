import 'package:flutter/foundation.dart';

void devPrint(String logMessage, {String? tag}) {
  if (kDebugMode) tag != null ? print(logMessage) : print("$tag => $logMessage");
}
