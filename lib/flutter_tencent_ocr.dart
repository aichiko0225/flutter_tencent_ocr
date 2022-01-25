
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterTencentOcr {
  static const MethodChannel _channel = MethodChannel('flutter_tencent_ocr');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}