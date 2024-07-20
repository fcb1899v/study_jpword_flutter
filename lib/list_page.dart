import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'extension.dart';
import 'constant.dart';
import 'main_page.dart';

class ListPage extends HookConsumerWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      Scaffold(
        ///AppBar
        appBar: AppBar(
          title: Image.asset(appBarImage, width: context.appBarImageWidth()),
          backgroundColor: yellowColor,
          shadowColor: transpColor,
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
            children: List.generate(numberJaWord, (i) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: blueColor),
                child:GridTile(
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
