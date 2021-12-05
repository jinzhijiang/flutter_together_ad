import Flutter
import UIKit
import TogetherAd

func topViewController() -> UIViewController {
        return UIApplication.shared.windows.filter { (w) -> Bool in
            w.isHidden == false
        }.first!.rootViewController!
    }

public class SwiftFlutterTogetherAdPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.xujiaji.togetherad/main", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterTogetherAdPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // 注册全屏视频
        TogetherAdFullscreen.register(with: registrar)
        
        // 注册激励视频
        TogetherAdReward.register(with: registrar)
        
        let factory = TogetherAdSplashViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: TogetherAdSplashViewFactory.viewType)
        let frame = UIScreen.main.bounds
        CsjProvider.Inter.setSize(width: frame.width - 80, height: (frame.width - 80) * (2.0/3.0))
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        switch call.method {
        case "csjInit":
            let typeAlias = args["type"] as? String ?? "csj"
            TogetherAd.shared.addProvider(adProviderEntity: AdProviderEntity(providerType: typeAlias, classPath: CsjProvider.self, desc: ""))
            TogetherAd.shared.setPublicProviderRatio(ratioMap: [typeAlias: 1])
            TogetherAdCsj.`init`(adProviderType: typeAlias, csjAdAppId: args["appId"] as? String ?? "", isDebug: args["isDebug"] as? Bool ?? false)
            result(true)
        case "csjIdAliasMap":
            for (k, v) in args {
                TogetherAdCsj.idMapCsj[k] = v as? String ?? ""
            }
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
