import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constant.dart';
import 'list_page.dart';

/// Application entry point
/// Initializes Flutter, Firebase, AdMob, and environment variables
/// Sets up the main application with proper configuration
Future<void> main() async {
  // Ensure Flutter is initialized before proceeding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Configure system UI, orientation, and platform-specific styling
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }
  // Load environment variables from .env file
  await dotenv.load(fileName: "assets/.env");
  // No options: Android auto-initializes [DEFAULT] from google-services.json
  // before main runs, and passing options that differ from it throws
  // duplicate-app. Analytics attaches to that same native default app
  if (Platform.isAndroid) await Firebase.initializeApp();
  // Start the application with Riverpod provider scope
  runApp(const ProviderScope(child: MyApp()));
  // Initialize Google Mobile Ads for Android platform
  // Android only: no ad is requested on iOS. homepage.dart shows a plain
  // SizedBox there instead of AdBannerWidget, and initialize() is gated below,
  // so nothing on iOS ever reaches the ads SDK.
  //
  // Info.plist still carries GADApplicationIdentifier and it names this app's
  // own AdMob iOS app, which is registered and has a store id. The key cannot
  // be dropped while the plugin is linked, and naming Google's sample app there
  // would put another publisher's id in a shipping build for no gain. Setting
  // it correctly requests no ads; the gates below decide that.
  if (Platform.isAndroid) MobileAds.instance.initialize();
}

/// Main application widget
/// Configures the MaterialApp with theme, navigation, and analytics
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: myTitle,
      // Disable debug banner in release mode
      debugShowCheckedModeBanner: false,
      // Configure app theme with adaptive density and custom font
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: myFont
      ),
      // Set ListPage as the home screen
      home: ListPage(),
      // Configure navigation observers for analytics and route tracking
      navigatorObservers: <NavigatorObserver>[
        // Firebase Analytics observer for Android platform
        if (Platform.isAndroid) FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        // Route observer for modal route tracking
        if (Platform.isAndroid) RouteObserver<ModalRoute>()
      ],
    );
  }
}
