import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/cadastro/widgets/form_validator.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app/ui/core/shared/flat_button.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: PopScope(
        onPopInvokedWithResult: (value, result) {
          context.pop();
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  void onLoginWithGoogle() async {
                    try {
                      await authProvider.signInWithGoogle();

                      if (context.mounted) {
                        context.pushReplacement(Routes.home);
                      }
                    } catch (e) {
                      if (!context.mounted) return;
                      Toast.error(context, getErrorMessage(e));
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset('assets/images/Logo_1.png', height: 100),
                        const SizedBox(height: 10),
                        Text(
                          'Cadastro',
                          style: Font.primary(
                            color: AppColors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        FormsValidator(),
                        const SizedBox(height: 24),
                        Text(
                          'Ou continue com',
                          style: Font.primary(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        FlatButton(
                          loading: authProvider.isGoogleLoading,
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
                              'Já tem uma conta?',
                              style: Font.primary(fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushReplacement(Routes.login);
                              },
                              child: Text(
                                'Entrar',
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
