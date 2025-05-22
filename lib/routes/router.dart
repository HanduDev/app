import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/branches/account_branches.dart';
import 'package:app/routes/branches/auth_branches.dart';
import 'package:app/routes/branches/create_trail_branches.dart';
import 'package:app/routes/branches/education_branches.dart';
import 'package:app/routes/branches/libras_branches.dart';
import 'package:app/routes/branches/trail_branches.dart';
import 'package:app/routes/branches/translate_branches.dart';
import 'package:app/ui/account/widgets/account_edit_page.dart';
import 'package:app/ui/confirmacao_cadastro/widgets/confirmacao_cadastro_page.dart';
import 'package:app/ui/core/shared/common_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.intro,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authProvider = context.read<AuthProvider>();

      final isOnIntro = state.matchedLocation == Routes.intro;
      final isAuthenticated = authProvider.isAuthenticated;
      final isEmailConfirmed = authProvider.user?.isEmailConfirmed ?? false;

      if (isAuthenticated && !isEmailConfirmed) {
        return Routes.confirmacaoCadastro;
      }

      if (isAuthenticated && isOnIntro) {
        return Routes.home;
      }

      if (!isAuthenticated && isOnIntro) {
        return Routes.intro;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.confirmacaoCadastro,
        builder: (context, state) => ConfirmacaoCadastroPage(),
      ),
      GoRoute(
        path: Routes.editar,
        builder: (context, state) => AccountEditPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => navigationShell,
        branches: authBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => navigationShell,
        branches: createTrailBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => navigationShell,
        branches: trailBranches,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CommonLayout(navigationShell: navigationShell);
        },
        branches:
            translateBranches +
            librasBranches +
            educationBranches +
            accountBranches,
      ),
    ],
  );
}
