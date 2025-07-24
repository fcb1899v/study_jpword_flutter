import 'package:flutter/material.dart';
import 'package:jpword_app/extension.dart';

import 'constant.dart';

//0: Reset, 1: Shuffle, 2: Back, 3:Next
List<IconData> icons = [
  Icons.keyboard_return,
  Icons.shuffle,
  Icons.arrow_back,
  Icons.arrow_forward
];

//Widget
BoxShadow myShadow() => BoxShadow(
  color: Colors.grey, //色
  spreadRadius: 2,
  blurRadius: 4,
  offset: Offset(2, 2),
);

IconButton backButton(BuildContext context) => IconButton(
  icon: Icon(Icons.arrow_back_ios,
    color: whiteColor,
    shadows: [myShadow()],
  ),
  onPressed: () => Navigator.pop(context, true),
);

charWidget(BuildContext context, String char, int i) => Container(
  alignment: Alignment.bottomCenter,
  margin: EdgeInsets.only(bottom: context.wordSpace()),
  height: context.charHeight(),
  child: Text((i == 1) ? char: char.katakanaChar(),
    style: TextStyle(
      fontSize: context.charSize(char),
      fontWeight: FontWeight.bold,
      color: Colors.black,
      shadows: [myShadow()],
    ),
  ),
);

wordWidget(BuildContext context, List<String> word, int i) => Container(
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
        text: word[3 * ((i - 1)~/2) + j],
        style: j == 1 ? TextStyle(
          color: yellowColor,
          decoration: TextDecoration.underline,
        ): null,
      )),
    ),
  ),
);

pictureImage(BuildContext context, String picture) =>  Container(
  alignment: Alignment.center,
  width: context.picSize(),
  height: context.picSize(),
  margin: EdgeInsets.only(bottom: context.wordSpace()),
  child: Image.asset(picture),
);

audioButtonImage(BuildContext context) => Container(
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

operationButtonImage(BuildContext context, IconData icon) => Container(
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
);
