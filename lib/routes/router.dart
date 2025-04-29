import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/branches/account_branches.dart';
import 'package:app/routes/branches/auth_branches.dart';
import 'package:app/routes/branches/create_trail_branches.dart';
import 'package:app/routes/branches/education_branches.dart';
import 'package:app/routes/branches/libras_branches.dart';
import 'package:app/routes/branches/trail_branches.dart';
import 'package:app/routes/branches/translate_branches.dart';
import 'package:app/ui/core/shared/common_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

GoRouter router(AuthProvider authProvider) => GoRouter(
  initialLocation: Routes.splashLoading,
  debugLogDiagnostics: true,
  refreshListenable: authProvider,
  redirect: (context, state) {
    if (authProvider.isLoading) return null;

    final isOnIntro = state.matchedLocation == Routes.splashLoading;
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
      path: Routes.splashLoading,
      builder: (context, state) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
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
