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

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let frame = UIScreen.main.bounds
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            let view = TogetherSplashView(alias: "splash", rootViewController: rootViewController, frame: frame)
            _view.addSubview(view)
        }
    }
}
