
import 'package:flutter/services.dart';
import 'package:flutter_together_ad/flutter_together_ad.dart';

class TogetherAdReward {
  final tag = DateTime.now().millisecondsSinceEpoch.toString();
  static const _channel = MethodChannel('com.xujiaji.togetherad/reward');
  String alias;
  TogetherRewardCallback? callback;

  TogetherAdReward({required this.alias, this.callback}) {
    _channel.setMethodCallHandler(_callHandler);
  }

  Future<bool> load() async {
    return await _channel.invokeMethod("load", {"alias": alias, "tag": tag});
  }

  Future<bool> loadAndShow() async {
    return await _channel.invokeMethod("loadAdnShow", {"alias": alias, "tag": tag});
  }

  Future<bool> show() async {
    return await _channel.invokeMethod("show", {"alias": alias, "tag": tag});
  }

  Future<dynamic> _callHandler(MethodCall call) async {
    final args = call.arguments;
    if (args['tag'] != tag) {
      print('非当前tag的广告，不做处理');
      return;
    }
    switch(call.method) {
      case "onAdStartRequest":
        callback?.onAdStartRequest!(args['providerType']);
        break;
      case "onAdFailedAll":
        callback?.onAdFailedAll!(args['failedMsg']);
        break;
      case "onAdFailed":
        callback?.onAdFailed!(args['providerType'], args['failedMsg']);
        break;
      case "onAdLoaded":
        callback?.onAdLoaded!(args['providerType']);
        break;
      case "onAdClicked":
        callback?.onAdClicked!(args['providerType']);
        break;
      case "onAdShowed":
        callback?.onAdShowed!(args['providerType']);
        break;
      case "onAdVideoCached":
        callback?.onAdVideoCached!(args['providerType']);
        break;
      case "onAdVideoComplete":
        callback?.onAdVideoComplete!(args['providerType']);
        break;
      case "onAdDismissed":
        callback?.onAdDismissed!(args['providerType']);
        break;
      case "onAdRewardVerify":
        callback?.onAdRewardVerify!(args['providerType']);
    }
  }
}