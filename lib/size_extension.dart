// ===== SizeExt: responsive layout sizes (part of extension.dart) =====
part of 'extension.dart';

extension SizeExt on BuildContext {
  // Responsive sizing methods based on screen dimensions
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;
  double appBarImageWidth() => (width() < 600) ? width() * 0.8: 480;
  double appBarHeight() => (width() < 600) ? width() * 0.15: 90;
  double sideMargin() => height() * 0.005;
  double picSize() => height() * 0.18;
  double charHeight() => height() * 0.2;
  double charSize(String char) => height() * ((char.length == 1) ? 0.12: 0.089);
  double wordSize() => height() * 0.02;
  double wordSpace() => height() * 0.04;
  double buttonWidth() => height() * 0.08;
  double buttonMargin() => height() * 0.02;
  double buttonIconSize() => height() * 0.03;
  double buttonHeight() => height() * 0.05;
  double buttonRadius() => height() * 0.03;
  double admobHeight() => (height() < 600) ? 50: (height() < 1000) ? 50 + (height() - 600) / 8: 100;
  double admobWidth() => width();

  // Grid layout for phonics list
  int listRowNumber() => width() ~/ 100 + 1;
}
