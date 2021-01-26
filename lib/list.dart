import 'package:flutter/material.dart';
import 'main.dart';
import 'jaword.dart';
import 'word.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  // ignore: top_level_instance_method
  final jawordlist = JaWordClass().jaWordDefault();
  final blue = HexColor('0077ff'); //鮮やかな青色
  final yellow = HexColor('ffa500'); //山吹色

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: listAppBar(),
        body: listMain(),
        ),
      );
  }

  Widget listMain() {
    return GridView.count(
        crossAxisCount: 4, // 1行に表示する数
        crossAxisSpacing: 4.0, // 縦スペース
        mainAxisSpacing: 4.0, // 横スペース
        //shrinkWrap: true,
        children: List.generate(jawordlist.length, (index) {
            return gridWordList(index);
        })
    );
  }

  Widget listAppBar() {
    return AppBar(
      title: WordClass().AppBarTitle(),
      brightness: Brightness.dark,
      backgroundColor: yellow,
      centerTitle: true,
    );
  }

  Widget gridWordList(index) {
    final katakanatext = JaWordClass().katakanaChar(jawordlist[index]);
    final gridtext = jawordlist[index] + "\n" + katakanatext;
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: blue,
      ),
      child:GridTile(
        child: TextButton(
          child: Text(gridtext,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(index: index)
              ),
            );
          },
        ),
      ),
    );
  }
}

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