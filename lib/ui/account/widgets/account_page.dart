import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SharedHeader(
          title: Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage:
                  user.photoURL != null ? NetworkImage(user.photoURL!) : null,
              backgroundColor: AppColors.primary100,
              child:
                  user.photoURL == null
                      ? Icon(
                        Icons.person, // Ícone padrão
                        size: 30,
                        color: AppColors.white,
                      )
                      : null,
            ),
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Em progresso",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'Sair',
                    danger: true,
                    onPressed: () async {
                      try {
                        final authProvider = context.read<AuthProvider>();
                        await authProvider.signOut();

                        if (!context.mounted) return;

                        context.pushReplacement(Routes.intro);
                      } catch (e) {
                        if (!context.mounted) return;
                        Toast.error(context, 'Erro ao sair');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
