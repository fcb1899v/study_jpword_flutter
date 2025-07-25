import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'constant.dart';
import 'extension.dart';
import 'tts_manager.dart';
import 'admob_banner.dart';

/// Home Page
/// Main Japanese word learning page that displays characters, words, and images
/// Manages the interactive Japanese learning interface with TTS functionality
class HomePage extends HookConsumerWidget {
  /// Initial index for displaying the first word
  final int index;
  HomePage({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize TTS manager for text-to-speech functionality
    final ttsManager = useMemoized(() => TtsManager(context: context));

    // State management for current word index and list
    final counter = useState(index);
    final jaWordList = useState(allJaWord);
    // Current Japanese word data based on state
    var char = jaWordList.value[counter.value];
    var word = char.jaWord();
    var picture = char.jaWordPicture();
    var sound = char.jaWord().wordSound();
    // UI widget helper for consistent styling
    final home = HomeWidget(context);

    // Initialize TTS and log initial state for debugging
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ttsManager.initTts();
        "Counter: ${counter.value}".debugPrint();
        "JaWordList: ${jaWordList.value}".debugPrint();
      });
      return null;
    }, []);

    /// Handle navigation and list operations
    /// @param i Operation type: 0=original list, 1=shuffle, 2=back, 3=next
    operations(int i) {
      counter.value = counter.value.getCounterValue(i, index);
      jaWordList.value = jaWordList.value.getJaWordListValue(i);
    }

    // Update Japanese word data when counter or list changes
    useEffect(() {
      char = jaWordList.value[counter.value];
      word = char.jaWord();
      picture = char.jaWordPicture();
      sound = char.jaWord().wordSound();
      return null;
    }, [counter.value, jaWordList.value]);

    return Scaffold(
      /// AppBar with title image and back button
      appBar: home.homeAppBar(),
      /// Body with main learning interface
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: context.sideMargin()),
        child: Column(children: [
          Spacer(flex: 1),
          /// Character and word display section
          Row(children: List.generate(5, (i) =>
            (i % 2 == 0) ? Spacer():
            Column(children: [
              /// Japanese character button
              home.charButton(char, index: i,
                onTap: () => ttsManager.speakText(char)
              ),
              /// Word, picture, and audio button section
              GestureDetector(
                onTap: () => ttsManager.speakText(sound[(i - 1)~/2]),
                child: Column(children: [
                  home.wordWidget(word, index: i),
                  home.pictureImage(picture[(i - 1)~/2]),
                  home.audioButtonImage(),
                ]),
              ),
            ]),
          )),
          /// Operation buttons section
          Row(children: List.generate(9, (i) =>
            (i == 2 || i == 6) ? SizedBox(width: context.buttonMargin()):
            (i % 2 == 0) ? Spacer():
            home.operationButton(icons[(i - 1)~/2],
              onTap: () => operations((i - 1)~/2),
            ),
          )),
          Spacer(flex: 1),
          /// Banner advertisement (Android only)
          (Platform.isAndroid) ? AdBannerWidget(): SizedBox(height: context.admobHeight()),
        ]),
      ),
    );
  }
}

/// Helper class for creating UI components with consistent styling
/// Provides reusable widgets for the Japanese learning interface
class HomeWidget {

  /// Build context for accessing theme and navigation
  final BuildContext context;
  HomeWidget(this.context);

  /// Creates the main app bar with title image and back button
  AppBar homeAppBar() => AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios,
        color: whiteColor,
        shadows: [myShadow()],
      ),
      onPressed: () => Navigator.pop(context, true),
    ),
    title: Image.asset(appBarImage,
        width: context.appBarImageWidth()
    ),
    backgroundColor: blueColor,
    centerTitle: true,
  );

  /// Creates interactive character button for Japanese text
  /// @param char The Japanese character to display
  /// @param index Index for character selection (1=katakana, others=hiragana)
  /// @param onTap Callback function when button is tapped
  charButton(String char, {
    required int index,
    required void Function() onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: context.wordSpace()),
      height: context.charHeight(),
      child: Text((index == 1) ? char: char.katakanaChar(),
        style: TextStyle(
          fontSize: context.charSize(char),
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: [myShadow()],
        ),
      ),
    ),
  );

  /// Creates word widget with highlighted Japanese word parts
  /// @param word List of word parts [prefix, sound, suffix]
  /// @param index Index for word selection
  wordWidget(List<String> word, {
    required int index
  }) => Container(
    alignment: Alignment.center,
    width: context.picSize(),
    margin: EdgeInsets.only(bottom: context.wordSpace()),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontSize: context.wordSize(),
          shadows: [myShadow()],
        ),
        children: List.generate(3, (j) => TextSpan(
          text: word[3 * ((index - 1)~/2) + j],
          style: j == 1 ? TextStyle(
            color: yellowColor,
            decoration: TextDecoration.underline,
          ): null,
        )),
      ),
    ),
  );

  /// Creates image container for Japanese word illustration
  /// @param picture Asset path for the image
  pictureImage(String picture) =>  Container(
    alignment: Alignment.center,
    width: context.picSize(),
    height: context.picSize(),
    margin: EdgeInsets.only(bottom: context.wordSpace()),
    child: Image.asset(picture),
  );

  /// Creates audio button with play icon for TTS functionality
  audioButtonImage() => Container(
    width: context.picSize(),
    height: context.buttonHeight(),
    margin: EdgeInsets.only(bottom: context.wordSpace()),
    decoration: BoxDecoration(
      color: blueColor,
      borderRadius: BorderRadius.circular(context.buttonRadius()),
      boxShadow: [myShadow()],
    ),
    child: Icon(
      Icons.audiotrack,
      color: whiteColor,
      size: context.buttonIconSize(),
      shadows: [myShadow()],
    ),
  );

  /// Creates operation button for navigation and list management
  /// @param icon Icon to display on the button
  /// @param onTap Callback function when button is tapped
  Widget operationButton(IconData icon, {
    required void Function() onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: context.buttonWidth(),
      height: context.buttonHeight(),
      decoration: BoxDecoration(
        color: yellowColor,
        borderRadius: BorderRadius.circular(context.buttonRadius()),
        boxShadow: [myShadow()],
      ),
      child: Icon(icon,
        color: whiteColor,
        size: context.buttonIconSize(),
        shadows: [myShadow()],
      ),
    ),
  );
}