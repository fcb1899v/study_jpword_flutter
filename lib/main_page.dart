import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main_widget.dart';
import 'ja_word.dart';
import 'admob.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  const MainPage(this.index);
  final int index;
  @override
  _MainPageState createState() => _MainPageState(index);
}

class _MainPageState extends State<MainPage> {
  int index;
  _MainPageState(this.index);

  late List<String> jaWordList;
  late List<String> word;
  late List<String> picture;
  late List<String> sound;
  late BannerAd myBanner;

  @override
  void initState() {
    super.initState();
    setState(() {
      jaWordList = [
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
      ];
      word = jaWordList[index].jaWord();
      picture = jaWordList[index].jaWordPicture();
      sound = word.wordSound();
      print("${jaWordList[index]}, $word");
      if (Platform.isAndroid) myBanner = AdmobService().getBannerAd()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: appBarTitle(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            jaWords(),
            Spacer(),
            operationButtons(),
            Spacer(),
            if (Platform.isAndroid) adMobWidget(context, myBanner),
          ],
        ),
      ),
    );
  }

  Widget operationButtons() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Spacer(),
          returnButton(),
          Spacer(),
          shuffleButton(jaWordList),
          Spacer(),
          backButton(jaWordList),
          Spacer(),
          forwardButton(jaWordList),
          Spacer(),
        ]
      ),
    );
  }

  Widget jaWords() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Spacer(),
          jaWordSet(0),
          Spacer(),
          (word[4] == "") ? SizedBox.shrink(): jaWordSet(1),
          Spacer(),
        ]
      ),
    );
  }

  Widget jaWordSet(num) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: <Widget>[
          jaChar(num),
          SizedBox(height: 10),
          jaWordUnit(num),
          SizedBox(height: 10),
          jaWordPicture(num),
          SizedBox(height: 20),
          jaWordSound(num),
        ]
      )
    );
  }

  Widget jaChar(int num){
    return (word[4] == "") ? SizedBox.shrink(): TextButton(
      child: jaCharView(jaWordList[index], num),
      onPressed: () => sound[num].speakText(context),
    );
  }

  Widget jaWordUnit(int num){
    return (word[4] == "") ? SizedBox.shrink(): TextButton(
      child: jaWordView(word, num),
      onPressed: () => sound[num].speakText(context),
    );
  }

  Widget jaWordPicture(int num) {
    return (word[4] == "") ? SizedBox.shrink(): TextButton(
      onPressed: () => sound[num].speakText(context),
      child: jaWordPictureView(context, picture, num),
    );
  }

  Widget jaWordSound(int num) {
    return (word[4] == "") ? SizedBox.shrink(): ElevatedButton(
      onPressed: () => sound[num].speakText(context),
      child: audioIcon(context),
      style: elevatedButtonStyle(HexColor('0077ff'), 20),
    );
  }

  Widget returnButton(){
    return ElevatedButton(
      onPressed: () => setState(() {
        jaWordList = [
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
        ];
        word = jaWordList[index].jaWord();
        picture = jaWordList[index].jaWordPicture();
        sound = word.wordSound();
        print("${jaWordList[index]}, $word");
      }),
      style: elevatedButtonStyle(HexColor('ffa500'), 20),
      child: customIcon(context, Icons.keyboard_return),
    );
  }

  Widget shuffleButton(List<String> charList){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          jaWordList.shuffle();
          word = jaWordList[index].jaWord();
          picture = jaWordList[index].jaWordPicture();
          sound = word.wordSound();
          print("${jaWordList[index]}, $word");
        });
      },
      style: elevatedButtonStyle(HexColor('ffa500'), 20),
      child: customIcon(context, Icons.shuffle),
    );
  }

  Widget backButton(List<String> charList){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          jaWordList.insert(0, jaWordList[jaWordList.length - 1]);
          jaWordList.removeAt(jaWordList.length - 1);
          word = jaWordList[index].jaWord();
          picture = jaWordList[index].jaWordPicture();
          sound = word.wordSound();
          print("${jaWordList[index]}, $word");
        });
      },
      style: elevatedButtonStyle(HexColor('ffa500'), 20),
      child: customIcon(context, Icons.arrow_back),
    );
  }

  Widget forwardButton(List<String> charList){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          jaWordList.insert(jaWordList.length, jaWordList[0]);
          jaWordList.removeAt(0);
          word = jaWordList[index].jaWord();
          picture = jaWordList[index].jaWordPicture();
          sound = word.wordSound();
          print("${jaWordList[index]}, $word");
        });
      },
      style: elevatedButtonStyle(HexColor('ffa500'), 20),
      child: customIcon(context, Icons.arrow_forward),
    );
  }
}

