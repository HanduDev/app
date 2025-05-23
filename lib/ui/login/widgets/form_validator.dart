import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class FormValidator extends StatefulWidget {
  const FormValidator({super.key});

  @override
  FormValidatorState createState() {
    return FormValidatorState();
  }
}

class FormValidatorState extends State<FormValidator> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePasswordText = true;
  bool _remember = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> validatedAndSubmit() async {
      try {
        if (!_formKey.currentState!.validate()) return;
        final authProvider = context.read<AuthProvider>();

        await authProvider.signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (!context.mounted) return;

        context.pushReplacement(Routes.home);
      } catch (e) {
        Toast.error(context, getErrorMessage(e));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            controller: _emailController,
            label: 'account.register.email'.i18n(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.email_validation_required'.i18n();
              }
              if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ) // Validar .dominio corretamente
              .hasMatch(value)) {
                return 'account.email_validator'.i18n();
              }
              return null;
            },
          ),
          SizedBox(height: 56),

          TextInput(
            controller: _passwordController,
            label: 'account.register.password'.i18n(),
            obscureText: _obscurePasswordText,
            sufixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePasswordText = !_obscurePasswordText;
                });
              },
              icon: Icon(
                _obscurePasswordText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.password_validation_required'.i18n();
              }
              if (value.length < 8) {
                return 'account.password_validation_min_length'.i18n();
              }
              if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                return 'account.password_validation_letters_and_numbers'.i18n();
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    shape: CircleBorder(),
                    value: _remember,
                    onChanged: (value) {
                      setState(() {
                        _remember = value!;
                      });
                    },
                  ),
                  Text(
                    'account.login.remember_me'.i18n(),
                    style: Font.primary(
                      fontSize: 12,
                      color: AppColors.primary500,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'account.login.forgot_password'.i18n(),
                  style: Font.primary(
                    fontSize: 12,
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Hero(
            tag: 'primary-button',
            child: PrimaryButton(
              text: 'common.login'.i18n(),
              rounded: true,
              onPressed: validatedAndSubmit,
              loading: context.watch<AuthProvider>().isAuthenticating,
            ),
          ),
        ],
      ),
    );
  }
}
