import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechButtonViewModel extends ChangeNotifier {
  final void Function(String text) onRecognize;
  SpeechButtonViewModel({required this.onRecognize});

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  bool get speechEnabled => _speechEnabled;
  String get lastWords => _lastWords;
  SpeechToText get speechToText => _speechToText;

  Future<void> initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners();
  }

  Future<void> startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    notifyListeners();
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    notifyListeners();
    onRecognize(result.recognizedWords);
  }
}
