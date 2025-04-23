import 'package:app/data/repositories/auth/auth_repository_remote.dart';
import 'package:app/data/repositories/language/language_repository_remote.dart';
import 'package:app/data/services/google_auth.dart';
import 'package:app/data/services/http.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/providers/notifier.dart';
import 'package:app/repositories.dart';
import 'package:app/routes/router.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppHandu extends StatefulWidget {
  const AppHandu({super.key});

  @override
  State<AppHandu> createState() => _AppHanduState();
}

class _AppHanduState extends State<AppHandu> {
  late final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:
          [
            ChangeNotifierProvider<AuthProvider>.value(value: authProvider),

            ChangeNotifierProvider<Notifier>(create: (_) => Notifier()),
            Provider<SecureStorageImpl>(create: (context) => SecureStorage()),
            Provider<HttpServiceImpl>(
              create:
                  (context) => HttpService(
                    secureStorage: context.read<SecureStorageImpl>(),
                  ),
            ),
            ChangeNotifierProvider<LanguagesProvider>.value(
              value: LanguagesProvider(languageRepository: LanguageRepositoryRemote(
                httpService: HttpService(
                    secureStorage: SecureStorage(),
                  ),
              )),
            ),
          ] +
          Repositories.providers(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary400,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp.router(
          theme: ThemeData(textTheme: Font.primaryTheme()),
          routerConfig: router(authProvider),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SecureStorageImpl secureStorage = SecureStorage();

    authProvider = AuthProvider(
      authRepository: AuthRepositoryRemote(
        googleAuth: GoogleAuth(),
        secureStorage: secureStorage,
        httpService: HttpService(secureStorage: secureStorage),
      ),
    );

    Future.microtask(() => authProvider.init());
  }
}
