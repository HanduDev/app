import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> accountBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.conta,
        builder:
            (context, state) => PrimaryButton(
              text: 'Sair',
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
      ),
    ],
  ),
];
