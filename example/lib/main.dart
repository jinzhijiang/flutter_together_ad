import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_together_ad/flutter_together_ad.dart';
import 'package:flutter_together_ad_example/splash_page.dart';

void main() {
  runApp(const MaterialApp(
    home: SplashPage(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _platformVersion = 'Unknown';
  TogetherAdFullscreen? fullscreen;
  TogetherAdReward? reward;

  @override
  void initState() {
    super.initState();
    reward = TogetherAdReward (
        alias: 'reward',
        callback: TogetherRewardCallback(
            onAdFailedAll: (type) {
              print("onAdFailedAll 全部加载失败 $type");
            },
            onAdFailed: (type, failedMsg) {
              print("onAdFailed 加载失败 $type, $failedMsg");
            },
            onAdClicked: (type) {
              print('onAdClicked 被点击 $type');
            },
            onAdLoaded: (type) {
              print("onAdClicked 已加载 $type");
            },
            onAdDismissed: (type) {
              print("onAdDismissed 已关闭 $type");
            },
            onAdVideoCached: (type) {
              print("onAdVideoCached 视频已缓存 $type");
            },
            onAdVideoComplete: (type) {
              print("onAdVideoComplete 已显示 $type");
            },
            onAdShowed: (type) {
              print("onAdShowed 已显示 $type");
            },
            onAdStartRequest: (type) {
              print("onAdStartRequest 开始请求 $type");
            },
          onAdRewardVerify: (type) {

          }
        ));

    fullscreen = TogetherAdFullscreen(
        alias: 'fullscreen',
        callback: TogetherFullscreenCallback(
            onAdFailedAll: (type) {
              print("onAdFailedAll 全部加载失败 $type");
            },
            onAdFailed: (type, failedMsg) {
              print("onAdFailed 加载失败 $type, $failedMsg");
            },
            onAdClicked: (type) {
              print('onAdClicked 被点击 $type');
            },
            onAdLoaded: (type) {
              print("onAdClicked 已加载 $type");
            },
            onAdDismissed: (type) {
              print("onAdDismissed 已关闭 $type");
            },
            onAdVideoCached: (type) {
              print("onAdVideoCached 视频已缓存 $type");
            },
            onAdVideoComplete: (type) {
              print("onAdVideoComplete 已显示 $type");
            },
            onAdShowed: (type) {
              print("onAdShowed 已显示 $type");
            },
            onAdStartRequest: (type) {
              print("onAdStartRequest 开始请求 $type");
            }
        ));
    // initPlatformState();
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await FlutterTogetherAd.tests ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              // Text('Running on: $_platformVersion\n'),
              TextButton(
                child: const Text("加载并显示全屏视频"),
                onPressed: () {
                  fullscreen?.loadAndShow();
                },
              ),
              TextButton(
                child: const Text("加载并显示激励视频"),
                onPressed: () {
                  reward?.loadAndShow();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
