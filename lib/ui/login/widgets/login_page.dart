import 'package:app/ui/core/shared/flat_button.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo_1.png', height: 100),
            SizedBox(height: 24),
            Text(
              'Login',
              style: Font.primary(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary500),
            ),
            SizedBox(height: 48),
            TextInput(
              label: 'Email',
            ),
            SizedBox(height: 56),
            TextInput(
              label: 'Senha',
              obscureText: true,
            ),
            SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text(
                      'Lembrar-Me',
                      style: Font.primary(
                          fontSize: 12, color: AppColors.primary500),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Esqueceu a senha?',
                    style:
                        Font.primary(fontSize: 12, color: AppColors.primary500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 88),
            PrimaryButton(
              text: 'Entrar',
              onPressed: () {},
            ),
            SizedBox(height: 56),
            Text('Ou continue com'),
            SizedBox(height: 24),
            FlatButton(
              loading: authProvider.isGoogleLoading,
              onPressed: onLoginWithGoogle,
              text: 'Entrar com o Google',
              leftIcon: SvgPicture.asset(
                'assets/images/icons/google.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
