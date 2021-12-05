//
//  TogetherAdReward.swift
//  flutter_together_ad
//
//  Created by 徐佳吉 on 2021/12/5.
//

import Foundation
import TogetherAd

class TogetherAdReward : NSObject, FlutterPlugin {
    public static let type = "com.xujiaji.togetherad/reward"
    var rewardMap: [String: FlutterAdHelperReward] = [:]
    private let methodCall: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.methodCall = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: type, binaryMessenger: registrar.messenger())
        let instance = TogetherAdReward(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        let tag = args["tag"] as? String ?? ""
        let alias = args["alias"] as? String ?? "reward"
        switch call.method {
        case "load":
            rewardMap[tag] = FlutterAdHelperReward(tag: tag, alias: alias, delegate: self)
            rewardMap[tag]?.load()
            result(true)
        case "loadAdnShow":
            rewardMap[tag] = FlutterAdHelperReward(tag: tag, alias: alias, delegate: self)
            rewardMap[tag]?.loadAdnShow()
            result(true)
        case "show":
            result(rewardMap[tag]?.show() == true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension TogetherAdReward: RewardListenerExt {
    func onAdRewardVerify(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdRewardVerify", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdStartRequest(tag: String, providerType: String) {
        methodCall.invokeMethod("onAdStartRequest", arguments: ["tag": tag, "providerType": providerType])
    }
    
    func onAdFailedAll(tag: String, failedMsg: String?) {
        methodCall.invokeMethod("onAdFailedAll", arguments: ["tag": tag, "failedMsg": failedMsg])
        rewardMap.removeValue(forKey: tag)
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
        rewardMap.removeValue(forKey: tag)
    }
    
    
}
