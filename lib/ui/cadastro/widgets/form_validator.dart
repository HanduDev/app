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
    return Form(
      key: _formKey,
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          Future<void> validatedAndSubmit() async {
            try {
              if (!_formKey.currentState!.validate()) return;
              if (_passwordController.text != _password2Controller.text) {
                Toast.error(context, 'As senhas não são iguais');
                return;
              }

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInput(
                controller: _nameController,
                label: 'Nome Completo',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um Nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

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
                  ).hasMatch(value)) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Utilizar letras e números',
                  style: Font.primary(
                    fontSize: 12,
                    color: AppColors.primary100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextInput(
                controller: _password2Controller,
                label: 'Confirmar Senha',
                obscureText: _obscureConfirmPasswordText,
                sufixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPasswordText =
                          !_obscureConfirmPasswordText;
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
                    return 'Confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não são iguais';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              Hero(
                tag: 'primary-button',
                child: PrimaryButton(
                  text: ('Cadastrar conta'),
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
