import 'dart:convert';
import 'package:app/config/environment.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class HttpServiceImpl {
  Future<T> post<T>(String path, Map<String, dynamic> body);
  Future<T> postMultipart<T>(
    String path,
    Map<String, dynamic> fields,
    Map<String, List<int>> files,
  );
  Future<T> get<T>(String path);
  Future<void> delete(String path);
  Future<T> put<T>(String path, Map<String, dynamic> body);
}

class HttpService extends HttpServiceImpl {
  final String _url = Environment.baseUrl;
  final SecureStorageImpl _secureStorage;

  HttpService({required SecureStorageImpl secureStorage})
    : _secureStorage = secureStorage;

  @override
  Future<T> post<T>(String path, Map<String, dynamic> body) async {
    final httpRequest = await http.post(
      Uri.parse('$_url$path'),
      body: jsonEncode(body),
      headers: await _getJsonHeader(),
    );

    var jsonBody = json.decode(utf8.decode(httpRequest.bodyBytes));

    if (httpRequest.statusCode >= 400) {
      throw Exception(jsonBody);
    }

    return jsonBody as T;
  }

  @override
  Future<T> postMultipart<T>(
    String path,
    Map<String, dynamic> fields,
    Map<String, List<int>> files,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse('$_url$path'));

    // Add fields
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add files
    files.forEach((key, bytes) {
      request.files.add(
        http.MultipartFile.fromBytes(
          key,
          bytes,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    });

    // Add auth header only
    String? token = await _secureStorage.read("token");
    if (token != null) {
      request.headers['Authorization'] = "Bearer $token";
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 400) {
      throw Exception(response.body);
    }

    var jsonBody = json.decode(utf8.decode(response.bodyBytes));
    return jsonBody as T;
  }

  @override
  Future<T> get<T>(String path) async {
    final httpRequest = await http.get(
      Uri.parse('$_url$path'),
      headers: await _getJsonHeader(),
    );

    var jsonBody = json.decode(utf8.decode(httpRequest.bodyBytes));

    if (httpRequest.statusCode >= 400) {
      throw Exception(jsonBody);
    }

    return jsonBody as T;
  }

  @override
  Future<void> delete(String path) async {
    final httpRequest = await http.delete(
      Uri.parse('$_url$path'),
      headers: await _getJsonHeader(),
    );

    if (httpRequest.statusCode >= 200) {
      var jsonBody = json.decode(utf8.decode(httpRequest.bodyBytes));

      throw Exception(jsonBody);
    }
  }

  @override
  Future<T> put<T>(String path, Map<String, dynamic> body) async {
    final httpRequest = await http.put(
      Uri.parse('$_url$path'),
      body: jsonEncode(body),
      headers: await _getJsonHeader(),
    );

    if (httpRequest.bodyBytes.isEmpty) {
      return {} as T;
    }

    var jsonBody = json.decode(utf8.decode(httpRequest.bodyBytes));

    if (httpRequest.statusCode >= 400) {
      throw Exception(jsonBody);
    }

    return jsonBody as T;
  }

  Future<Map<String, String>> _getJsonHeader() async {
    String? token = await _secureStorage.read("token");

    if (token == null) {
      return {'Content-Type': 'application/json; charset=utf-8'};
    }

    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': "Bearer $token",
    };
  }
}
