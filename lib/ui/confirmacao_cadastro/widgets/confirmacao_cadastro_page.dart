import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ConfirmacaoCadastroPage extends StatefulWidget {
  const ConfirmacaoCadastroPage({super.key});

  @override
  State<ConfirmacaoCadastroPage> createState() =>
      _ConfirmacaoCadastroPageState();
}

class _ConfirmacaoCadastroPageState extends State<ConfirmacaoCadastroPage> {
  String code = '';
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    print(code);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Image.asset('assets/images/Logo_1.png', height: 140),
                    SizedBox(height: 24),
                    Text(
                      'Verifique seu Email',
                      style: Font.primary(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Enviamos um código de quatro dígitos para o email',
                      style: Font.primary(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'usuario***@email',
                      style: Font.primary(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Entre com o código abaixo para verificação do email',
                      style: Font.primary(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 52),
                    OtpTextField(
                      numberOfFields: 4,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      keyboardType: TextInputType.text,
                      borderColor: AppColors.lightGrey,
                      focusedBorderColor: AppColors.primary500,
                      showFieldAsBox: true,
                      fieldWidth: 55,
                      textStyle: Font.primary(
                        fontSize: 32, 
                        height: 1.5,
                        color: AppColors.primary500,
                        fontWeight: FontWeight.w300,),
                      onCodeChanged: (String value) {
                       
                      },
                      onSubmit: (String verificationCode) {
                        setState(() {
                          code = verificationCode;
                        });
                      },
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não recebeu o código?',
                          style: Font.primary(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.grey,
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Lógica para reenviar o código
                          },
                          child: Text(
                            'Reenviar',
                            style: Font.primary(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 52),
                    PrimaryButton(
                      text: 'Ir para o aplicativo',
                      rounded: true,
                      onPressed: () async {
                        try {
                          await authProvider.verifyCode(code: code);
                          if (context.mounted) {
                            context.pushReplacement(Routes.home);
                          }
                        } catch (e) {
                          if (!context.mounted) return;
                          Toast.error(context, getErrorMessage(e));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}