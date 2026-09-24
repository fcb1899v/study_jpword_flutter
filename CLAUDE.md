# study_jpword_flutter

App-specific implementation notes only.
Cross-app conventions (state management, Firebase/AdMob/ATT, SPM, `.env`, l10n, flutter_tts fork) are maintained separately and out of scope for this file.
No l10n here: no `l10n_extension.dart`/`.arb` — this app is Japanese-only.

## `jaWord()`/`jaWordPicture()` are fixed-length data tables, not validated

Each `case` in `jaWord()` (`lib/extension.dart`) must return exactly 6 strings: `[hiragana-prefix, hiragana-target, hiragana-suffix, katakana-prefix, katakana-target, katakana-suffix]`.
Slot 4 must be the katakana of the case key — it is typed by hand, not derived, and nothing checks it.
`jaWordPicture()` must return exactly 2 paths, aligned the same way.
A new kana added to `allJaWord` (`lib/constant.dart`) without matching cases falls through to `default:` — blank text, a broken `Image.asset("")` — with no compile-time signal.
