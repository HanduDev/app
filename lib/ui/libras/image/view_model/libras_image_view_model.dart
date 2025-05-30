import 'dart:async';
import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/models/translate/translate_image_request.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class LibrasImageViewModel extends ChangeNotifier {
  final TranslateRepositoryImageImpl _translateRepository;

  LibrasImageViewModel({
    required TranslateRepositoryImageImpl translateRepository,
  }) : _translateRepository = translateRepository;

  bool _isRecording = false;
  CameraController? _cameraController;

  bool get isRecording => _isRecording;
  CameraController? get cameraController => _cameraController;

  final int translateTime = 100;

  final int maxTimeInSeconds = 60;
  double _currentRecordingTime = 0;

  String translatedText = '';

  get progress => _currentRecordingTime / maxTimeInSeconds;

  bool _isTakingPicture = false;

  Future<void> _initTranslateTimer(CameraImage image) async {
    await Future.delayed(Duration(milliseconds: 100));

    _currentRecordingTime += 0.1;
    notifyListeners();

    if (_currentRecordingTime >= maxTimeInSeconds) {
      _stopRecording();
      _currentRecordingTime = 0;
      notifyListeners();
      return;
    }

    if (_isTakingPicture) return;

    _isTakingPicture = true;
    notifyListeners();

    final XFile frame = await cameraController!.takePicture();
    final translation = await _translateRepository.createImage(
      TranslateImageRequest(
        fromLanguage: 'libras',
        toLanguage: 'pt',
        image: frame,
      ),
    );

    _isTakingPicture = false;

    translatedText = translation.message;
    notifyListeners();
  }

  Future<void> _startRecording() async {
    if (_isRecording) {
      return;
    }

    await _cameraController!.startImageStream(_initTranslateTimer);
    _isRecording = true;
    notifyListeners();
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _cameraController!.stopImageStream();
      _isRecording = false;
      _currentRecordingTime = 0;
      notifyListeners();
    }
  }

  Future<void> _setupCameraController() async {
    if (_cameraController?.value.isInitialized ?? false) {
      return;
    }

    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
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
