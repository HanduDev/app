import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

Widget createAppWithLocalization(Widget child) {
  return MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      LocalJsonLocalization.delegate,
    ],
    supportedLocales: const [
      Locale('pt', 'BR'),
      Locale('en', 'US'),
      Locale('es', 'ES'),
    ],
    locale: const Locale('pt', 'BR'),
    home: child,
  );
}
