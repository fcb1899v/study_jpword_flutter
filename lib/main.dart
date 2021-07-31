import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:admob_flutter/admob_flutter.dart';
import 'list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,//縦固定
  ]);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'たのしくまなぶ・ひらがな・カタカナ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListPage(),
    );
  }
}
