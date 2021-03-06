import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'together_ad_method_callback.dart';

class TogetherAdSplashView extends StatefulWidget {
  static const String viewType = 'com.xujiaji.togetherad/splashview';

  final TogetherSplashCallBack? callback;
  final String alias;

  const TogetherAdSplashView({Key? key, required this.alias, this.callback}) : super(key: key);

  @override
  State<TogetherAdSplashView> createState() => _TogetherAdSplashViewState();
}

class _TogetherAdSplashViewState extends State<TogetherAdSplashView> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'alias': widget.alias
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          viewType: TogetherAdSplashView.viewType,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: TogetherAdSplashView.viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              } ,
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: TogetherAdSplashView.viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not yet supported by this plugin');
    }
  }

  void _onPlatformViewCreated(int id) {
    _channel = MethodChannel("${TogetherAdSplashView.viewType}_$id");
    _channel?.setMethodCallHandler(_callHandler);
  }

  Future<dynamic> _callHandler(MethodCall call) async {
    final args = call.arguments;
    switch(call.method) {
      case "onAdStartRequest":
        widget.callback?.onAdStartRequest!(args['providerType']);
        break;
      case "onAdFailedAll":
        widget.callback?.onAdFailedAll!(args['failedMsg']);
        break;
      case "onAdFailed":
        widget.callback?.onAdFailed!(args['providerType'], args['failedMsg']);
        break;
      case "onAdLoaded":
        widget.callback?.onAdLoaded!(args['providerType']);
        break;
      case "onAdClicked":
        widget.callback?.onAdClicked!(args['providerType']);
        break;
      case "onAdShowed":
        widget.callback?.onAdShowed!(args['providerType']);
        break;
      case "onAdDismissed":
        widget.callback?.onAdDismissed!(args['providerType']);
        break;
    }
  }
}