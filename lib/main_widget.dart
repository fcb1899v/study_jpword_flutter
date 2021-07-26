import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'jaword.dart';

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

extension DoubleExt on double {

  double picWidth() {
    return (this < 620) ? this / 2 - 60: 250;
  }

  double picHeight() {
    return (this < 620) ? this / 2 - 60: 250;
  }
}

Widget appBarTitle(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 100,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: Text('たのしくまなぶ・ひらがな・カタカナ',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      )
    ),
  );
}

Widget jaCharView(String char, int num) {
  return SizedBox(
    height: 150,
    child: Text((num == 0) ? char: char.katakanaChar(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: (char.length == 1) ? 100: 70,
      ),
    ),
  );
}

Widget jaWordView(List<String> word, int num){
  return RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      children: [
        TextSpan(text: word[3 * num]),
        TextSpan(text: word[3 * num + 1],
          style: TextStyle(
            color: HexColor('ffa500'),
            decoration: TextDecoration.underline,
          )
        ),
        TextSpan(text: word[3 * num + 2]),
      ],
    )
  );
}

Widget jaWordPictureView(BuildContext context, List<String> picture, int num) {
  return SizedBox(
    width: MediaQuery.of(context).size.width.picWidth(),
    height: MediaQuery.of(context).size.width.picHeight(),
    child: Image.asset(picture[num]),
  );
}

ButtonStyle elevatedButtonStyle(Color color, double radius) {
  return ElevatedButton.styleFrom(
    primary: color, //ボタンの背景色
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
  );
}

Widget audioIcon(BuildContext context){
  return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 60,
      height: 50,
      child: Icon(Icons.audiotrack,
        color: Colors.white,
        size: 30.0,
      )
  );
}

Widget customIcon(BuildContext context, IconData icon) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 4 - 50,
    height: 50,
    child: Icon(icon,
      color: Colors.white,
      size: 30.0,
    ),
  );
}



