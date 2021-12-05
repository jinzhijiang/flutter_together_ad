/// 开始请求前回调
typedef OnAdStartRequest = void Function(String providerType);

/// 所有的提供商都请求失败，或请求超时，或没有分配任何广告商比例
typedef OnAdFailedAll = void Function(String failedMsg);

/// 单个提供商请求失败
typedef OnAdFailed = void Function(String providerType, String? failedMsg);

/// 广告已加载
typedef OnAdLoaded = void Function(String providerType);

/// 广告被点击
typedef OnAdClicked = void Function(String providerType);

/// 广告已显示
typedef OnAdShowed = void Function(String providerType);

/// 广告关闭
typedef OnAdDismissed = void Function(String providerType);

/// 视频广告已缓存
typedef OnAdVideoCached = void Function(String providerType);

/// 视频广告已经播放完了
typedef OnAdVideoComplete = void Function(String providerType);

class BaseAdCallback {
  OnAdStartRequest? onAdStartRequest;
  OnAdFailedAll? onAdFailedAll;
  OnAdFailed? onAdFailed;

  BaseAdCallback({this.onAdStartRequest, this.onAdFailed, this.onAdFailedAll});
}

///
/// splash广告回调
///
class TogetherSplashCallBack extends BaseAdCallback {
  OnAdLoaded? onAdLoaded;
  OnAdClicked? onAdClicked;
  OnAdShowed? onAdShowed;
  OnAdDismissed? onAdDismissed;

  TogetherSplashCallBack({
    this.onAdDismissed,
    this.onAdShowed,
    this.onAdClicked,
    this.onAdLoaded,
    OnAdStartRequest? onAdStartRequest,
    OnAdFailedAll? onAdFailedAll,
    OnAdFailed? onAdFailed}) :
        super(
          onAdStartRequest: onAdStartRequest,
          onAdFailed: onAdFailed,
          onAdFailedAll: onAdFailedAll);
}

///
/// 全屏视频广告回调
///
class TogetherFullscreenCallback extends BaseAdCallback {
  OnAdLoaded? onAdLoaded;
  OnAdClicked? onAdClicked;
  OnAdShowed? onAdShowed;
  OnAdVideoCached? onAdVideoCached;
  OnAdVideoComplete? onAdVideoComplete;
  OnAdDismissed? onAdDismissed;

  TogetherFullscreenCallback({
    this.onAdDismissed,
    this.onAdShowed,
    this.onAdClicked,
    this.onAdLoaded,
    this.onAdVideoComplete,
    this.onAdVideoCached,
    OnAdStartRequest? onAdStartRequest,
    OnAdFailedAll? onAdFailedAll,
    OnAdFailed? onAdFailed}) :
        super(
          onAdStartRequest: onAdStartRequest,
          onAdFailed: onAdFailed,
          onAdFailedAll: onAdFailedAll);
}