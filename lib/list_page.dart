import 'package:flutter/material.dart';
import 'main_page.dart';
import 'main_widget.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  late List<String> jaWordList;

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
        // "にゃ", "にゅ", "にょ", "ひゃ", "ひゅ", "みゃ", "みゅ",
        // "みょ", "りゃ", "りょ", "ぎゃ",
        "ぎゅ", "ぎょ", "じゃ", "じゅ", "じょ", "びょ",
        // "びゃ", "びゅ", "ぴゃ", "ぴゅ", "ぴょ",
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: appBarTitle(),
          backgroundColor: HexColor('ffa500'),
          centerTitle: true,
        ),
        body: GridView.count(
          crossAxisCount: 4, // 1行に表示する数
          crossAxisSpacing: 4.0, // 縦スペース
          mainAxisSpacing: 4.0, // 横スペース
          //shrinkWrap: true,
          children: List.generate(jaWordList.length, (index) {
            return gridWordList(index);
          })
        ),
      ),
    );
  }

  Widget gridWordList(index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: HexColor('0077ff'),
      ),
      child:GridTile(
        child: TextButton(
          child: Text(jaWordList[index],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(index)
              ),
            );
          },
        ),
      ),
    );
  }
}