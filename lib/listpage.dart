import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'extension.dart';
import 'constant.dart';
import 'homepage.dart';

/// List Page
/// Main navigation page that displays all Japanese words in a grid layout
/// Provides access to individual word learning pages
class ListPage extends HookConsumerWidget {
  ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // UI widget helper for consistent styling
    final list = ListWidget(context);

    return Scaffold(
      /// AppBar with title image
      appBar: list.listAppBar(),
      /// Body with grid layout of Japanese words
      body: Container(
        color: yellowColor,
        padding: EdgeInsets.all(listTopMargin),
        child: GridView.count(
          // Configure grid layout with responsive column count
          crossAxisCount: context.listRowNumber(),
          crossAxisSpacing: listMargin,
          mainAxisSpacing: listMargin,
          // Generate grid items for all Japanese words
          children: List.generate(allJaWord.length, (i) =>
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(listPadding),
              decoration: BoxDecoration(color: blueColor),
              child: GridTile(
                child: TextButton(
                  // Display hiragana and katakana characters
                  child: Text(allJaWord[i].hiraganaAndKatakanaChar(),
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: listCharSize,
                    ),
                  ),
                  // Navigate to HomePage with selected word index
                  onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(index: i))
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper class for creating list page UI components
/// Provides reusable widgets for the word selection interface
class ListWidget {

  /// Build context for accessing theme and navigation
  final BuildContext context;
  ListWidget(this.context);

  /// Creates the app bar with title image and yellow background
  AppBar listAppBar() => AppBar(
    title: Image.asset(appBarImage,
      width: context.appBarImageWidth()
    ),
    backgroundColor: yellowColor,
    centerTitle: true,
  );
}
