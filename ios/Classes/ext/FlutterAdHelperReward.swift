//
//  FlutterAdHelperReward.swift
//  flutter_together_ad
//
//  Created by 徐佳吉 on 2021/12/5.
//

import Foundation
import TogetherAd

class FlutterAdHelperReward {
    
    private var adHelperReard: AdHelperReward?
    private let tag: String
    private let alias: String
    private let adTypeRatioMap: [String : Int]?
    private let delegate: RewardListenerExt?
    
    public init(tag: String, alias: String, adTypeRatioMap: [String : Int]? = nil, delegate: RewardListenerExt? = nil) {
        self.tag = tag
        self.alias = alias
        self.adTypeRatioMap = adTypeRatioMap
        self.delegate = delegate
    }
    
    func load() {
        self.adHelperReard = AdHelperReward(alias: alias, adTypeRatioMap: adTypeRatioMap, delegate: self)
        self.adHelperReard?.load()
    }
    
    func loadAdnShow() {
        self.adHelperReard = AdHelperReward(alias: alias, adTypeRatioMap: adTypeRatioMap, delegate: self)
        self.adHelperReard?.loadAndShow(fromRootViewController: topViewController())
    }
    
    func show() -> Bool {
        return self.adHelperReard?.show(fromRootViewController: topViewController()) == true
    }
}

extension FlutterAdHelperReward: RewardListener {
    public func onAdStartRequest(providerType: String) {
        delegate?.onAdStartRequest(tag: tag, providerType: providerType)
    }

    public func onAdFailedAll(failedMsg: String?) {
        delegate?.onAdFailedAll(tag: tag, failedMsg: failedMsg)
    }

    public func onAdFailed(providerType: String, failedMsg: String?) {
        delegate?.onAdFailed(tag: tag, providerType: providerType, failedMsg: failedMsg)
    }
    
    public func onAdLoaded(providerType: String) {
        delegate?.onAdLoaded(tag: tag, providerType: providerType)
    }

    public func onAdClicked(providerType: String) {
        delegate?.onAdClicked(tag: tag, providerType: providerType)
    }

    public func onAdShow(providerType: String) {
        delegate?.onAdShowed(tag: tag, providerType: providerType)
    }

    public func onAdVideoCached(providerType: String) {
        delegate?.onAdVideoCached(tag: tag, providerType: providerType)
    }

    public func onAdVideoComplete(providerType: String) {
        delegate?.onAdVideoComplete(tag: tag, providerType: providerType)
    }

    public func onAdClose(providerType: String) {
        delegate?.onAdClosed(tag: tag, providerType: providerType)
    }
    
    public func onAdRewardVerify(providerType: String) {
        delegate?.onAdRewardVerify(tag: tag, providerType: providerType)
    }
}

public protocol RewardListenerExt {
    /**
     * 开始请求前回调
     */
    func onAdStartRequest(tag: String, providerType: String)

    /**
     * 所有的提供商都请求失败，或请求超时，或没有分配任何广告商比例
     */
    func onAdFailedAll(tag: String, failedMsg: String?)

    /**
     * 单个提供商请求失败
     */
    func onAdFailed(tag: String, providerType: String, failedMsg: String?)
    
    /**
     * 请求到了广告
     */
    func onAdLoaded(tag: String, providerType: String)

    /**
     * 广告被点击了
     */
    func onAdClicked(tag: String, providerType: String)

    /**
     * 广告展示了
     */
    func onAdShowed(tag: String, providerType: String)

    /**
     * 视频缓存完成
     */
    func onAdVideoCached(tag: String, providerType: String)

    /**
     * 视频播放完成
     */
    func onAdVideoComplete(tag: String, providerType: String)

    /**
     * 广告被关闭了
     */
    func onAdClosed(tag: String, providerType: String)
    
    func onAdRewardVerify(tag: String, providerType: String)
}
