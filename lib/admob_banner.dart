// AdMob Banner Widget
// Displays banner ads using Google AdMob SDK. Android only; empty widget on iOS.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'extension.dart';
import 'constant.dart';

// Import AdMob only for Android
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob Banner Widget
/// Displays banner advertisements with platform-specific handling
class AdBannerWidget extends HookWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // State to track if ad is loaded
    final adLoaded = useState(false);
    // State to track if ad failed to load
    final adFailedLoading = useState(false);
    // State to hold the BannerAd instance
    final bannerAd = useState<BannerAd?>(null);
    // Ref, not state: the consent callbacks resolve after this widget can be
    // gone, and writing to a disposed ValueNotifier asserts in debug
    final isAdRequested = useRef(false);
    // final testIdentifiers = ['2793ca2a-5956-45a2-96c0-16fafddc1a15'];

    /// Banner ad unit ID from .env: test ID in debug mode, production ID otherwise
    // Branches were once swapped, so every release build served Google's test banner
    String bannerUnitId() => kDebugMode
        ? androidBannerTestId
        : dotenv.get('ANDROID_BANNER_UNIT_ID');

    /// Load banner advertisement and set up event listeners
    Future<void> loadAdBanner() async {
      // largeBanner asked for a fixed 320x100 inside a box sized by admobWidth
      // and admobHeight. Inline adaptive asks for that box's width and height
      final cap = context.admobHeight().toInt();
      final size = AdSize.getInlineAdaptiveBannerAdSize(
          context.admobWidth().toInt(), cap);
      final adBanner = BannerAd(
        adUnitId: bannerUnitId(),
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) async {
            'Ad: $ad loaded.'.debugPrint();
            // Mount first; the await below only feeds a debug line
            adLoaded.value = true;
            if (kDebugMode) {
              // Requested and served together: neither alone separates the size
              // asked for from the creative Google had to hand
              final served = await (ad as BannerAd).getPlatformAdSize();
              'AdSize: ${size.width} x cap $cap / served: ${served?.width} x ${served?.height}'.debugPrint();
            }
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            'Ad: $ad failed to load: $error'.debugPrint();
            adFailedLoading.value = true;
            // Retry loading after 30 seconds if not loaded
            Future.delayed(const Duration(seconds: 30), () {
              if (!adLoaded.value && !adFailedLoading.value) loadAdBanner();
            });
          },
        ),
      );
      adBanner.load();
      bannerAd.value = adBanner;
    }

    /// Single gate for the ad request. canRequestAds is the SDK's own verdict (region,
    /// TCF, Additional Consent); false also covers "could not tell", so never bypass it
    Future<void> requestAdIfAllowed() async {
      if (isAdRequested.value) return;
      if (!await ConsentInformation.instance.canRequestAds()) return;
      // Both callers race across that await. The claim happens with no await in
      // between, so the second to resume sees the flag and makes no second BannerAd
      if (isAdRequested.value) return;
      isAdRequested.value = true;
      await loadAdBanner();
    }

    /// Initialize ad loading and consent when widget is created
    useEffect(() {
      ConsentInformation.instance.requestConsentInfoUpdate(ConsentRequestParameters(
        // consentDebugSettings: ConsentDebugSettings(
        //   debugGeography: DebugGeography.debugGeographyEea,
        //   testIdentifiers: testIdentifiers,
        // ),
      ), () async {
        // The SDK decides whether a form is required and shows it. Do not load the ad
        // from the form callback: it fires on close even when the user declined
        await ConsentForm.loadAndShowConsentFormIfRequired((formError) async {
          if (formError != null) {
            "formError: ${formError.errorCode}: ${formError.message}".debugPrint();
          }
          await requestAdIfAllowed();
        });
      }, (FormError error) async {
        // The update failed, but consent from an earlier session still stands and
        // canRequestAds can still say yes, so do not stop here
        "error: ${error.errorCode}: ${error.message}".debugPrint();
        await requestAdIfAllowed();
      });
      "bannerAd: ${bannerAd.value}".debugPrint();
      // Dispose the ad when the widget is disposed
      return () => bannerAd.value?.dispose();
    }, []);

    // Return the banner ad widget if loaded, otherwise an empty box
    return SizedBox(
      width: context.admobWidth(),
      height: context.admobHeight(),
      child: (adLoaded.value) ? AdWidget(ad: bannerAd.value!): null,
    );
  }
}