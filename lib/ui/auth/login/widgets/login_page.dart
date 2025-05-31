import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/flat_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/auth/login/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onLoginWithGoogle() async {
      try {
        final authProvider = context.read<AuthProvider>();

        await authProvider.signInWithGoogle();

        if (context.mounted) {
          context.pushReplacement(Routes.home);
        }
      } catch (e) {
        if (!context.mounted) return;
        Toast.error(context, getErrorMessage(e));
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'account.login.title'.i18n(),
                      style: Font.primary(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary500,
                      ),
                    ),
                    SizedBox(height: 48),
                    FormValidator(),
                    SizedBox(height: 32),
                    Text('account.login.subtitle'.i18n()),
                    SizedBox(height: 24),
                    FlatButton(
                      loading: context.watch<AuthProvider>().isGoogleLoading,
                      onPressed: onLoginWithGoogle,
                      leftIcon: SvgPicture.asset(
                        'assets/images/icons/google.svg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'account.login.no_account'.i18n(),
                          style: Font.primary(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushReplacement(Routes.cadastro);
                          },
                          child: Text(
                            'account.login.register'.i18n(),
                            style: Font.primary(
                              fontSize: 12,
                              color: AppColors.primary300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
