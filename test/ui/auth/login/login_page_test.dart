import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/auth/login/widgets/login_controller.dart';
import '../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockAuthRepositoryImpl mockAuthRepository;
  late AuthProvider authProvider;

  setUp(() {
    mockAuthRepository = MockAuthRepositoryImpl();
    authProvider = AuthProvider(authRepository: mockAuthRepository);
  });

  Future<void> pumpLogin(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      LoginController.loginWithGoogle(context, authProvider);
                    },
                    child: const Text('Login'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('Deve fazer login com sucesso', (WidgetTester tester) async {
    when(
      mockAuthRepository.signInWithGoogle(),
      // ignore: null_argument_to_non_null_type
    ).thenAnswer((_) async => Future.value());

    await pumpLogin(tester);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    verify(mockAuthRepository.signInWithGoogle()).called(1);
  });

  testWidgets('Deve exibir Toast de erro se ocorrer uma exceção no login', (
    WidgetTester tester,
  ) async {
    when(
      mockAuthRepository.signInWithGoogle(),
    ).thenThrow(Exception('Erro no Google'));

    await pumpLogin(tester);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Erro'), findsOneWidget);
  });
}
