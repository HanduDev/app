import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app/ui/core/shared/flat_button.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, result) {
        context.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                const SizedBox(height: 40,),
                Image.asset('assets/images/Logo.png', width: 153, height: 147),// Trocar imagem por uma maior
                const SizedBox(height: 10),
                Text('Cadastro',
                  style: Font.primary (
                    color: AppColors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(height: 40),

                Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 40.00),
                    child:
                    TextInput(
                      label: 'Nome Completo',
                  ),
                  ),
                    const SizedBox(height: 30,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 40.00),
                      child:
                      TextInput(
                        label: 'Email',
                    ),
                    ),
                    const SizedBox(height: 30,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 40.00),
                      child:
                      TextInput(
                        label: 'Senha',
                        obscureText: true,
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(padding: const EdgeInsets.only(left: 40.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Mínimo 8 dígitos',
                          style: Font.primary(
                            fontSize: 12,
                            color: AppColors.primary100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Padding(padding: const EdgeInsets.only(left: 40.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Utilizar letras e números',
                          style: Font.primary(
                            fontSize: 12,
                            color: AppColors.primary100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ],
                ),
                const SizedBox(height: 20,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 40.00),
                      child:
                      TextInput(
                        label: 'Confirmar Senha',
                        obscureText: true,
                    ),
                    ),
                const SizedBox(height: 40,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 40.00),
                      child: PrimaryButton(
                        rounded: true,
                        onPressed: () {
                        context.pushReplacement(
                        Routes.confirmacaoCadastro,
                      );
                    },
                    text: 'Cadastrar conta',
                      ),
                    ),
                const SizedBox(height: 20,),
                    Text('Ou continue com',
                    style: Font.primary(
                      fontSize: 12
                    ),),
                const SizedBox(height: 32),
                    FlatButton(
                      //loading: authProvider.isGoogleLoading,
                      //onPressed: onLoginWithGoogle,
                      leftIcon: SvgPicture.asset(
                      'assets/images/icons/google.svg',
                      height: 30,
                      width: 30,
                    ),
                  ),
                const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já tem uma conta?',
                          style: Font.primary(
                            fontSize: 12,
                        ),
                      ),
                     TextButton(
                      onPressed: (){
                        context.pushReplacement(
                          Routes.login //Trocar para login quando tiver
                        );
                      },
                      child: Text('Entrar',
                        style: Font.primary(
                          fontSize: 12,
                          color: AppColors.primary300
                        ),)
                      )

                   ],
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormsValidator extends StatefulWidget {
  const FormsValidator ({super.key});

  @override
  FormsValidatorState createState() {
    return FormsValidatorState();
  }
}

class FormsValidatorState extends State<FormsValidator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  void _validatedAndSubmit() {
    if (_formKey.currentState!.validate()) {
      context.pushReplacement(Routes.confirmacaoCadastro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextInput(
              controller: _nameController,
              label: 'Nome Completo',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um Nome';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextInput(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um e-mail';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') // Validar .dominio corretamente
                    .hasMatch(value)) {
                  return 'Digite um e-mail válido';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextInput(
              controller: _passwordController,
              label: 'Senha',
              obscureText: true,
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
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mínimo 8 dígitos',
                style: Font.primary(
                  fontSize: 12,
                  color: AppColors.primary100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
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
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextInput(
              controller: _password2Controller,
              label: 'Confirmar Senha',
              obscureText: true,
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
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: PrimaryButton(
              text: ('Cadastrar conta'),
              rounded: true,
              onPressed: _validatedAndSubmit,
            )
          ),
        ],
      ),
    );
  }
}
