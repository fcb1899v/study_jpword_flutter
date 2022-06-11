import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jpword_app/constant.dart';
import 'main_widget.dart';
import 'extension.dart';
import 'admob.dart';

class MainPage extends StatefulWidget {
  const MainPage(this.index);
  final int index;
  @override
  _MainPageState createState() => _MainPageState(index);
}

class _MainPageState extends State<MainPage> {
  int index;
  _MainPageState(this.index);

  late double width;
  late double height;
  late List<String> jaWordList;
  late String char;
  late List<String> word;
  late List<String> picture;
  late List<String> sound;
  late BannerAd? myBanner;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (Platform.isAndroid) myBanner = AdmobService().getBannerAd()!;
    });
    _setReturn();
  }

  @override
  void didChangeDependencies() {
    "call didChangeDependencies".debugPrint();
    super.didChangeDependencies();
    setState((){
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
    "width: $width, height: $height".debugPrint();
  }

  @override
  void didUpdateWidget(oldWidget) {
    "call didUpdateWidget".debugPrint();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    "call deactivate".debugPrint();
    super.deactivate();
  }

  @override
  void dispose() {
    "call dispose".debugPrint();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: whiteColor),
            onPressed: () => Navigator.pop(context, true),
          ),
          title: Image.asset(appBarImage, width: width.appBarWidth()),
          centerTitle: true,
        ),
        body: Container(
          padding: mainPadding(width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 1),
              Row(children: [
                jaWord(0),
                Spacer(),
                jaWord(1),
              ]),
              SizedBox(height: width * wordSpaceRate),
              operationButtons(),
              Spacer(flex: 2),
              if (Platform.isAndroid) adMobWidget(context, myBanner!),
            ],
          ),
        ),
      );

  Widget jaWord(int num) =>
      SizedBox(
        width: width * wordWidthRate,
        child: Column(children: [
          charView(width, jaWordList[index], num),
          SizedBox(height: width * wordSpaceRate),
          wordButton(num),
          SizedBox(height: width * wordSpaceRate),
          pictureButton(num),
          SizedBox(height: width * wordSpaceRate),
          audioButton(num),
        ]),
      );

  TextButton wordButton(int num) =>
      TextButton(
        onPressed: () => sound[num].speakText(context),
        child: wordView(width, word, num),
      );

  TextButton pictureButton(int num) =>
      TextButton(
        onPressed: () => sound[num].speakText(context),
        child: pictureView(width, picture[num]),
      );

  ElevatedButton audioButton(int num) =>
      ElevatedButton(
          onPressed: () => sound[num].speakText(context),
          style: audioButtonStyle(),
          child: audioIcon(width)
      );

  Widget operationButtons() =>
      SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            returnButton(),
            Spacer(), shuffleButton(),
            Spacer(), backButton(),
            Spacer(), forwardButton(),
          ]
        ),
      );

  ElevatedButton returnButton() =>
      ElevatedButton(
        onPressed: () => _setReturn(),
        style: operationButtonStyle(),
        child: operationIcon(width, Icons.keyboard_return)
      );

  ElevatedButton shuffleButton() =>
      ElevatedButton(
        onPressed: () => _setShuffle(),
        style: operationButtonStyle(),
        child: operationIcon(width, Icons.shuffle)
      );

  ElevatedButton backButton() =>
      ElevatedButton(
        onPressed: () => _setBack(),
        style: operationButtonStyle(),
        child: operationIcon(width, Icons.arrow_back)
      );

  ElevatedButton forwardButton() =>
      ElevatedButton(
        onPressed: () => _setForward(),
        style: operationButtonStyle(),
        child: operationIcon(width, Icons.arrow_forward)
      );

  _setReturn() {
    setState(() => jaWordList = [
      "あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ",
      "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と",
      "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ",
      "ま", "み", "む", "め", "も", "や", "ゆ", "よ",
      "ら", "り", "る", "れ", "ろ", "わ", "ん",
      "が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ", "ぞ",
      "だ", "づ", "で", "ど", "ば", "び", "ぶ", "べ", "ぼ",
      "ぱ", "ぴ", "ぷ", "ぺ", "ぽ", "きゃ", "きゅ", "きょ",
      "しゃ", "しゅ", "しょ", "ちゃ", "ちゅ", "ちょ", "ひょ", "りゅ",
      "ぎゅ", "ぎょ", "じゃ", "じゅ", "じょ", "びょ",
      // "にゃ" : "こんにゃく", "にゅ" : "ぎゅうにゅう", "にょ" : "",
      // "ひゃ" : "ひゃくえん", "ひゅ",
      // "みゃ", "みゅ", "みょ" : "みょうが",
      // "りゃ", "りょ", "ぎゃ",
      // "びゃ", "びゅ", "ぴゃ", "ぴゅ", "ぴょ",
    ]);
    _setNewWord();
  }

  _setShuffle() {
    setState(() => jaWordList.shuffle());
    _setNewWord();
  }

  _setBack() {
    setState(() {
      jaWordList.insert(0, jaWordList[jaWordList.length - 1]);
      jaWordList.removeAt(jaWordList.length - 1);
    });
    _setNewWord();
  }

  _setForward() {
    setState(() {
      jaWordList.insert(jaWordList.length, jaWordList[0]);
      jaWordList.removeAt(0);
    });
    _setNewWord();
  }

  _setNewWord() {
    setState(() {
      char = jaWordList[index];
      word = jaWordList[index].jaWord();
      picture = jaWordList[index].jaWordPicture();
      sound = word.wordSound();
    });
    "$char, ${word.printWord()}".debugPrint();
  }

}

