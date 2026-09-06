import 'package:flutter/material.dart';

// =============================================================================
// APP CONFIGURATION
// =============================================================================

const myTitle = 'たのしくまなぶ・ひらがな・カタカナ';
const myFont = "Hiragino";
const String appBarImage = "assets/icon/title_white.png";

// =============================================================================
// UI SIZING CONSTANTS
// =============================================================================

const double listTopMargin = 10;
const double listCharSize = 20;
const double listMargin = 3;
const double listPadding = 0;

// =============================================================================
// JAPANESE CHARACTER DATA
// =============================================================================

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

// =============================================================================
// COLOR CONSTANTS
// =============================================================================

const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color transpColor = Colors.transparent;
const Color blueColor = Color.fromRGBO(0, 119, 255, 1); //0077FF
const Color yellowColor = Color.fromRGBO(255, 165, 0, 1); //'FFA500'

/// Custom color class for hex color support
/// Allows creating colors from hex strings like "#FF0000" or "FF0000"
class HexColor extends Color {
  /// Converts hex string to integer color value
  /// Handles both 6-digit and 8-digit hex codes
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add alpha channel if missing
    }
    return int.parse(hexColor, radix: 16);
  }
  /// Creates a color from hex string
  /// Example: HexColor("#FF0000") or HexColor("FF0000")
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));
}

// =============================================================================
// UI STYLING
// =============================================================================

/// Standard shadow for cards and elevated elements
/// Creates a subtle drop shadow with grey color, 2px spread, 4px blur, and 2px offset
BoxShadow myShadow() => BoxShadow(
  color: Colors.grey, // Shadow color
  spreadRadius: 2,    // How far the shadow spreads
  blurRadius: 4,      // How blurry the shadow is
  offset: Offset(2, 2), // Shadow offset from the element
);

// =============================================================================
// NAVIGATION ICONS
// =============================================================================

/// Navigation icons used in the app
/// Index mapping:
/// - 0: Reset button (keyboard_return icon)
/// - 1: Shuffle button (shuffle icon)
/// - 2: Back button (arrow_back icon)
/// - 3: Next button (arrow_forward icon)
List<IconData> icons = [
  Icons.keyboard_return,  // Reset functionality
  Icons.shuffle,          // Shuffle/reorder items
  Icons.arrow_back,       // Navigate back
  Icons.arrow_forward     // Navigate forward
];

// --- AdMob demo ad units ---
// Google publishes these and they are the same for every developer, so they are
// constants here rather than .env entries: they are not secret, and keeping them
// in source means a missing .env key can no longer break a debug build. The
// .env key this used to read was removed on 2026-09-02, which left every debug
// build throwing from dotenv.get.
// Production unit IDs stay in .env, because those are ours.
// Only the Android banner is listed: homepage.dart shows AdBannerWidget on
// Android alone, so no other unit is ever requested by this app.
// https://developers.google.com/admob/android/test-ads  (checked 2026-09-02)
// Adaptive banners have their own demo unit. The fixed size one (6300978111)
// only serves 320x50, which makes every adaptive size look like 320x50
const String androidBannerTestId = "ca-app-pub-3940256099942544/9214589741";
