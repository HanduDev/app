import 'package:app/models/user.dart';

abstract class AuthRepositoryImpl {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User> signUp({
    required String email,
    required String name,
    required String password,
  });
}
