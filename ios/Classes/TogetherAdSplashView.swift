//
//  FLNativeView.swift
//  flutter_together_ad
//
//  Created by 徐佳吉 on 2021/11/27.
//

import Flutter
import UIKit
import TogetherAd

class TogetherAdSplashViewFactory: NSObject, FlutterPlatformViewFactory {
    public static let viewType = "com.xujiaji.togetherad/splashview"
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return TogetherAdSplashView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class TogetherAdSplashView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var methodCall: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = UIView()
        methodCall = FlutterMethodChannel(
            name: "\(TogetherAdSplashViewFactory.viewType)_\(viewId)",
            binaryMessenger: messenger
        )
        super.init()
        // iOS views can be created here
        createNativeView(view: _view, args: args as? Dictionary<String, Any>)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView, args: Dictionary<String, Any>?){
        let frame = UIScreen.main.bounds
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            let view = TogetherSplashView(
                alias: args?["alias"] as? String ?? "splash",
                delegate: self,
                rootViewController: rootViewController,
                frame: frame)
            _view.addSubview(view)
        }
    }
}

extension TogetherAdSplashView : SplashListener {
    
    public func onAdStartRequest(providerType: String) {
        methodCall.invokeMethod("onAdStartRequest", arguments: ["providerType": providerType])
    }

    public func onAdFailedAll(failedMsg: String?) {
        methodCall.invokeMethod("onAdFailedAll", arguments: ["failedMsg": failedMsg])
    }

    public func onAdFailed(providerType: String, failedMsg: String?) {
        methodCall.invokeMethod("onAdFailed", arguments: ["providerType": providerType, "failedMsg": failedMsg])
    }
    
    public func onAdLoaded(providerType: String) {
        methodCall.invokeMethod("onAdLoaded", arguments: ["providerType": providerType])
    }
    
    public func onAdClicked(providerType: String) {
        methodCall.invokeMethod("onAdClicked", arguments: ["providerType": providerType])
    }
    
    public func onAdExposure(providerType: String) {
        methodCall.invokeMethod("onAdShowed", arguments: ["providerType": providerType])
    }
    
    public func onAdDismissed(providerType: String) {
        methodCall.invokeMethod("onAdDismissed", arguments: ["providerType": providerType])
    }
}
