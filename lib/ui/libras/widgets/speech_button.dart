import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechButton extends StatefulWidget {
  final void Function(String text) onRecognize;

  const SpeechButton({super.key, required this.onRecognize});

  @override
  State<SpeechButton> createState() => _SpeechButtonState();
}

class _SpeechButtonState extends State<SpeechButton> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  Future<void> _initSpeech(BuildContext context) async {
    try {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          setState(() {});
        },
      );
      setState(() {});
    } catch (e) {
      if (!context.mounted) return;
      Toast.error(context, getErrorMessage(e));
    }
  }

  Future<void> _startListening(BuildContext context) async {
    try {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    } catch (e) {
      if (!context.mounted) return;
      Toast.error(context, getErrorMessage(e));
    }
  }

  Future<void> _stopListening(BuildContext context) async {
    try {
      await _speechToText.stop();
      setState(() {});
    } catch (e) {
      if (!context.mounted) return;
      Toast.error(context, getErrorMessage(e));
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    widget.onRecognize(result.recognizedWords);
  }

  @override
  void initState() {
    super.initState();
    _initSpeech(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isListening = _speechToText.isListening && _speechToText.isAvailable;

    return IconButton(
      onPressed: () async {
        try {
          if (isListening) {
            await _stopListening(context);
            return;
          }

          await _initSpeech(context);

          if (!_speechEnabled || !context.mounted || isListening) return;

          await _startListening(context);
        } catch (e) {
          if (!context.mounted) return;
          Toast.error(context, "Ocorreu um erro ao gravar");
        }
      },
      icon: Icon(isListening ? Icons.mic : Icons.mic_off),
      color: AppColors.white,
    );
  }
}
