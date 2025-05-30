import 'package:app/data/repositories/auth/auth_repository.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

abstract class AuthProviderImpl extends ChangeNotifier {
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> verifyCode({required String code, required String? email});
  Future<void> resendCode({required String code, required String? email});
  Future<void> updateUser({required String name, required String email});
}

class AuthProvider extends ChangeNotifier implements AuthProviderImpl {
  final AuthRepositoryImpl _authRepository;

  AuthProvider({required AuthRepositoryImpl authRepository})
    : _authRepository = authRepository;

  User? _user;
  bool _isGoogleLoading = false;
  bool _isAuthenticating = false;

  bool get isAuthenticated => _user != null;
  User? get user => _user;
  bool get isGoogleLoading => _isGoogleLoading;
  bool get isAuthenticating => _isAuthenticating;

  Future<void> init() async {
    try {
      User? user = await _authRepository.me();

      if (user == null) {
        return;
      }

      _user = user;
      notifyListeners();
    } catch (_) {}
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      _isGoogleLoading = true;
      notifyListeners();

      User user = await _authRepository.signInWithGoogle();

      _user = user;
      notifyListeners();
    } finally {
      _isGoogleLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> signOut() async {
    await _authRepository.signOut();
    _user = null;
    notifyListeners();
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      _isAuthenticating = true;
      notifyListeners();

      User user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      _user = user;
      notifyListeners();
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _isAuthenticating = true;
      notifyListeners();

      User user = await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );

      _user = user;
      notifyListeners();
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  @override
  Future<void> verifyCode({
    required String code,
    required String? email,
  }) async {
    try {
      _isAuthenticating = true;
      notifyListeners();
      _user = await _authRepository.verifyCode(code: code, email: email);

      _isAuthenticating = false;
      notifyListeners();
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  @override
  Future<void> resendCode({
    required String code,
    required String? email,
  }) async {
    try {
      _isAuthenticating = true;
      notifyListeners();

      await _authRepository.resendCode(code: code, email: email);

      _isAuthenticating = false;
      notifyListeners();
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  @override
  Future<void> updateUser({required String name, required String email}) async {
    try {
      _isAuthenticating = true;
      notifyListeners();

      User user = await _authRepository.updateUser(name: name, email: email);

      _user = user;
      notifyListeners();
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }
}
