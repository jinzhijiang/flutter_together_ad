import Flutter
import UIKit
import TogetherAd

public class SwiftFlutterTogetherAdPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.xujiaji.togetherad/main", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterTogetherAdPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
    let factory = TogetherAdSplashViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "com.xujiaji.togetherad/splashview")
      
      TogetherAd.shared.addProvider(adProviderEntity: AdProviderEntity(providerType: "csj", classPath: CsjProvider.self, desc: ""))
      TogetherAd.shared.setPublicProviderRatio(ratioMap: ["csj": 1])
      
      TogetherAdCsj.`init`(adProviderType: "csj", csjAdAppId: "5195862", isDebug: true)
      TogetherAdCsj.idMapCsj["splash"] = "887525763"
      TogetherAdCsj.idMapCsj["banner"] = "946453843"
      TogetherAdCsj.idMapCsj["fullscreen"] = "946453837"
      TogetherAdCsj.idMapCsj["reward"] = "946453836"
      TogetherAdCsj.idMapCsj["inter"] = "947075764"
      TogetherAdCsj.idMapCsj["native"] = "947094333"
      
      let frame = UIScreen.main.bounds
      
      CsjProvider.Inter.setSize(width: frame.width - 80, height: (frame.width - 80) * (2.0/3.0))
      
//      let rootViewController = UIApplication.shared.windows.filter({ (w) -> Bool in
//                  return w.isHidden == false
//       }).first?.rootViewController
//
//      if let rootViewController = rootViewController {
//          let view = TogetherSplashView(alias: "splash", rootViewController:rootViewController, frame: frame)
//          rootViewController.view.addSubview(view)
//      }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
