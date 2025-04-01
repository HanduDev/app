import 'package:app/data/repositories/auth/auth_repository.dart';
import 'package:app/data/services/google_auth.dart';
import 'package:app/data/services/http.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:app/models/user.dart';

class AuthRepositoryRemote extends AuthRepositoryImpl {
  final GoogleAuthImpl _googleAuth;
  final HttpServiceImpl _httpService;
  final SecureStorageImpl _secureStorage;

  AuthRepositoryRemote({
    required GoogleAuthImpl googleAuth,
    required HttpServiceImpl httpService,
    required SecureStorageImpl secureStorage,
  }) : _googleAuth = googleAuth,
       _httpService = httpService,
       _secureStorage = secureStorage;

  @override
  Future<User> signInWithGoogle() async {
    var signedUser = await _googleAuth.signIn();

    if (signedUser == null) {
      throw Exception('Google sign in failed');
    }

    var authentication = await signedUser.authentication;

    var response = await _httpService.post('/authentication/google', {
      'user': {'token': authentication.idToken},
    });

    User user = User.fromJson(response);

    String token = response['token'];

    await _secureStorage.write('token', token);

    return user;
  }

  @override
  Future<void> signOut() async {
    await _googleAuth.signOut();
    await _secureStorage.delete('token');
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    var response = await _httpService.post("/authentication/login", {
      'user': {'email': email, 'password': password},
    });

    User user = User.fromJson(response);
    String token = response['token'];

    await _secureStorage.write('token', token);
    return user;
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    var response = await _httpService.post("/authentication/register", {
      'user': {'full_name': name, 'email': email, 'password': password},
    });

    User user = User.fromJson(response);
    String token = response['token'];

    await _secureStorage.write('token', token);
    return user;
  }

  @override
  Future<User?> me() async {
    try {
      String? storage = await _secureStorage.read('token');

      if (storage == null) {
        return null;
      }

      var response = await _httpService.get("/users/me");

      User user = User.fromJson(response);

      return user;
    } catch (_) {
      await _secureStorage.delete('token');
      rethrow;
    }
  }
  
  @override
  Future<void> verifyCode({required String code}) async {
    print(code);
    await _httpService.post("/users/confirm_email", {
      'user': {'code': code},
    });
  }
}
