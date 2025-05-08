import 'package:app/config/environment.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final url =
    Environment.baseUrl
        .replaceAll('http', 'ws')
        .replaceAll('https', 'ws')
        .split('/api')
        .first;

abstract class WebSocketServiceImpl {
  Stream<dynamic> get stream;

  void disconnect();
}

class WebSocketService extends WebSocketServiceImpl {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('$url/cable'),
  );

  @override
  Stream<dynamic> get stream => _channel.stream;

  @override
  void disconnect() {
    _channel.sink.close();
  }
}
