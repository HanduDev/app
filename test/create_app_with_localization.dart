import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Widget createAppWithLocalization({
  Widget? child,
  RouterConfig<Object>? router,
}) {
  bool hasDelegated = LocalJsonLocalization.delegate.directories.isNotEmpty;

  if (!hasDelegated) {
    LocalJsonLocalization.delegate.directories = ['assets/i18n'];
  }

  if (router != null) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router,
    );
  }

  return MaterialApp(scaffoldMessengerKey: scaffoldMessengerKey, home: child);
}
