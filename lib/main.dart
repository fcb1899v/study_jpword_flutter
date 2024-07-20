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
import 'list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //縦向き指定
  await dotenv.load(fileName: "assets/.env");
  if (Platform.isAndroid) MobileAds.instance.initialize();
  if (Platform.isAndroid) await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: myTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: myFont
      ),
      home: ListPage(),
      navigatorObservers: <NavigatorObserver>[
        if (Platform.isAndroid) FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        if (Platform.isAndroid) RouteObserver<ModalRoute>()
      ],
    );
  }
}
