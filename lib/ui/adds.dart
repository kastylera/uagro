import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Interstitial {
  Interstitial();

  static String get rewardedAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/5224354917";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1712485313";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-7420686519903453/3510637380";
      } else if (Platform.isIOS) {
        return "ca-app-pub-7420686519903453/3350855281";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  static String get interstitialAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-7420686519903453/3535072556";
      } else if (Platform.isIOS) {
        return "cca-app-pub-7420686519903453/8255533302";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  /// Loads an interstitial ad.
  Future<void> loadInterstitialAd(
      {VoidCallback? doAfter, VoidCallback? onFailed}) async {
    await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.show();
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                  if (onFailed != null) onFailed();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  if (doAfter != null) doAfter();
                },
                onAdClicked: (ad) {});
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            if (onFailed != null) onFailed();
          },
        ));
  }

  Future<void> loadRewardedAd(
      {VoidCallback? doAfter, VoidCallback? onFailed}) async {
    await RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          ad.show(onUserEarnedReward: (ad, rewardPoints) {});

          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                if (onFailed != null) onFailed();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                if (doAfter != null) doAfter();
              });
        }, onAdFailedToLoad: (er) {
          if (onFailed != null) onFailed();
        }));
  }
}
