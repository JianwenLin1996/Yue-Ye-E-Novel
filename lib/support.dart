import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>[
      'youth',
      'university',
      'hobby',
      'attitude',
      'novel',
      'mandarin',
      'reading',
      'mysterious',
      'cool'
    ],
    //birthday: DateTime.now(),
    childDirected: true,
    //designedForFamilies: true
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        //adUnitId: "ca-app-pub-1959847133771963/7303868009",
        adUnitId: "ca-app-pub-1959847133771963/7303868009", 
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {});
  }

  /*InterstitialAd createInterstitialAd() {
    return new InterstitialAd(
        //adUnitId: "ca-app-pub-1959847133771963/1519916642",
        adUnitId:
            "ca-app-pub-3940256099942544/1033173712", //sample interstitial Id
        //size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print(event.toString());
        });
  }*/

  RewardedVideoAd createRewardedVideoAd() {
    RewardedVideoAd.instance.load(
        adUnitId: "ca-app-pub-1959847133771963/4856827746",
        targetingInfo: targetInfo);
    RewardedVideoAd.instance.show();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1959847133771963~6043768986");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              colors: [Colors.blueAccent[100], Colors.white],
            )),
          ),
          title: new Text(
            "支持",
            style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Mandarin',
                fontSize: 30.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: new Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      createRewardedVideoAd();
                    },
                    child: new Text(
                      "点击支持！",
                      style: TextStyle(fontSize: 25.0),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                ),
              ],
            ),
          ),
        ));
  }
}
