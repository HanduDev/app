import 'dart:async';

import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/models/translate/translate_video_request.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class LibrasImageViewModel extends ChangeNotifier {
  final TranslateRepositoryVideoImpl _translateRepository;

  LibrasImageViewModel({
    required TranslateRepositoryVideoImpl translateRepository,
  }) : _translateRepository = translateRepository;

  bool _isRecording = false;
  CameraController? _cameraController;

  bool get isRecording => _isRecording;
  CameraController? get cameraController => _cameraController;

  final int translateTime = 200;
  Timer? _translateTimer;

  final int maxTimeInSeconds = 10;
  int _currentRecordingTime = 0;

  String translatedText = '';

  get progress => _currentRecordingTime / maxTimeInSeconds;

  Future<void> _initTranslateTimer(CameraImage image) async {
    if (_translateTimer?.isActive ?? false) return;

    _translateTimer = Timer(Duration(milliseconds: translateTime), () async {
      _translateTimer?.cancel();

      _currentRecordingTime++;
      notifyListeners();

      if (_currentRecordingTime >= maxTimeInSeconds) {
        _stopRecording();
        _currentRecordingTime = 0;
        notifyListeners();
        return;
      }

      await _translateRepository.createVideo(TranslateVideoRequest(video: image));
    });
  }

  Future<void> _startRecording() async {
    if (_isRecording) {
      return;
    }

    await _cameraController!.startVideoRecording(
      onAvailable: _initTranslateTimer,
    );
    _isRecording = true;
    notifyListeners();
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _cameraController!.stopVideoRecording();
      _isRecording = false;
      notifyListeners();
    }
  }

  Future<void> _setupCameraController() async {
    if (_cameraController?.value.isInitialized ?? false) {
      return;
    }

    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );

      await _cameraController!.initialize();
    }

    notifyListeners();
  }

  Future<void> disposeCamera() async {
    _stopRecording();
    await _cameraController!.dispose();
    _isRecording = false;
  }

  Future<void> toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> initialize() async {
    await _setupCameraController();
  }
}
