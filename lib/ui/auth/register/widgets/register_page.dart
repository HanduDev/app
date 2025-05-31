import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/auth/register/widgets/form_validator.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app/ui/core/shared/flat_button.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
      child: PopScope(
        onPopInvokedWithResult: (value, result) {
          if (result == null) return;

          context.pop();
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/images/Logo.png',
                      height: 120,
                      width: 120,
                    ),
                    Text(
                      'account.register.title'.i18n(),
                      style: Font.primary(
                        color: AppColors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    FormsValidator(),
                    const SizedBox(height: 24),
                    Text(
                      'account.register.or_continue_with'.i18n(),
                      style: Font.primary(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
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
                          'account.register.already_have_account'.i18n(),
                          style: Font.primary(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushReplacement(Routes.login);
                          },
                          child: Text(
                            'common.login'.i18n(),
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
