import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranslateTextPage extends StatelessWidget {
  const TranslateTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return GradientBackground(
          child: Text(authProvider.user?.fullName ?? ''),
        );
      },
    );
  }
}
