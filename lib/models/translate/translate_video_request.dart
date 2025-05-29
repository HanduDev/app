import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class TranslateVideoRequest {
  final CameraImage video;

  TranslateVideoRequest({required this.video});

  List<int> getImageBytes() {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in video.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }
}
