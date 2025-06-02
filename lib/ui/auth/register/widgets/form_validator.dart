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

class FormsValidator extends StatefulWidget {
  const FormsValidator({super.key});

  @override
  FormsValidatorState createState() {
    return FormsValidatorState();
  }
}

class FormsValidatorState extends State<FormsValidator> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> validatedAndSubmit() async {
      try {
        if (!_formKey.currentState!.validate()) return;
        if (_passwordController.text != _password2Controller.text) {
          Toast.error(context, 'errors.password_not_match'.i18n());
          return;
        }

        final authProvider = context.read<AuthProvider>();

        await authProvider.signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (context.mounted) {
          context.pushReplacement(Routes.confirmacaoCadastro);
        }
      } catch (e) {
        if (!context.mounted) return;
        Toast.error(context, getErrorMessage(e));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            keyField: const Key('nameField'),
            controller: _nameController,
            label: 'account.register.name'.i18n(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.name_validation_required'.i18n();
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          TextInput(
            keyField: const Key('emailField'),
            controller: _emailController,
            label: 'account.register.email'.i18n(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.email_validation_required'.i18n();
              }
              if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return 'account.email_validator'.i18n();
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          TextInput(
            keyField: const Key('passwordField'),
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
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'account.password_validation_letters_and_numbers'.i18n(),
              style: Font.primary(
                fontSize: 12,
                color: AppColors.primary100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          TextInput(
            keyField: const Key('confirmPasswordField'),
            controller: _password2Controller,
            label: 'account.register.confirm_password'.i18n(),
            obscureText: _obscureConfirmPasswordText,
            sufixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPasswordText = !_obscureConfirmPasswordText;
                });
              },
              icon: Icon(
                _obscureConfirmPasswordText
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.password_confirmation_required'.i18n();
              }
              if (value != _passwordController.text) {
                return 'account.password_not_match'.i18n();
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          Hero(
            tag: 'primary-button',
            child: PrimaryButton(
              key: const Key('registerButton'),
              text: 'account.register.register'.i18n(),
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
