import 'dart:async';

import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/secondary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:app/helpers/text_formatters.dart';

class ConfirmacaoCadastroPage extends StatefulWidget {
  const ConfirmacaoCadastroPage({super.key});

  @override
  State<ConfirmacaoCadastroPage> createState() =>
      _ConfirmacaoCadastroPageState();
}

class _ConfirmacaoCadastroPageState extends State<ConfirmacaoCadastroPage> {
  String code = '';
  int resendTime = 30;
  Timer? _resendTimer;

  void startResendTimer() {
    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime > 0) {
        setState(() {
          resendTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startResendTimer();
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isResendButtonEnabled = resendTime == 0.0;
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Logo_1.png', height: 100),
                  SizedBox(height: 24),
                  Text(
                    'confirmacao_cadastro.verify_email'.i18n(),
                    style: Font.primary(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'confirmacao_cadastro.verify_email_description'.i18n(),
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        authProvider.user?.email ?? '',
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'confirmacao_cadastro.verify_email_below'.i18n(),
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: 52),
                  OtpTextField(
                    numberOfFields: 4,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    keyboardType: TextInputType.text,
                    borderColor: AppColors.lightGrey,
                    focusedBorderColor: AppColors.primary500,
                    showFieldAsBox: true,
                    inputFormatters: [UpperCaseTextFormatter()],
                    fieldWidth: 55,
                    textStyle: Font.primary(
                      fontSize: 32,
                      height: 1.5,
                      color: AppColors.primary500,
                      fontWeight: FontWeight.w300,
                    ),
                    onCodeChanged: (String value) {},
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
                        'confirmacao_cadastro.verify_email_not_received'.i18n(),
                        style: Font.primary(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap:
                            isResendButtonEnabled
                                ? () async {
                                  try {
                                    await authProvider.resendCode(code: code);
                                    setState(() {
                                      resendTime = 30;
                                    });

                                    startResendTimer();
                                    if (context.mounted) {
                                      Toast.success(
                                        context,
                                        'confirmacao_cadastro.verify_email_resend_code_success'
                                            .i18n(),
                                      );
                                    }
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    Toast.error(context, getErrorMessage(e));
                                  }
                                }
                                : null,
                        child: Text(
                          isResendButtonEnabled
                              ? 'confirmacao_cadastro.verify_email_resend'
                                  .i18n()
                              : '${'confirmacao_cadastro.verify_email_resend_in'.i18n()} ${resendTime.toInt().toString().padLeft(2, '0')}',
                          key: const Key('resend_text'),
                          style: Font.primary(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                isResendButtonEnabled
                                    ? AppColors.primary500
                                    : AppColors.grey.withAlpha(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 52),
                  PrimaryButton(
                    key: const Key('confirm_button_verify_email_go_to_app'),
                    text: 'confirmacao_cadastro.verify_email_go_to_app'.i18n(),
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
                  SizedBox(height: 32),
                  SecondaryButton(
                    key: const Key(
                      'confirm_button_verify_email_join_another_account',
                    ),
                    text:
                        'confirmacao_cadastro.verify_email_join_another_account'
                            .i18n(),
                    rounded: true,
                    onPressed: () async {
                      try {
                        await authProvider.signOut();
                        if (context.mounted) {
                          context.pushReplacement(Routes.intro);
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
        ),
      ),
    );
  }
}
