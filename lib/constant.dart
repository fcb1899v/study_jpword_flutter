import 'package:flutter/material.dart';

//Main Size
const String appBarImage = "assets/icon/title_white.png";
const double appBarWidthRate = 0.8;
const double appBarMaxWidth = 500;
const double mainPaddingRate = 0.05;
const double wordWidthRate = 0.425;
const double charSizeRate = 0.25;
const double charHeightRate = 0.32;
const double wordSizeRate = 0.04;
const double wordSpaceRate = 0.08;
const double picMaxWidth = 250;
const double audioButtonWidthRate = 0.5;
const double operationButtonWidthRate = 0.12;
const double buttonIconSize = 30;
const double buttonHeight = 50;
const double buttonRadius = 50;

//List Size
const double listCharSize = 25;
const double listMargin = 3;
const double listPadding = 3;

//Phonics
const List<String> allJaWord = [
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
final int numberJaWord = allJaWord.length;

//Color
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
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