
import 'dart:async';

import 'package:flutter/services.dart';

import 'ocr_process_config.dart';
import 'ocr_api_key.dart';

class TencentOcr {
  static const MethodChannel _channel = MethodChannel('flutter_tencent_ocr');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化友配置 
  /// 全局只需要调用一次
  static Future<bool> initOcrSDKConfig(
    OcrApiKey appkey,
  ) async {
    bool result = await _channel.invokeMethod(
      'initOcrSDKConfig',
      {
        "appkey": appkey.toMap(),
      },
    );
    return result;
  }

  static Future<bool> startProcessOcr(OcrProcessConfig config) async {
    bool result = await _channel.invokeMethod(
      'startProcessOcr',
      {
        "config": config.toMap(),
      },
    );
    return result;
  }
}
