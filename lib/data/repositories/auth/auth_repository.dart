import 'package:app/models/user.dart';

abstract class AuthRepositoryImpl {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User> signIn({required String email, required String password});
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<User?> me();
  Future<void>verifyCode({required String code});
}
