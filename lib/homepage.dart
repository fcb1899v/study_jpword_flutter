import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jpword_app/tts_manager.dart';
import 'common_widget.dart';
import 'constant.dart';
import 'extension.dart';
import 'admob_banner.dart';

class MainPage extends HookConsumerWidget {
  final int index;
  MainPage({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize TTS manager for text-to-speech functionality
    final ttsManager = useMemoized(() => TtsManager(context: context));

    final counter = useState(index);
    final jaWordList = useState(allJaWord);
    var char = jaWordList.value[counter.value];
    var word = char.jaWord();
    var picture = char.jaWordPicture();
    var sound = char.jaWord().wordSound();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ttsManager.initTts();
        "Counter: ${counter.value}".debugPrint();
        "JaWordList: ${jaWordList.value}".debugPrint();
      });
      return null;
    }, []);

    operations(int i) {
      counter.value = counter.value.getCounterValue(i, index);
      jaWordList.value = jaWordList.value.getJaWordListValue(i);
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
        leading: backButton(context),
        title: Image.asset(appBarImage,
          width: context.appBarImageWidth()
        ),
        backgroundColor: blueColor,
        centerTitle: true,
      ),
      ///Body
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: context.sideMargin()),
        child: Column(children: [
          Spacer(flex: 1),
          Row(children: List.generate(5, (i) =>
            (i % 2 == 0) ? Spacer():
            Column(children: [
              ///Char
              GestureDetector(
                onTap: () => char.speakText(context, flutterTts),
                child: charWidget(context, char, i),
              ),
              GestureDetector(
                onTap: () => sound[(i - 1)~/2].speakText(context, flutterTts),
                child: Column(children: [
                  wordWidget(context, word, i),
                  pictureImage(context, picture[(i - 1)~/2]),
                  audioButtonImage(context)
                ]),
              ),
            ]),
          )),
          Row(children: List.generate(9, (i) =>
            (i == 2 || i == 6) ? SizedBox(width: context.buttonMargin()):
            (i % 2 == 0) ? Spacer():
            GestureDetector(
              onTap: () => operations((i - 1)~/2),
              child: operationButtonImage(context, icons[(i - 1)~/2])
            ),
          )),
          Spacer(flex: 1),
          (Platform.isAndroid) ? AdBannerWidget(): SizedBox(height: context.admobHeight()),
        ]),
      ),
    );
  }
}