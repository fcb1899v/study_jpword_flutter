/// Text-to-Speech Manager
/// 
/// Manages text-to-speech functionality for the phonics learning app.
/// Handles voice selection, speech synthesis, and platform-specific configurations.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'extension.dart';

/// Text-to-Speech Manager
/// Handles all TTS operations including voice selection, speech synthesis,
/// and platform-specific configurations for iOS and Android.
class TtsManager {
  final BuildContext context;
  TtsManager({required this.context});

  /// FlutterTts instance for speech synthesis
  final FlutterTts flutterTts = FlutterTts();

  // =============================================================================
  // VOICE CONFIGURATION
  // =============================================================================

  /// Default TTS locale for English (US)
  static const String ttsLocale = "ja-JP";
  /// Android voice name for English language
  static const String androidVoiceName = "ja-JP-language";
  /// iOS voice name (Samantha is a high-quality English voice)
  static const String iOSVoiceName = "Kyoko";
  /// Platform-specific default voice name
  String defaultVoiceName = (Platform.isIOS || Platform.isMacOS) ? iOSVoiceName: androidVoiceName;

  /// Sets the TTS voice based on platform and available voices
  /// Gets available voices, filters for local female voices (iOS/macOS only),
  /// and selects the best available voice or falls back to default
  Future<void> setTtsVoice() async {
    // Get all available voices on the device
    final voices = await flutterTts.getVoices;
    // Filter for local female voices (iOS/macOS only)
    List<dynamic> localFemaleVoices = (Platform.isIOS || Platform.isMacOS) ? voices.where((voice) {
      final isLocalMatch = voice['locale'].toString().contains(ttsLocale);
      final isFemale = voice['gender'].toString().contains('female');
      return isLocalMatch && isFemale;
    }).toList(): [];
    "localFemaleVoices: $localFemaleVoices".debugPrint();
    
    if (context.mounted) {
      // Check if default voice exists or if no local voices are available
      final isExistDefaultVoice = localFemaleVoices.any((voice) => voice['name'] == defaultVoiceName) || localFemaleVoices.isEmpty;
      // Select voice name and locale
      final voiceName = isExistDefaultVoice ? defaultVoiceName: localFemaleVoices[0]['name'];
      final voiceLocale = isExistDefaultVoice ? ttsLocale: localFemaleVoices[0]['locale'];      
      // Set the voice configuration
      final result = await flutterTts.setVoice({'name': voiceName, 'locale': voiceLocale,});
      "setVoice: $voiceName, setLocale: $voiceLocale, result: $result".debugPrint();
    }
  }

  /// Speaks the provided text using TTS
  /// Stops any current speech before starting new speech to prevent overlap
  /// [text] - The text to be spoken
  Future<void> speakText(String text) async {
    await flutterTts.stop(); // Stop any current speech
    await flutterTts.speak(text); // Start speaking the new text
    text.debugPrint(); // Log the spoken text
  }

  /// Stops the current TTS speech
  /// Useful for interrupting speech when user navigates away or starts new speech
  Future<void> stopTts() async {
    await flutterTts.stop();
    "Stop TTS".debugPrint();
  }

  /// Initializes TTS with platform-specific configurations
  /// Sets up shared instance, iOS audio session, speech completion handling,
  /// language and voice settings, volume and speech rate
  Future<void> initTts() async {
    // Enable shared instance for better performance
    await flutterTts.setSharedInstance(true);
    // iOS-specific audio session configuration
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
        ]
      );
    }
    // Configure speech completion handling
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    // Set language and check availability
    if (context.mounted) await flutterTts.setLanguage("en-US");
    if (context.mounted) await flutterTts.isLanguageAvailable("en-US");
    // Set voice and speech parameters
    if (context.mounted) await setTtsVoice();
    await flutterTts.setVolume(1); // Maximum volume
    await flutterTts.setSpeechRate(0.5); // Moderate speech rate for clarity
  }
} 