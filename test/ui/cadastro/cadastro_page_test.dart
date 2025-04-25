import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/cadastro/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'cadastro_page_test.mocks.dart';
@GenerateMocks([AuthProvider])
void main() {
  late MockAuthProvider mockAuthProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
  });

  Future<void> pumpForm(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>.value(
          value: mockAuthProvider,
          child: Scaffold(body: FormsValidator()),
        ),
      ),
    );
  }

  group('FormsValidator - Preenchimento individual de campos', () {
    testWidgets('preenche campo nome', (WidgetTester tester) async {
      when(mockAuthProvider.isAuthenticating).thenReturn(false);
      await pumpForm(tester);

      const nome = 'Everton';
      await tester.enterText(find.byKey(const Key('nameField')), nome);

      expect(find.text(nome), findsOneWidget);
    });

    testWidgets('preenche campo email', (WidgetTester tester) async {
      when(mockAuthProvider.isAuthenticating).thenReturn(false);
      await pumpForm(tester);

      const email = 'teste@email.com';
      await tester.enterText(find.byKey(const Key('emailField')), email);

      expect(find.text(email), findsOneWidget);
    });

    testWidgets('preenche campo senha', (WidgetTester tester) async {
      when(mockAuthProvider.isAuthenticating).thenReturn(false);
      await pumpForm(tester);

      const senha = '12345678';
      await tester.enterText(find.byKey(const Key('passwordField')), senha);

      expect(find.text(senha), findsOneWidget);
    });

    testWidgets('preenche campo confirmação de senha', (
      WidgetTester tester,
    ) async {
      when(mockAuthProvider.isAuthenticating).thenReturn(false);
      await pumpForm(tester);

      const confirmacao = '12345678';
      await tester.enterText(
        find.byKey(const Key('confirmPasswordField')),
        confirmacao,
      );

      expect(find.text(confirmacao), findsOneWidget);
    });
  });
}
