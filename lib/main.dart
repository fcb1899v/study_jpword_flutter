import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'constant.dart';
import 'listpage.dart';

/// Application entry point
/// Initializes Flutter, Firebase, AdMob, and environment variables
/// Sets up the main application with proper configuration
Future<void> main() async {
  // Ensure Flutter is initialized before proceeding
  WidgetsFlutterBinding.ensureInitialized();
  // Lock device orientation to portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Load environment variables from .env file
  await dotenv.load(fileName: "assets/.env");
  // Initialize Firebase for Android platform
  if (Platform.isAndroid) await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Start the application with Riverpod provider scope
  runApp(ProviderScope(child: MyApp()));
  // Initialize Google Mobile Ads for Android platform
  if (Platform.isAndroid) MobileAds.instance.initialize();
}

/// Main application widget
/// Configures the MaterialApp with theme, navigation, and analytics
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
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
