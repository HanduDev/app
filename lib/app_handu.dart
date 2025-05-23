import 'package:app/data/repositories/auth/auth_repository_remote.dart';
import 'package:app/data/repositories/language/language_repository_remote.dart';
import 'package:app/data/repositories/lesson/lesson_repository_remote.dart';
import 'package:app/data/services/google_auth.dart';
import 'package:app/data/services/http.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/providers/lesson_provider.dart';
import 'package:app/providers/locale_provider.dart';
import 'package:app/providers/notifier.dart';
import 'package:app/repositories.dart';
import 'package:app/routes/router.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AppHandu extends StatelessWidget {
  const AppHandu({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/i18n'];

    final secureStorage = SecureStorage();
    final localeProvider = LocaleProvider(secureStorage: secureStorage);
    final authProvider = AuthProvider(
      authRepository: AuthRepositoryRemote(
        googleAuth: GoogleAuth(),
        secureStorage: secureStorage,
        httpService: HttpService(secureStorage: secureStorage),
      ),
    );
    final languageProvider = LanguagesProvider(
      languageRepository: LanguageRepositoryRemote(
        httpService: HttpService(secureStorage: secureStorage),
      ),
    );

    Future<Null> initialize() async {
      await localeProvider.initialize();
      await authProvider.init();

      return null;
    }

    return MultiProvider(
      providers:
          [
            Provider<SecureStorageImpl>(create: (context) => secureStorage),
            ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
            ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
            ChangeNotifierProvider<Notifier>(create: (_) => Notifier()),
            Provider<HttpServiceImpl>(
              create:
                  (context) => HttpService(
                    secureStorage: context.read<SecureStorageImpl>(),
                  ),
            ),
            ChangeNotifierProvider<LanguagesProvider>.value(
              value: languageProvider,
            ),
            ChangeNotifierProvider<LessonProvider>.value(
              value: LessonProvider(
                lessonRepository: LessonRepositoryRemote(
                  httpService: HttpService(secureStorage: SecureStorage()),
                ),
              ),
            ),
          ] +
          Repositories.providers(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary400,
          statusBarIconBrightness: Brightness.light,
        ),
        child: FutureBuilder(
          future: initialize(),
          builder: (context, snapshot) {
            final locale = context.select<LocaleProvider, Locale>(
              (value) => value.locale,
            );
            final supportedLocales = context
                .select<LocaleProvider, List<Locale>>(
                  (value) => value.supportedLocales,
                );

            final isLocaleLoading = context.select<LocaleProvider, bool>(
              (value) => value.isLoading,
            );

            final isLoading =
                snapshot.connectionState == ConnectionState.waiting ||
                isLocaleLoading;

            if (isLoading) {
              return MaterialApp(
                title: 'Handu',
                builder: (_, child) {
                  return Scaffold(
                    body: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary400,
                      ),
                    ),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              return MaterialApp(
                builder: (_, child) {
                  return Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}')),
                  );
                },
              );
            }

            return MaterialApp.router(
              key: ValueKey(locale),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                LocalJsonLocalization.delegate,
              ],
              locale: locale,
              supportedLocales: supportedLocales,
              theme: ThemeData(textTheme: Font.primaryTheme()),
              routerConfig: router(),
            );
          },
        ),
      ),
    );
  }
}
