import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'extension.dart';
import 'constant.dart';
import 'main_page.dart';

class ListPage extends HookConsumerWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ///App Tracking Transparency
        // if (Platform.isIOS || Platform.isMacOS) {
        //   final status = await AppTrackingTransparency.trackingAuthorizationStatus;
        //   if (status == TrackingStatus.notDetermined && context.mounted) {
        //     await AppTrackingTransparency.requestTrackingAuthorization();
        //   }
        // }
      });
      return null;
    }, []);

    return Scaffold(
      ///AppBar
      appBar: AppBar(
        title: Image.asset(appBarImage,
          width: context.appBarImageWidth()
        ),
        backgroundColor: yellowColor,
        centerTitle: true,
      ),
      ///Body
      body: Container(
        color: yellowColor,
        padding: EdgeInsets.all(listTopMargin),
        child: GridView.count(
          crossAxisCount: context.listRowNumber(),
          crossAxisSpacing: listMargin,
          mainAxisSpacing: listMargin,
          children: List.generate(allJaWord.length, (i) =>
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(listPadding),
              decoration: BoxDecoration(color: blueColor),
              child: GridTile(
                child: TextButton(
                  child: Text(allJaWord[i].hiraganaAndKatakanaChar(),
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: listCharSize,
                    ),
                  ),
                  onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage(index: i))
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
