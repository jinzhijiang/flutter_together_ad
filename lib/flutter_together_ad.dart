
import 'dart:async';

import 'package:flutter/services.dart';
export 'together_ad_splash_view.dart';

class FlutterTogetherAd {
  static const MethodChannel _channel = MethodChannel('com.xujiaji.togetherad/main');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
