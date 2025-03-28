import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmacaoCadastroPage extends StatefulWidget {
  const ConfirmacaoCadastroPage({super.key});

  @override
  State<ConfirmacaoCadastroPage> createState() =>
      _ConfirmacaoCadastroPageState();
}

class _ConfirmacaoCadastroPageState extends State<ConfirmacaoCadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/Logo_1.png', height: 100),
                      SizedBox(height: 24),
                      Text(
                        'Verifique seu Email',
                        style: Font.primary(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary500,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Enviamos um código de seis dígitos para o email',
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'usuario***@email',
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'Entre com o código abaixo para verificação do email',
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(height: 24),
                      PrimaryButton(
                        text: 'Ir para o aplicativo',
                        rounded: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
