
import 'dart:async';

import 'package:flutter/services.dart';
export 'together_ad_splash_view.dart';
export 'together_ad_method_callback.dart';
export 'together_ad_fullscreen.dart';

class FlutterTogetherAd {
  static const MethodChannel _channel = MethodChannel('com.xujiaji.togetherad/main');
  /// 是否开启debug模式
  static bool isDebug = true;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 穿山甲初始化
  static Future<bool?> csjInit({required String appId, required String type}) async {
    return await _channel.invokeMethod("csjInit", {
      "appId": appId,
      "type": type,
      "isDebug": isDebug
    });
  }

  /// 穿山甲广告id别名对应表
  static Future<bool?> csjIdMap(Map<String, String> idAliasMap) async {
    return await _channel.invokeMethod("csjIdAliasMap", idAliasMap);
  }

}
