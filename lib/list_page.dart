import 'package:flutter/material.dart';
import 'extension.dart';
import 'constant.dart';
import 'main_page.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  late double width;
  late double height;
  late List<String> jaWordList;

  @override
  void initState() {
    super.initState();
    setState(() => jaWordList = allJaWord);
  }

  @override
  void didChangeDependencies() {
    "call didChangeDependencies".debugPrint();
    super.didChangeDependencies();
    setState((){
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
    "width: $width, height: $height".debugPrint();
  }

  @override
  void didUpdateWidget(oldWidget) {
    "call didUpdateWidget".debugPrint();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    "call deactivate".debugPrint();
    super.deactivate();
  }

  @override
  void dispose() {
    "call dispose".debugPrint();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Hiragino"
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Image.asset(appBarImage, width: width.appBarWidth()),
            backgroundColor: yellowColor,
            centerTitle: true,
          ),
          body: GridView.count(
            crossAxisCount: width.listRowNumber(), // 1行に表示する数
            crossAxisSpacing: listMargin, // 縦スペース
            mainAxisSpacing: listMargin, // 横スペース
            //shrinkWrap: true,
            children: List.generate(numberJaWord, (i) => gridWordList(i)),
          ),
        ),
      );

  Widget gridWordList(int i) =>
      Container(
        padding: const EdgeInsets.all(listPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: blueColor),
        child:GridTile(
          child: TextButton(
            child: Text(jaWordList[i],
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: listCharSize,
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPage(i)),
              );
            },
          ),
        ),
      );
}