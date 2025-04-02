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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          Future<void> validatedAndSubmit() async {
            try {
              if (!_formKey.currentState!.validate()) return;

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInput(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um e-mail';
                  }
                  if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ) // Validar .dominio corretamente
                  .hasMatch(value)) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 56),

              TextInput(
                controller: _passwordController,
                label: 'Senha',
                obscureText: _obscurePasswordText,
                sufixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePasswordText = !_obscurePasswordText;
                    });
                  },
                  icon: Icon(
                    _obscurePasswordText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite uma senha';
                  }
                  if (value.length < 8) {
                    return 'A senha deve ter pelo menos 8 caracteres';
                  }
                  if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                    return 'A senha deve conter letras e números';
                  }
                  return null;
                },
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
                          fontSize: 12,
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueceu a senha?',
                      style: Font.primary(
                        fontSize: 12,
                        color: AppColors.primary500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 88),
              Hero(
                tag: 'primary-button',
                child: PrimaryButton(
                  text: 'Entrar',
                  rounded: true,
                  onPressed: validatedAndSubmit,
                  loading: authProvider.isAuthenticating,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
