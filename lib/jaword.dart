
class JaWordClass {

  // ignore: non_constant_identifier_names
  jaWordDefault() {
    return [
      "あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ",
      "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と",
      "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ",
      "ま", "み", "む", "め", "も", "や", "ゆ", "よ",
      "ら", "り", "る", "れ", "ろ", "わ", "ん",
      "が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ", "ぞ",
      "だ", "づ", "で", "ど", "ば", "び", "ぶ", "べ", "ぼ",
      "ぱ", "ぴ", "ぷ", "ぺ", "ぽ"
      // "きゃ", "きゅ", "きょ", "しゃ", "しゅ", "しょ", "ちゃ", "ちゅ", "ちょ",
      // "にゃ", "にゅ", "にょ", "ひゃ", "ひゅ", "ひょ", "みゃ", "みゅ", "みょ",
      // "りゃ", "りゅ", "りょ", "ぎゃ", "ぎゅ", "ぎょ", "じゃ", "じゅ", "じょ",
      // "びゃ", "びゅ", "びょ", "ぴゃ", "ぴゅ", "ぴょ",
    ];
  }

  String katakanaChar(String word) {
    return word.replaceAllMapped(new RegExp("[ぁ-ゔ]"), (Match m) =>
        String.fromCharCode(m.group(0).codeUnitAt(0) + 0x60));
  }

  jaWord(String word) {
    switch (word) {
      case "あ": return ["", "あ", "ひる", "", "ア", "イスクリーム"];
      case "い": return ["", "い", "ぬ", "", "イ", "チゴ"];
      case "う": return ["", "う", "どん", "", "ウ", "サギ"];
      case "え": return ["", "え", "んぴつ", "", "エ", "レベーター"];
      case "お": return ["", "お", "たまじゃくし", "", "オ", "ムライス"];
      case "か": return ["", "か", "える", "", "カ", "ブトムシ"];
      case "き": return ["", "き", "んぎょ", "", "キ", "ウイ"];
      case "く": return ["", "く", "じら", "", "ク", "ッキー"];
      case "け": return ["", "け", "しゴム", "", "ケ", "ーキ"];
      case "こ": return ["", "こ", "うもり", "", "コ", "ーヒー"];
      case "さ": return ["", "さ", "つまいも", "", "サ", "メ"];
      case "し": return ["", "し", "ろ", "", "シ", "マウマ"];
      case "す": return ["", "す", "ずめ", "", "ス", "イカ"];
      case "せ": return ["", "せ", "いざ", "", "セ", "ミ"];
      case "そ": return ["", "そ", "うじき", "", "ソ", "フトクリーム"];
      case "た": return ["", "た", "いよう", "", "タ", "ヌキ"];
      case "ち": return ["", "ち", "きゅう", "", "チ", "ーズ"];
      case "つ": return ["", "つ", "くし", "", "ツ", "バメ"];
      case "て": return ["", "て", "んとうむし", "", "テ", "ィッシュ"];
      case "と": return ["", "と", "ら", "", "ト", "マト"];
      case "な": return ["", "な", "っとう", "", "ナ", "マズ"];
      case "に": return ["", "に", "じ", "", "ニ", "ンジン"];
      case "ぬ": return ["", "ぬ", "いぐるみ", "", "ヌ", "ノマスク"];
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
      case "や": return ["", "や", "きそば", "", "ヤ", "ギ"];
      case "ゆ": return ["", "ゆ", "きだるま", "", "ユ", "リ"];
      case "よ": return ["", "よ", "うなし", "", "ヨ", "ット"];
      case "ら": return ["", "ら", "くだ", "", "ラ", "ムネ"];
      case "り": return ["", "り", "んご", "", "リ", "ス"];
      case "る": return ["", "る", "ーぺ", "", "ル", "ビー"];
      case "れ": return ["", "れ", "もん", "", "レ", "ストラン"];
      case "ろ": return ["", "ろ", "うそく", "", "ロ", "ケット"];
      case "わ": return ["", "わ", "かめ", "", "ワ", "ニ"];
      case "ん": return ["しんかんせ", "ん", "", "キリ", "ン", ""];
      case "が": return ["", "が", "っこう", "", "ガ", "ムテープ"];
      case "ぎ": return ["", "ぎ", "んこう", "", "ギ", "ター"];
      case "ぐ": return ["", "ぐ", "んて", "", "グ", "レープフルーツ"];
      case "げ": return ["", "げ", "んごろう", "", "ゲ", "ーム"];
      case "ご": return ["", "ご", "ぼう", "", "ゴ", "リラ"];
      case "ざ": return ["", "ざ", "るそば", "", "ザ", "リガニ"];
      case "じ": return ["", "じ", "んじゃ", "", "ジ", "ェットコースター"];
      case "ず": return ["", "ず", "んだもち", "", "ズ", "ッキーニ"];
      case "ぜ": return ["", "ぜ", "んざい", "", "ゼ", "リー"];
      case "ぞ": return ["", "ぞ", "うに", "", "ゾ", "ウ"];
      case "だ": return ["", "だ", "いぶつ", "", "ダ", "チョウ"];
      case "づ": return ["みか", "づ", "き", "オリ", "ヅ", "ル"];
      case "で": return ["", "で", "んしゃ", "", "デ", "ィスプレイ"];
      case "ど": return ["", "ど", "んぐり", "", "ド", "ーナツ"];
      case "ば": return ["", "ば", "った", "", "バ", "ナナ"];
      case "び": return ["", "び", "わ", "", "ビ", "ル"];
      case "ぶ": return ["", "ぶ", "どう", "", "ブ", "タ"];
      case "べ": return ["", "べ", "ーこん", "", "べ", "スト"];
      case "ぼ": return ["", "ぼ", "んど", "", "ボ", "ール"];
      case "ぱ": return ["", "ぱ", "んだ", "", "パ", "イナップル"];
      case "ぴ": return ["", "ぴ", "ーまん", "", "ピ", "ザ"];
      case "ぷ": return ["", "ぷ", "りん", "", "プ", "レゼント"];
      case "ぺ": return ["", "ぺ", "んぎん", "", "ペ", "ットボトル"];
      case "ぽ": return ["", "ぽ", "っと", "", "ポ", "テトチップス"];
      default: return ["","","", "","",""];
    }
  }

  jaWordPicture(String word) {
    switch (word) {
      case "あ": return ["assets/image/ahiru.png", "assets/image/aisukurimu.png"];
      case "い": return ["assets/image/inu.png", "assets/image/ichigo.png"];
      case "う": return ["assets/image/udon.png", "assets/image/usagi.png"];
      case "え": return ["assets/image/enpitsu.png", "assets/image/elevator.png"];
      case "お": return ["assets/image/otamajakushi.png", "assets/image/omurice.png"];
      case "か": return ["assets/image/kaeru.png", "assets/image/kabutomushi.png"];
      case "き": return ["assets/image/kingyo.png", "assets/image/kiwi.png"];
      case "く": return ["assets/image/kujira.png", "assets/image/cookie.png"];
      case "け": return ["assets/image/keshigomu.png", "assets/image/cake.png"];
      case "こ": return ["assets/image/koumori.png", "assets/image/coffee.png"];
      case "さ": return ["assets/image/satsumaimo.png", "assets/image/same.png"];
      case "し": return ["assets/image/shiro.png", "assets/image/shimauma.png"];
      case "す": return ["assets/image/suzume.png", "assets/image/suika.png"];
      case "せ": return ["assets/image/seiza.png", "assets/image/semi.png"];
      case "そ": return ["assets/image/soujiki.png", "assets/image/softcream.png"];
      case "た": return ["assets/image/taiyo.png", "assets/image/tanuki.png"];
      case "ち": return ["assets/image/chikyu.png", "assets/image/cheese.png"];
      case "つ": return ["assets/image/tsukushi.png", "assets/image/tsubame.png"];
      case "て": return ["assets/image/tentoumushi.png", "assets/image/tissue.png"];
      case "と": return ["assets/image/tora.png", "assets/image/tomato.png"];
      case "な": return ["assets/image/natto.png", "assets/image/namazu.png"];
      case "に": return ["assets/image/niji.png", "assets/image/ninjin.png"];
      case "ぬ": return ["assets/image/nuigurumi.png", "assets/image/nunomask.png"];
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
      case "や": return ["assets/image/yakisoba.png", "assets/image/yagi.png"];
      case "ゆ": return ["assets/image/yukidaruma.png", "assets/image/yuri.png"];
      case "よ": return ["assets/image/younashi.png", "assets/image/yacht.png"];
      case "ら": return ["assets/image/rakuda.png", "assets/image/ramune.png"];
      case "り": return ["assets/image/ringo.png", "assets/image/risu.png"];
      case "る": return ["assets/image/rupe.png", "assets/image/ruby.png"];
      case "れ": return ["assets/image/lemon.png", "assets/image/restaurant.png"];
      case "ろ": return ["assets/image/rousoku.png", "assets/image/rocket.png"];
      case "わ": return ["assets/image/wakame.png", "assets/image/wani.png"];
      case "ん": return ["assets/image/shinkansen.png", "assets/image/kirin.png"];
      case "が": return ["assets/image/gakkou.png", "assets/image/gumtape.png"];
      case "ぎ": return ["assets/image/ginkou.png", "assets/image/guitar.png"];
      case "ぐ": return ["assets/image/gunte.png", "assets/image/grapefruit.png"];
      case "げ": return ["assets/image/gengorou.png", "assets/image/game.png"];
      case "ご": return ["assets/image/gobou.png", "assets/image/gorilla.png"];
      case "ざ": return ["assets/image/zarusoba.png", "assets/image/zarigani.png"];
      case "じ": return ["assets/image/jinjya.png", "assets/image/jetcoaster.png"];
      case "ず": return ["assets/image/zundamochi.png", "assets/image/zucchini.png"];
      case "ぜ": return ["assets/image/zenzai.png", "assets/image/jelly.png"];
      case "ぞ": return ["assets/image/zouni.png", "assets/image/zou.png"];
      case "だ": return ["assets/image/daibutsu.png", "assets/image/dacho.png"];
      case "づ": return ["assets/image/mikaduki.png", "assets/image/oriduru.png"];
      case "で": return ["assets/image/densha.png", "assets/image/display.png"];
      case "ど": return ["assets/image/donguri.png", "assets/image/donut.png"];
      case "ば": return ["assets/image/batta.png", "assets/image/banana.png"];
      case "び": return ["assets/image/biwa.png", "assets/image/building.png"];
      case "ぶ": return ["assets/image/budou.png", "assets/image/buta.png"];
      case "べ": return ["assets/image/bacon.png", "assets/image/vest.png"];
      case "ぼ": return ["assets/image/bond.png", "assets/image/ball.png"];
      case "ぱ": return ["assets/image/panda.png", "assets/image/pineapple.png"];
      case "ぴ": return ["assets/image/piman.png", "assets/image/pizza.png"];
      case "ぷ": return ["assets/image/pudding.png", "assets/image/present.png"];
      case "ぺ": return ["assets/image/penguin.png", "assets/image/petbuttle.png"];
      case "ぽ": return ["assets/image/pot.png", "assets/image/potatochips.png"];
      default: return ["", ""];
    }
  }
}