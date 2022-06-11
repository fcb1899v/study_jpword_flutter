import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Widget adMobWidget(BuildContext context, BannerAd myBanner) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: AdWidget(ad: myBanner),
    ),
  );
}

class AdmobService {
  BannerAd? getBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-1585283309075901/7206506171',
      size: AdSize(width: 320, height: 60,),
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    )..load();
  }
}