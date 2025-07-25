/// AdMob Banner Widget
///
/// Displays banner advertisements using Google AdMob SDK.
/// Only works on Android platform, returns empty widget on iOS.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'extension.dart';

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
    // final testIdentifiers = ['2793ca2a-5956-45a2-96c0-16fafddc1a15'];

    /// Get banner ad unit ID from environment variables
    /// Uses test ID in debug mode, production ID otherwise
    String bannerUnitId() => dotenv.get(
        kDebugMode ? 'ANDROID_BANNER_UNIT_ID':
        'ANDROID_BANNER_TEST_ID'
    );

    /// Load banner advertisement and set up event listeners
    Future<void> loadAdBanner() async {
      final adBanner = BannerAd(
        adUnitId: bannerUnitId(),
        size: AdSize.largeBanner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            'Ad: $ad loaded.'.debugPrint();
            adLoaded.value = true;
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

    /// Initialize ad loading and consent when widget is created
    useEffect(() {
      ConsentInformation.instance.requestConsentInfoUpdate(ConsentRequestParameters(
        // consentDebugSettings: ConsentDebugSettings(
        //   debugGeography: DebugGeography.debugGeographyEea,
        //   testIdentifiers: testIdentifiers,
        // ),
      ), () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          ConsentForm.loadConsentForm((ConsentForm consentForm) async {
            var status = await ConsentInformation.instance.getConsentStatus();
            "status: $status".debugPrint();
            if (status == ConsentStatus.required) {
              consentForm.show((formError) async => await loadAdBanner());
            } else {
              await loadAdBanner();
            }
          }, (formError) {
            "formError: $formError".debugPrint();
          });
        } else {
          await loadAdBanner();
        }
      }, (FormError error) {
        "error: ${error.message}: $error".debugPrint();
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