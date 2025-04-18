import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginController {
  static Future<void> loginWithGoogle(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    try {
      await authProvider.signInWithGoogle();

      if (context.mounted) {
        context.pushReplacement('/home');
      }
    } catch (e) {
      if (!context.mounted) return;
      Toast.error(context, getErrorMessage(e));
    }
  }
}
