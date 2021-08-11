import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Baner extends StatefulWidget {
  const Baner({Key? key}) : super(key: key);

  @override
  _BanerState createState() => _BanerState();
}

class _BanerState extends State<Baner> {
  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,
      child: AdWidget(ad: myBanner),
    );
  }
}

class Interstitial {
  Interstitial._internal();
  static Interstitial _instance = Interstitial._internal();
  static Interstitial get instance => Interstitial._instance;

  void inicio() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/8691691433',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  InterstitialAd? _interstitialAd;

  Future<void> show() async {
    try {
      await this._interstitialAd!.show();
    } catch (e) {
      log(e.toString());
    }
  }
}
