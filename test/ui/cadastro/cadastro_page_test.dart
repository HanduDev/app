import 'package:app/ui/core/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes de e-mail da tela de cadastro', () {
    late GlobalKey<FormState> formKey;
    late TextEditingController emailController;

    setUp(() {
      formKey = GlobalKey<FormState>();
      emailController = TextEditingController();
    });

    Future<void> buildForm(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInput(
                    controller: emailController,
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
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('Mostra erro quando o campo está vazio', (tester) async {
      await buildForm(tester);
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Digite um e-mail'), findsOneWidget);
    });

    testWidgets('Mostra erro quando o e-mail é inválido', (tester) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput), 'emailinvalido');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Digite um e-mail válido'), findsOneWidget);
    });

    testWidgets('Não mostra erros quando o e-mail é válido', (tester) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput), 'teste@email.com');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Digite um e-mail válido'), findsNothing);
      expect(find.text('Digite um e-mail'), findsNothing);
    });
  }); //group

  group('Testes de senha da tela de cadastro', () {
    late GlobalKey<FormState> formKey;
    late TextEditingController passwordController;

    setUp(() {
      formKey = GlobalKey<FormState>();
      passwordController = TextEditingController();
    });

    Future<void> buildForm(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInput(
                    controller: passwordController,
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
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('Mostra erro quando o campo está vazio', (tester) async {
      await buildForm(tester);
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Digite uma senha'), findsOneWidget);
    });

    testWidgets('Mostra erro quando a senha tem menos de 8 caracteres', (
      tester,
    ) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput), '123a');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(
        find.text('A senha deve ter pelo menos 8 caracteres'),
        findsOneWidget,
      );
    });

    testWidgets('Mostra erro quando a senha não tem letras e números', (
      tester,
    ) async {
      await buildForm(tester);
      await tester.enterText(
        find.byType(TextInput),
        'abcdefgh',
      ); // apenas letras
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('A senha deve conter letras e números'), findsOneWidget);

      await tester.enterText(
        find.byType(TextInput),
        '12345678',
      ); // apenas números
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('A senha deve conter letras e números'), findsOneWidget);
    });

    testWidgets('Não mostra erro quando a senha é válida', (tester) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput), 'abc12345');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Digite uma senha'), findsNothing);
      expect(
        find.text('A senha deve ter pelo menos 8 caracteres'),
        findsNothing,
      );
      expect(find.text('A senha deve conter letras e números'), findsNothing);
    });
  }); //group
  group('Testes de confirmação de senha da tela de cadastro', () {
    late GlobalKey<FormState> formKey;
    late TextEditingController passwordController;
    late TextEditingController confirmPasswordController;

    setUp(() {
      formKey = GlobalKey<FormState>();
      passwordController = TextEditingController();
      confirmPasswordController = TextEditingController();
    });

    Future<void> buildForm(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInput(controller: passwordController, label: 'Senha'),
                  TextInput(
                    controller: confirmPasswordController,
                    label: 'Confirmar Senha',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme sua senha';
                      }
                      if (value != passwordController.text) {
                        return 'As senhas não são iguais';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('Mostra erro quando o campo está vazio', (tester) async {
      await buildForm(tester);
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Confirme sua senha'), findsOneWidget);
    });

    testWidgets('Mostra erro quando as senhas não são iguais', (tester) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput).at(0), 'senha123');
      await tester.enterText(find.byType(TextInput).at(1), 'outraSenha');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('As senhas não são iguais'), findsOneWidget);
    });

    testWidgets('Não mostra erro quando as senhas são iguais', (tester) async {
      await buildForm(tester);
      await tester.enterText(find.byType(TextInput).at(0), 'senha123');
      await tester.enterText(find.byType(TextInput).at(1), 'senha123');
      await tester.tap(find.text('Enviar'));
      await tester.pump();
      expect(find.text('Confirme sua senha'), findsNothing);
      expect(find.text('As senhas não são iguais'), findsNothing);
    });
  }); //group

  group('Testes do botão Cadastrar conta', () {
    late GlobalKey<FormState> formKey;
    late TextEditingController nameController;
    late TextEditingController emailController;
    late TextEditingController passwordController;
    late TextEditingController confirmPasswordController;

    setUp(() {
      formKey = GlobalKey<FormState>();
      nameController = TextEditingController();
      emailController = TextEditingController();
      passwordController = TextEditingController();
      confirmPasswordController = TextEditingController();
    });

    Future<void> buildForm(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInput(
                    controller: nameController,
                    label: 'Nome Completo',
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Digite um Nome'
                                : null,
                  ),
                  TextInput(
                    controller: emailController,
                    label: 'Email',
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Digite um e-mail'
                                : null,
                  ),
                  TextInput(
                    controller: passwordController,
                    label: 'Senha',
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Digite uma senha'
                                : null,
                  ),
                  TextInput(
                    controller: confirmPasswordController,
                    label: 'Confirmar Senha',
                    validator:
                        (value) =>
                            value != passwordController.text
                                ? 'As senhas não são iguais'
                                : null,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: const Text('Cadastrar conta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('Mostra todos os erros quando campos estão vazios', (
      tester,
    ) async {
      await buildForm(tester);
      await tester.tap(find.text('Cadastrar conta'));
      await tester.pump();

      expect(find.text('Digite um Nome'), findsOneWidget);
      expect(find.text('Digite um e-mail'), findsOneWidget);
      expect(find.text('Digite uma senha'), findsOneWidget);
    });

    testWidgets(
      'Mostra erro de senhas diferentes mesmo com campos preenchidos',
      (tester) async {
        await buildForm(tester);

        await tester.enterText(find.byType(TextInput).at(0), 'Everton');
        await tester.enterText(
          find.byType(TextInput).at(1),
          'everton@email.com',
        );
        await tester.enterText(find.byType(TextInput).at(2), 'senha123');
        await tester.enterText(find.byType(TextInput).at(3), 'outraSenha');

        await tester.tap(find.text('Cadastrar conta'));
        await tester.pump();

        expect(find.text('As senhas não são iguais'), findsOneWidget);
      },
    );

    testWidgets('Não mostra erros quando todos os campos estão corretos', (
      tester,
    ) async {
      await buildForm(tester);

      await tester.enterText(find.byType(TextInput).at(0), 'Everton');
      await tester.enterText(find.byType(TextInput).at(1), 'everton@email.com');
      await tester.enterText(find.byType(TextInput).at(2), 'senha123');
      await tester.enterText(find.byType(TextInput).at(3), 'senha123');

      await tester.tap(find.text('Cadastrar conta'));
      await tester.pump();

      expect(find.textContaining('Digite'), findsNothing);
      expect(find.text('As senhas não são iguais'), findsNothing);
    });
  });
}
