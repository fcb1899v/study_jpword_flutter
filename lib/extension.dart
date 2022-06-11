import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'constant.dart';

extension StringExt on String {

  void debugPrint() {
    if (kDebugMode) print(this);
  }

  Future<void> speakText(BuildContext context) async {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage('ja-JP');
    //flutterTts.setSpeechRate(0.5);
    await flutterTts.stop();
    await flutterTts.speak(this);
  }

  String katakanaChar() =>
      this.replaceAllMapped(
        new RegExp("[ぁ-ゔ]"), (Match m) => String.fromCharCode(
          m.group(0)!.codeUnitAt(0) + 0x60
        )
      );

  String hiraganaAndKatakanaChar() =>
      "$this\n${this.katakanaChar()}";

  double char2SizeRate() =>
      (this.length == 1) ? charSizeRate : charSizeRate * 0.7;

  List<String> jaWord() {
    switch (this) { //:6
      case "あ": return ["", "あ", "ひる", "", "ア", "イスクリーム"];
      case "い": return ["", "い", "ちご", "", "イ", "ルカ"];
      case "う": return ["", "う", "どん", "", "ウ", "サギ"];
      case "え": return ["", "え", "んぴつ", "", "エ", "レベーター"];
      case "お": return ["", "お", "たまじゃくし", "", "オ", "ムライス"];
      case "か": return ["", "か", "さ", "", "カ", "ブトムシ"];
      case "き": return ["", "き", "つね", "", "キ", "ウイ"];
      case "く": return ["", "く", "じら", "", "ク", "ッキー"];
      case "け": return ["", "け", "しゴム", "", "ケ", "ーキ"];
      case "こ": return ["", "こ", "うもり", "", "コ", "ーヒー"];
      case "さ": return ["", "さ", "つまいも", "", "サ", "メ"];
      case "し": return ["", "し", "んごう", "", "シ", "マウマ"];
      case "す": return ["", "す", "ずめ", "", "ス", "イカ"];
      case "せ": return ["", "せ", "いざ", "", "セ", "ーター"];
      case "そ": return ["", "そ", "ば", "", "ソ", "フトクリーム"];
      case "た": return ["", "た", "いよう", "", "タ", "ヌキ"];
      case "ち": return ["", "ち", "きゅう", "", "チ", "ーズ"];
      case "つ": return ["", "つ", "くし", "", "ツ", "バメ"];
      case "て": return ["", "て", "んとうむし", "", "テ", "ィッシュ"];
      case "と": return ["", "と", "ら", "", "ト", "マト"];
      case "な": return ["", "な", "っとう", "", "ナ", "マズ"];
      case "に": return ["", "に", "じ", "", "ニ", "ンジン"];
      case "ぬ": return ["", "ぬ", "のマスク", "イ", "ヌ", ""];
      case "ね": return ["", "ね", "こ", "", "ネ", "ギ"];
      case "の": return ["", "の", "りまき", "", "ノ", "ート"];
      case "は": return ["", "は", "さみ", "", "ハ", "ンバーガー"];
      case "ひ": return ["", "ひ", "こうき", "", "ヒ", "ツジ"];
      case "ふ": return ["", "ふ", "じさん", "", "フ", "クロウ"];
      case "へ": return ["", "へ", "び", "", "へ", "リコプター"];
      case "ほ": return ["", "ほ", "うれんそう", "", "ホ", "タル"];
      case "ま": return ["", "ま", "ぐろ", "", "マ", "ンゴー"];
      case "み": return ["", "み", "かん", "", "ミ", "ツバチ"];
      case "む": return ["", "む", "しば", "", "ム", "カデ"];
      case "め": return ["", "め", "だか", "", "メ", "ロン"];
      case "も": return ["", "も", "も", "", "モ", "グラ"];
      case "や": return ["", "や", "かん", "", "ヤ", "キソバ"];
      case "ゆ": return ["", "ゆ", "きだるま", "", "ユ", "リ"];
      case "よ": return ["", "よ", "せなべ", "", "ヨ", "ット"];
      case "ら": return ["", "ら", "くだ", "", "ラ", "ムネ"];
      case "り": return ["", "り", "んご", "", "リ", "ス"];
      case "る": return ["かえ", "る", "", "", "ル", "ーペ"];
      case "れ": return ["", "れ", "んこん", "", "レ", "ストラン"];
      case "ろ": return ["", "ろ", "うそく", "", "ロ", "ケット"];
      case "わ": return ["", "わ", "かめ", "", "ワ", "ニ"];
      case "ん": return ["しんかんせ", "ん", "", "キリ", "ン", ""];
      case "が": return ["", "が", "っこう", "", "ガ", "ムテープ"];
      case "ぎ": return ["", "ぎ", "んこう", "", "ギ", "ター"];
      case "ぐ": return ["", "ぐ", "んて", "", "グ", "レープフルーツ"];
      case "げ": return ["", "げ", "んごろう", "", "ゲ", "ーム"];
      case "ご": return ["", "ご", "ぼう", "", "ゴ", "リラ"];
      case "ざ": return ["", "ざ", "くろ", "", "ザ", "リガニ"];
      case "じ": return ["", "じ", "んじゃ", "", "ジ", "ェットコースター"];
      case "ず": return ["", "ず", "んだもち", "", "ズ", "ッキーニ"];
      case "ぜ": return ["", "ぜ", "んざい", "", "ゼ", "リー"];
      case "ぞ": return ["", "ぞ", "うに", "", "ゾ", "ウ"];
      case "だ": return ["", "だ", "いぶつ", "", "ダ", "チョウ"];
      case "づ": return ["みか", "づ", "き", "オリ", "ヅ", "ル"];
      case "で": return ["", "で", "んしゃ", "", "デ", "ィスプレイ"];
      case "ど": return ["", "ど", "んぐり", "", "ド", "ーナツ"];
      case "ば": return ["", "ば", "ら", "", "バ", "イク"];
      case "び": return ["", "び", "わ", "", "ビ", "ル"];
      case "ぶ": return ["", "ぶ", "どう", "", "ブ", "タ"];
      case "べ": return ["お", "べ", "んとう", "", "べ", "スト"];
      case "ぼ": return ["あかとん", "ぼ", "", "", "ボ", "ール"];
      case "ぱ": return ["かっ", "ぱ", "", "", "パ", "ンダ"];
      case "ぴ": return ["はっ", "ぴ", "", "", "ピ", "ザ"];
      case "ぷ": return ["おん", "ぷ", "", "", "プ", "リン"];
      case "ぺ": return ["", "ぺ", "んぎん", "", "ペ", "ットボトル"];
      case "ぽ": return ["きりたん", "ぽ", "なべ", "", "ポ", "ット"];
      case "きゃ": return ["", "きゃ", "べつ", "", "キャ", "ンプファイヤー"];
      case "きゅ": return ["", "きゅ", "うきゅうしゃ", "", "キュ", "ウリ"];
      case "きょ": return ["", "きょ", "うりゅう", "ラッ", "キョ", "ウ"];
      case "しゃ": return ["", "しゃ", "ち", "", "シャ", "ツ"];
      case "しゅ": return ["", "しゅ", "りけん", "", "シュ", "ーマイ"];
      case "しょ": return ["", "しょ", "くパン", "", "ショ", "ッピングモール"];
      case "ちゃ": return ["あか", "ちゃ", "ん", "ガチャガ", "チャ", ""];
      case "ちゅ": return ["", "ちゅ", "うしゃ", "", "チュ", "ーリップ"];
      case "ちょ": return ["", "ちょ", "うちょ", "", "チョ", "コレート"];
      case "ひょ": return ["", "ひょ", "うたん", "", "ヒョ", "ウ"];
      case "りゅ": return ["", "りゅ", "う", "", "リュ", "ック"];
      case "ぎゅ": return ["", "ぎゅ", "うどん", "フィ", "ギュ", "アスケート"];
      case "ぎょ": return ["きん", "ぎょ", "", "", "ギョ", "ーザ"];
      case "じゃ": return ["", "じゃ", "んけん", "", "ジャ", "ガイモ"];
      case "じゅ": return ["もみじまん", "じゅ", "う", "", "ジュ", "ース"];
      case "じょ": return ["", "じょ", "うききかんしゃ", "", "ジョ", "ウロ"];
      case "びょ": return ["", "びょ", "ういん", "ガ", "ビョ", "ウ"];
      default: return ["","","", "","",""];
    }
  }

  List<String> jaWordPicture() {
    switch (this) {
      case "あ": return ["assets/image/ahiru.png", "assets/image/aisukurimu.png"];
      case "い": return ["assets/image/ichigo.png", "assets/image/iruka.png"];
      case "う": return ["assets/image/udon.png", "assets/image/usagi.png"];
      case "え": return ["assets/image/enpitsu.png", "assets/image/elevator.png"];
      case "お": return ["assets/image/otamajakushi.png", "assets/image/omurice.png"];
      case "か": return ["assets/image/kasa.png", "assets/image/kabutomushi.png"];
      case "き": return ["assets/image/kitsune.png", "assets/image/kiwi.png"];
      case "く": return ["assets/image/kujira.png", "assets/image/cookie.png"];
      case "け": return ["assets/image/keshigomu.png", "assets/image/cake.png"];
      case "こ": return ["assets/image/koumori.png", "assets/image/coffee.png"];
      case "さ": return ["assets/image/satsumaimo.png", "assets/image/same.png"];
      case "し": return ["assets/image/shingo.png", "assets/image/shimauma.png"];
      case "す": return ["assets/image/suzume.png", "assets/image/suika.png"];
      case "せ": return ["assets/image/seiza.png", "assets/image/sweater.png"];
      case "そ": return ["assets/image/soba.png", "assets/image/softcream.png"];
      case "た": return ["assets/image/taiyo.png", "assets/image/tanuki.png"];
      case "ち": return ["assets/image/chikyu.png", "assets/image/cheese.png"];
      case "つ": return ["assets/image/tsukushi.png", "assets/image/tsubame.png"];
      case "て": return ["assets/image/tentoumushi.png", "assets/image/tissue.png"];
      case "と": return ["assets/image/tora.png", "assets/image/tomato.png"];
      case "な": return ["assets/image/natto.png", "assets/image/namazu.png"];
      case "に": return ["assets/image/niji.png", "assets/image/ninjin.png"];
      case "ぬ": return ["assets/image/nunomask.png", "assets/image/inu.png"];
      case "ね": return ["assets/image/neko.png", "assets/image/negi.png"];
      case "の": return ["assets/image/norimaki.png", "assets/image/note.png"];
      case "は": return ["assets/image/hasami.png", "assets/image/hamberger.png"];
      case "ひ": return ["assets/image/hikouki.png", "assets/image/hitsuji.png"];
      case "ふ": return ["assets/image/fujisan.png", "assets/image/fukurou.png"];
      case "へ": return ["assets/image/hebi.png", "assets/image/helicopter.png"];
      case "ほ": return ["assets/image/hourensou.png", "assets/image/hotaru.png"];
      case "ま": return ["assets/image/maguro.png", "assets/image/mango.png"];
      case "み": return ["assets/image/mikan.png", "assets/image/mitsubachi.png"];
      case "む": return ["assets/image/mushiba.png", "assets/image/mukade.png"];
      case "め": return ["assets/image/medaka.png", "assets/image/melon.png"];
      case "も": return ["assets/image/momo.png", "assets/image/mogura.png"];
      case "や": return ["assets/image/yakan.png", "assets/image/yakisoba.png"];
      case "ゆ": return ["assets/image/yukidaruma.png", "assets/image/yuri.png"];
      case "よ": return ["assets/image/yosenabe.png", "assets/image/yacht.png"];
      case "ら": return ["assets/image/rakuda.png", "assets/image/ramune.png"];
      case "り": return ["assets/image/ringo.png", "assets/image/risu.png"];
      case "る": return ["assets/image/kaeru.png", "assets/image/rupe.png"];
      case "れ": return ["assets/image/renkon.png", "assets/image/restaurant.png"];
      case "ろ": return ["assets/image/rousoku.png", "assets/image/rocket.png"];
      case "わ": return ["assets/image/wakame.png", "assets/image/wani.png"];
      case "ん": return ["assets/image/shinkansen.png", "assets/image/kirin.png"];
      case "が": return ["assets/image/gakkou.png", "assets/image/gumtape.png"];
      case "ぎ": return ["assets/image/ginkou.png", "assets/image/guitar.png"];
      case "ぐ": return ["assets/image/gunte.png", "assets/image/grapefruit.png"];
      case "げ": return ["assets/image/gengorou.png", "assets/image/game.png"];
      case "ご": return ["assets/image/gobou.png", "assets/image/gorilla.png"];
      case "ざ": return ["assets/image/zakuro.png", "assets/image/zarigani.png"];
      case "じ": return ["assets/image/jinjya.png", "assets/image/jetcoaster.png"];
      case "ず": return ["assets/image/zundamochi.png", "assets/image/zucchini.png"];
      case "ぜ": return ["assets/image/zenzai.png", "assets/image/jelly.png"];
      case "ぞ": return ["assets/image/zouni.png", "assets/image/zou.png"];
      case "だ": return ["assets/image/daibutsu.png", "assets/image/dacho.png"];
      case "づ": return ["assets/image/mikaduki.png", "assets/image/oriduru.png"];
      case "で": return ["assets/image/densha.png", "assets/image/display.png"];
      case "ど": return ["assets/image/donguri.png", "assets/image/donut.png"];
      case "ば": return ["assets/image/bara.png", "assets/image/bike.png"];
      case "び": return ["assets/image/biwa.png", "assets/image/building.png"];
      case "ぶ": return ["assets/image/budou.png", "assets/image/buta.png"];
      case "べ": return ["assets/image/bento.png", "assets/image/vest.png"];
      case "ぼ": return ["assets/image/akatombo.png", "assets/image/ball.png"];
      case "ぱ": return ["assets/image/kappa.png", "assets/image/panda.png"];
      case "ぴ": return ["assets/image/happi.png", "assets/image/pizza.png"];
      case "ぷ": return ["assets/image/onpu.png", "assets/image/pudding.png"];
      case "ぺ": return ["assets/image/penguin.png", "assets/image/petbuttle.png"];
      case "ぽ": return ["assets/image/kiritamponabe.png", "assets/image/pot.png"];
      case "きゃ": return ["assets/image/kyabetsu.png", "assets/image/campfire.png"];
      case "きゅ": return ["assets/image/kyukyusha.png", "assets/image/kyuri.png"];
      case "きょ": return ["assets/image/kyoryu.png", "assets/image/rakkyo.png"];
      case "しゃ": return ["assets/image/shachi.png", "assets/image/shirt.png"];
      case "しゅ": return ["assets/image/shuriken.png", "assets/image/shumai.png"];
      case "しょ": return ["assets/image/shokupan.png", "assets/image/shoppingmall.png"];
      case "ちゃ": return ["assets/image/akachan.png", "assets/image/gachagacha.png"];
      case "ちゅ": return ["assets/image/chusha.png", "assets/image/turip.png"];
      case "ちょ": return ["assets/image/chocho.png", "assets/image/chocolate.png"];
      case "ひょ": return ["assets/image/hyotan.png", "assets/image/hyo.png"];
      case "りゅ": return ["assets/image/ryu.png", "assets/image/ruck.png"];
      case "ぎゅ": return ["assets/image/gyudon.png", "assets/image/figureskate.png"];
      case "ぎょ": return ["assets/image/kingyo.png", "assets/image/gyoza.png"];
      case "じゃ": return ["assets/image/janken.png", "assets/image/jagaimo.png"];
      case "じゅ": return ["assets/image/momijimanjyu.png", "assets/image/juice.png"];
      case "じょ": return ["assets/image/jyokikikansha.png", "assets/image/jyouro.png"];
      case "びょ": return ["assets/image/byoin.png", "assets/image/gabyo.png"];
      default: return ["", ""];
    }
  }
}

extension ListStringExt on List<String> {

  List<String> wordSound() =>
      ["${this[0]}${this[1]}${this[2]}", "${this[3]}${this[4]}${this[5]}"];

  String printWord() =>
      "${this[0]}${this[1]}${this[2]}, ${this[3]}${this[4]}${this[5]}";
}

extension DoubleExt on double {

  int listRowNumber() => this ~/ 100 + 1;
  double appBarWidth() => (this < 620) ? this * appBarWidthRate: appBarMaxWidth;
  double picWidth() => (this < 620) ? this / 2 - 60: picMaxWidth;
  double picHeight() => (this < 620) ? this / 2 - 60: picMaxWidth;
}
