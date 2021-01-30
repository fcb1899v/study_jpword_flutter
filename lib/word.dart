import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'jaword.dart';

class WordClass {

  wordSound(word, num) {
    return word[3 * num] + word[3 * num + 1] + word[3 * num + 2];
  }

  changeState(charlist, command) {
    final listlength = charlist.length;
    switch (command) {
      case "shuffle":
        charlist.shuffle();
        break;
      case "back":
        var charlast = charlist[listlength - 1];
        charlist.insert(0, charlast);
        charlist.removeAt(listlength);
        break;
      case "next":
        var charfirst = charlist[0];
        charlist.insert(listlength, charfirst);
        charlist.removeAt(0);
    }
  }

  // ignore: non_constant_identifier_names
  Widget AppBarTitle(){
    return Text('たのしくまなぶ・ひらがな・カタカナ',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget makeWord(word, num, color){
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        children: [
          TextSpan(text: word[3 * num]),
          TextSpan(text: word[3 * num + 1],
            style: TextStyle(
              color: color,
              decoration: TextDecoration.underline,
            )
          ),
          TextSpan(text: word[3 * num + 2]),
        ],
      )
    );
  }

  Widget hiraganaCharText(char, index) {
    return Text(
        char[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 75,
        )
    );
  }

  Widget katakanaCharText(char, index) {
    return Text(
        JaWordClass().katakanaChar(char[index]),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 75,
        )
    );
  }

  Widget buttonIcon(icon) {
    return Icon(
      icon,
      color: Colors.white,
      size: 30.0,
    );
  }
}