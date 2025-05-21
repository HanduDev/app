import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/ui/login/widgets/login_controller.dart';
import '../../__mocks__/general_mocks.mocks.dart'; 

void main() {
  late MockAuthProvider mockAuthProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
  });

  testWidgets('Deve fazer login com sucesso', (WidgetTester tester) async {
    when(
      mockAuthProvider.signInWithGoogle(),
    ).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    LoginController.loginWithGoogle(context, mockAuthProvider);
                  },
                  child: const Text('Login'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    verify(mockAuthProvider.signInWithGoogle()).called(1);
  });

  testWidgets('Deve exibir Toast de erro se ocorrer uma exceção no login', (
    WidgetTester tester,
  ) async {
    when(
      mockAuthProvider.signInWithGoogle(),
    ).thenThrow(Exception('Erro no Google'));

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    LoginController.loginWithGoogle(context, mockAuthProvider);
                  },
                  child: const Text('Login'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Erro'), findsOneWidget);
  });
}
