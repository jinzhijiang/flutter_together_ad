
import 'dart:async';

import 'package:flutter/services.dart';
export 'together_ad_splash_view.dart';
export 'together_method_callback.dart';

class FlutterTogetherAd {
  static const MethodChannel _channel = MethodChannel('com.xujiaji.togetherad/main');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool?> csjInit({required String appId, required String type, bool isDebug = true}) async {
    return await _channel.invokeMethod("csjInit", {
      "appId": appId,
      "type": type,
      "isDebug": isDebug
    });
  }

  static Future<bool?> csjIdMap(Map<String, String> idAliasMap) async {
    return await _channel.invokeMethod("csjIdAliasMap", idAliasMap);
  }

  static Future<String?> get tests async {
    return "";
  }
}
