//
//  TogetherAdFullscreen.swift
//  flutter_together_ad
//
//  Created by 徐佳吉 on 2021/12/5.
//

import Foundation
import TogetherAd

class TogetherAdFullscreen: NSObject, FlutterPlugin {
    public static let type = "com.xujiaji.togetherad/fullscreen"
    var fullscreenMap: [String: FlutterAdHelperFullVideo] = [:]
    private let methodCall: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.methodCall = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: type, binaryMessenger: registrar.messenger())
        let instance = TogetherAdFullscreen(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        let tag = args["tag"] as? String ?? ""
        let alias = args["alias"] as? String ?? "fullscreen"
        switch call.method {
        case "load":
            fullscreenMap[tag] = FlutterAdHelperFullVideo(tag: tag, alias: alias, delegate: self)
            fullscreenMap[tag]?.load()
            result(true)
        case "loadAdnShow":
            fullscreenMap[tag] = FlutterAdHelperFullVideo(tag: tag, alias: alias, delegate: self)
            fullscreenMap[tag]?.loadAdnShow()
            result(true)
        case "show":
            result(fullscreenMap[tag]?.show() == true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension TogetherAdFullscreen: FullVideoListenerExt {
    func onAdStartRequest(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdStartRequest", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdFailedAll(tag: String, failedMsg: String?) {
        methodCall.invokeMethod("onAdFailedAll", arguments: ["tag": tag, "failedMsg": failedMsg])
        fullscreenMap.removeValue(forKey: tag)
    }
    
    func onAdFailed(tag: String, providerType: String, failedMsg: String?) {
        methodCall.invokeMethod("onAdFailed", arguments: ["tag": tag, "providerType": providerType, "failedMsg": failedMsg])
    }
    
    func onAdLoaded(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdLoaded", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdClicked(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdClicked", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdShowed(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdShowed", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdVideoCached(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdVideoCached", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdVideoComplete(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdVideoComplete", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdClosed(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdDismissed", arguments: ["tag": tag, "providerType": providerType])
        fullscreenMap.removeValue(forKey: tag)
    }
    
    
}
