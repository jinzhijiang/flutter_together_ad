
import 'package:flutter/material.dart';
import 'package:flutter_together_ad/flutter_together_ad.dart';

import 'main.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    FlutterTogetherAd.isDebug = true;
    FlutterTogetherAd.csjInit(appId: "5195862", type: 'csj');
    FlutterTogetherAd.csjIdMap({
      "splash": "887525763",
      "banner": "946453843",
      "fullscreen": "946453837",
      "reward": "946453836",
      "inter": "947075764",
      "native": "947094333"
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TogetherAdSplashView(
        alias: 'splash',
        callback: TogetherSplashCallBack(
            onAdFailedAll: (type) {
              print("onAdFailedAll 全部加载失败 $type");
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const MyApp()
              ));
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
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const MyApp()
              ));
            },
            onAdShowed: (type) {
              print("onAdShowed 已显示 $type");
            },
            onAdStartRequest: (type) {
              print("onAdStartRequest 开始请求 $type");
            }
        ),)
    );
  }

}