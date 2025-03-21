import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/destination.dart';
import 'package:app/ui/cadastro/widgets/cadastro_page.dart';
import 'package:app/ui/confirmacao_cadastro/widgets/confirmacao_cadastro_page.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/intro/view_model/intro_view_model.dart';
import 'package:app/ui/intro/widgets/intro_page.dart';
import 'package:app/ui/libras/view_model/libras_view_model.dart';
import 'package:app/ui/libras/widgets/libras_page.dart';
import 'package:app/ui/traducao_texto/widgets/translate_text_page.dart';
import 'package:app/ui/login/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

GoRouter router(AuthProvider authProvider) => GoRouter(
  initialLocation: Routes.login,
  debugLogDiagnostics: true,
  refreshListenable: authProvider,
  redirect: (context, state) {
    final isLoggingIn = state.matchedLocation == Routes.intro;

    if (authProvider.isAuthenticated && isLoggingIn) {
      return Routes.home;
    }

    if (authProvider.isLoading && !isLoggingIn) {
      return Routes.intro;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: Routes.intro,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) => IntroViewModel(),
          child: IntroPage(),
        );
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: Routes.cadastro,
      builder: (context, state) {
        return CadastroPage();
      },
    ),
    GoRoute(
      path: Routes.confirmacaoCadastro,
      builder: (context, state) {
        return ConfirmacaoCadastroPage();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        const destinations = [
          Destination(label: 'Tradução', icon: Icons.translate),
          Destination(label: 'Libras', icon: Icons.sign_language_outlined),
          Destination(label: 'Educação', icon: Icons.school),
          Destination(label: 'Conta', icon: Icons.person_outline),
        ];

        return Scaffold(
          body: SafeArea(child: navigationShell),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateTextStyle.resolveWith((
                Set<WidgetState> states,
              ) {
                final bool isSelected = states.contains(WidgetState.selected);

                final Color color =
                    isSelected ? AppColors.white : AppColors.disabledIcon;

                final FontWeight fontWeight =
                    isSelected ? FontWeight.w700 : FontWeight.w400;

                return Font.primary(
                  color: color,
                  fontWeight: fontWeight,
                  fontSize: 12,
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
              backgroundColor: AppColors.primary400,
              indicatorColor: AppColors.primary400,
              destinations:
                  destinations
                      .map(
                        (destination) => NavigationDestination(
                          icon: Icon(
                            destination.icon,
                            color: AppColors.disabledIcon,
                            size: 30,
                          ),
                          label: destination.label,
                          selectedIcon: Icon(
                            destination.icon,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => TranslateTextPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.libras,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LibrasViewModel(),
                    child: LibrasPage(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.educacao,
              builder: (context, state) => Text('Educação'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.conta,
              builder:
                  (context, state) => PrimaryButton(
                    text: 'Sair',
                    onPressed: () async {
                      try {
                        await authProvider.signOut();
                        if (!context.mounted) return;

                        context.pushReplacement(Routes.login);
                      } catch (e) {
                        if (!context.mounted) return;
                        Toast.error(context, 'Erro ao sair');
                      }
                    },
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
