import 'package:flutter/material.dart';

//Common
const myTitle = 'たのしくまなぶ・ひらがな・カタカナ';
const myFont = "Hiragino";

//Main Size
const String appBarImage = "assets/icon/title_white.png";

//List Size
const double listTopMargin = 10;
const double listCharSize = 20;
const double listMargin = 3;
const double listPadding = 0;

//JaWord
const List<String> allJaWord = [
  "あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ",
  "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と",
  "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ",
  "ま", "み", "む", "め", "も", "や", "ゆ", "よ",
  "ら", "り", "る", "れ", "ろ", "わ", "ん",
  "が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ", "ぞ",
  "だ", "づ", "で", "ど", "ば", "び", "ぶ", "べ", "ぼ",
  "ぱ", "ぴ", "ぷ", "ぺ", "ぽ", "きゃ", "きゅ", "きょ",
  "しゃ", "しゅ", "しょ", "ちゃ", "ちゅ", "ちょ", "にゃ", "にゅ", "にょ",
  "ひゃ", "ひゅ", "ひょ", "ぎゃ", "ぎゅ", "ぎょ", "じゃ", "じゅ", "じょ",
  // "みゃ" : "みゃく", "サンミャク"
  // "みゅ" : "エミュー",
  // "みょ" : "みょうが",
  // "りゅ" : "りゅう", "リュック"
  // "りゃ" : "",
  // "りょ" : "",
  // "びゃ" : "",
  // "びゅ" : "",
  // "びょ" : "びょういん", "ガビョウ"
  // "ぴゃ" : "",
  // "ぴゅ" : "",
  // "ぴょ" : "",
];

//Color
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color transpColor = Colors.transparent;
const Color blueColor = Color.fromRGBO(0, 119, 255, 1); //0077FF
const Color yellowColor = Color.fromRGBO(255, 165, 0, 1); //'FFA500'

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}