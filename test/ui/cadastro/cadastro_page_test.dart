import 'package:app/ui/core/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes da tela de login/cadastro', () {
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
  });
}
