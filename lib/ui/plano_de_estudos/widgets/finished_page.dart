import 'package:app/models/trail/trail.dart';
import 'package:app/models/user.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/plano_de_estudos/widgets/create_step_animations/finished.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishedPage extends StatelessWidget {
  final Trail? trail;
  final String errorMessage;

  const FinishedPage({
    super.key,
    required this.trail,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthProvider, User?>((value) => value.user);

    if (user == null) {
      return const Center(child: Text('Nenhum usuário encontrado'));
    }

    return Scaffold(
      backgroundColor: AppColors.primary300,
      body: SafeArea(
        child: Center(
          child: Finished(errorMessage: errorMessage, trail: trail),
        ),
      ),
    );
  }
}
