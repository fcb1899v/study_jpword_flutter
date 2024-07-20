import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'constant.dart';
import 'extension.dart';
import 'admob_banner.dart';

class MainPage extends HookConsumerWidget {
  final int index;
  MainPage({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final FlutterTts flutterTts = FlutterTts();
    final counter = useState(index);
    final jaWordList = useState(allJaWord);
    var char = jaWordList.value[counter.value];
    var word = char.jaWord();
    var picture = char.jaWordPicture();
    var sound = char.jaWord().wordSound();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await flutterTts.setSharedInstance(true);
        await flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
          ]
        );
        await flutterTts.setVolume(1);
        await flutterTts.setLanguage("ja-JP");
        await flutterTts.setSpeechRate(0.45);
        await flutterTts.setPitch(1.0);
        "Counter: ${counter.value}, JaWordList: ${jaWordList.value}".debugPrint();
      });
      return null;
    }, []);

    //0: Reset, 1: Shuffle, 2: Back, 3:Next
    final icons = [
      Icons.keyboard_return,
      Icons.shuffle,
      Icons.arrow_back,
      Icons.arrow_forward
    ];
    operations(int i) {
      final List<String> list = List<String>.from(allJaWord);
      if (i == 1) list.shuffle();
      counter.value =
        (i == 2) ? counter.value.backNumber():
        (i == 3) ? counter.value.nextNumber():
        index;
      "Counter: ${counter.value}".debugPrint();
      jaWordList.value =
        (i == 0) ? allJaWord:
        (i == 1) ? list:
        jaWordList.value;
      if (i == 1) "PhonicsList: ${jaWordList.value}".debugPrint();
    }

    useEffect(() {
      char = jaWordList.value[counter.value];
      word = char.jaWord();
      picture = char.jaWordPicture();
      sound = char.jaWord().wordSound();
      return null;
    }, [counter.value, jaWordList.value]);

    return Scaffold(
      ///AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: whiteColor,
            shadows: [myShadow()]
          ),
          onPressed: () => Navigator.pop(context, true),
        ),
        backgroundColor: blueColor,
        title: Image.asset(appBarImage,
          width: context.appBarImageWidth()
        ),
        centerTitle: true,
      ),
      ///Body
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: context.width() * horizontalMarginRate),
        child: Column(children: [
          Spacer(flex: 1),
          Row(children: [ for (int i = 0; i < 2; i++) ... {
            ///Char
            Container(
              width: context.width() * wordWidthRate,
              margin: EdgeInsets.only(bottom: context.height() * wordSpaceRate),
              child: Column(children: [
                GestureDetector(
                  onTap: () => char.speakText(context, flutterTts),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: context.height() * wordSpaceRate),
                    height: context.width() * charHeightRate,
                    child: Text((i == 0) ? char: char.katakanaChar(),
                      style: TextStyle(
                        fontSize: context.width() * char.char2SizeRate(),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [myShadow()],
                      ),
                    ),
                  ),
                ),
                ///Word
                GestureDetector(
                  onTap: () => sound[i].speakText(context, flutterTts),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(bottom: context.height() * wordSpaceRate),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: context.width() * wordSizeRate,
                            shadows: [myShadow()],
                          ),
                          children: [ for (int j = 0; j < 3; j++)
                            TextSpan(text: word[3 * i + j],
                              style: (j == 1) ? TextStyle(
                                color: yellowColor,
                                decoration: TextDecoration.underline,
                              ): null
                            ),
                          ],
                        ),
                      ),
                    ),
                    ///Image
                    Container(
                      width: context.picWidth(),
                      height: context.picHeight(),
                      margin: EdgeInsets.only(bottom: context.height() * wordSpaceRate),
                      child: Image.asset(picture[i]),
                    ),
                    ///Sound Button
                    Container(
                      width: context.width() * largeButtonWidthRate,
                      height: buttonHeight,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(buttonRadius),
                        boxShadow: [myShadow()],
                      ),
                      child: Icon(Icons.audiotrack,
                        color: whiteColor,
                        size: buttonIconSize,
                        shadows: [myShadow()],
                      ),
                    )
                  ]),
                ),
              ]),
            ),
            if (i == 0) Spacer(flex: 1)
          }]),
          Row(children: [ for(int i = 0; i < 4; i++) ... {
            ///Operation Button
            GestureDetector(
              onTap: () => operations(i),
              child: Container(
                width: context.width() * smallButtonWidthRate,
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.circular(buttonRadius),
                  boxShadow: [myShadow()],
                ),
                child: Icon(icons[i],
                  color: whiteColor,
                  size: buttonIconSize,
                  shadows: [myShadow()],
                ),
              ),
            ),
            if (i != 3) Spacer(flex: 1),
          }]),
          Spacer(flex: 1),
          AdBannerWidget(),
        ]),
      ),
    );
  }
}