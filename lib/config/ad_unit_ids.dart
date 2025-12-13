import 'dart:io';

class AdUnitIds {
  // Test Ad Unit IDs
  static const String _androidBanner = 'ca-app-pub-3566735305172957/1112234919';
  static const String _iosBanner = 'ca-app-pub-3940256099942544/2934735716';

  static const String _androidInterstitial =
      'ca-app-pub-3566735305172957/5981418211';
  static const String _iosInterstitial =
      'ca-app-pub-3940256099942544/4411468910';

  static const String _androidRewarded =
      'ca-app-pub-3566735305172957/4985220688';
  static const String _iosRewarded = 'ca-app-pub-3940256099942544/1712485313';

  static String get banner {
    if (Platform.isAndroid) {
      return _androidBanner;
    } else if (Platform.isIOS) {
      return _iosBanner;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitial {
    if (Platform.isAndroid) {
      return _androidInterstitial;
    } else if (Platform.isIOS) {
      return _iosInterstitial;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewarded {
    if (Platform.isAndroid) {
      return _androidRewarded;
    } else if (Platform.isIOS) {
      return _iosRewarded;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
