import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/cadastro/widgets/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../__mocks__/general_mocks.mocks.dart'; 

void main() {
  late MockAuthRepositoryImpl mockAuthRepository;
  late AuthProvider authProvider;

  setUp(() {
    mockAuthRepository = MockAuthRepositoryImpl();
    authProvider = AuthProvider(authRepository: mockAuthRepository);
  });

  Future<void> pumpForm(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: Scaffold(body: FormsValidator()),
        ),
      ),
    );
  }

  group('FormsValidator - Preenchimento individual de campos', () {
    setUp(() {
      when(mockAuthRepository.me()).thenAnswer((_) async => null);
      when(
        mockAuthRepository.signInWithGoogle(),
      ).thenAnswer((_) async => throw UnimplementedError());
    });

    testWidgets('preenche campo nome', (WidgetTester tester) async {
      await pumpForm(tester);

      const nome = 'Everton';
      await tester.enterText(find.byKey(const Key('nameField')), nome);

      expect(find.text(nome), findsOneWidget);
    });

    testWidgets('preenche campo email', (WidgetTester tester) async {
      await pumpForm(tester);

      const email = 'teste@email.com';
      await tester.enterText(find.byKey(const Key('emailField')), email);

      expect(find.text(email), findsOneWidget);
    });

    testWidgets('preenche campo senha', (WidgetTester tester) async {
      await pumpForm(tester);

      const senha = '12345678';
      await tester.enterText(find.byKey(const Key('passwordField')), senha);

      expect(find.text(senha), findsOneWidget);
    });

    testWidgets('preenche campo confirmação de senha', (
      WidgetTester tester,
    ) async {
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
