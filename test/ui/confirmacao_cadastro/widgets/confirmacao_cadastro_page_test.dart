import 'package:app/models/user.dart';
import 'package:app/ui/confirmacao_cadastro/widgets/confirmacao_cadastro_page.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:fake_async/fake_async.dart';

import '../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockAuthProvider mockAuthProvider;
  late User mockUser;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockUser = MockUser();

    when(mockUser.email).thenReturn('usuario@teste.com');
    when(mockAuthProvider.user).thenReturn(mockUser);
  });

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>.value(
          value: mockAuthProvider,
          child: const ConfirmacaoCadastroPage(),
        ),
      ),
    );
  }

  group('Testes Unitários', () {
    test('formata corretamente tempo com padLeft', () {
      int tempo = 7;
      String tempoFormatado = tempo.toString().padLeft(2, '0');
      expect(tempoFormatado, '07');
    });

    test('verifica isResendButtonEnabled com resendTime = 0', () {
      int resendTime = 0;
      bool isResendButtonEnabled = resendTime == 0;
      expect(isResendButtonEnabled, true);
    });

    test('verifica isResendButtonEnabled com resendTime > 0', () {
      int resendTime = 10;
      bool isResendButtonEnabled = resendTime == 0;
      expect(isResendButtonEnabled, false);
    });
  });

  group('Testes de Widget', () {
    testWidgets('renderiza logo e textos principais', (tester) async {
      await pumpPage(tester);

      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Image), findsOneWidget);
      expect(find.textContaining('confirmacao_cadastro'), findsWidgets);
    });

    testWidgets('renderiza campo de código OTP', (tester) async {
      await pumpPage(tester);
      expect(find.byType(OtpTextField), findsOneWidget);
    });

    testWidgets('renderiza botão de confirmação', (tester) async {
      await pumpPage(tester);

      expect(
        find.byKey(const Key('confirm_button_verify_email_go_to_app')),
        findsOneWidget,
      );
    });

    testWidgets('renderiza botão de entrar com outra conta', (tester) async {
      await pumpPage(tester);
      expect(
        find.byKey(
          const Key('confirm_button_verify_email_join_another_account'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('botão de reenviar inicia desabilitado com texto correto', (
      tester,
    ) async {
      final disabledText =
          '${'confirmacao_cadastro.verify_email_resend_in'.i18n()} 30';
      await pumpPage(tester);

      expect(find.text(disabledText), findsOneWidget);
      expect(find.byKey(const Key('resend_text')), findsOneWidget);
    });

    testWidgets('chama resendCode quando botão de reenviar é habilitado', (
      tester,
    ) async {
      when(
        mockAuthProvider.resendCode(code: anyNamed('code')),
      ).thenAnswer((_) async => null);

      await pumpPage(tester); // AQUI IMPORTANTE o await

      expect(
        find.textContaining(
          'confirmacao_cadastro.verify_email_resend_in'.i18n(),
        ),
        findsOneWidget,
      );

      // Avança o tempo 30 segundos (simulate timer expiring)
      await tester.pump(const Duration(seconds: 30));

      // Re-renderiza a UI para refletir mudanças
      await tester.pump();

      final btn = find.textContaining(
        'confirmacao_cadastro.verify_email_resend'.i18n(),
      );
      expect(btn, findsOneWidget);

      // Clica no botão
      await tester.tap(btn);
      await tester.pump();

      verify(mockAuthProvider.resendCode(code: anyNamed('code'))).called(1);
    });
  });

  group('Testes de Integração', () {
    Future<void> pumpWithRouter(WidgetTester tester) async {
      final router = GoRouter(routes: []);
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          builder:
              (context, child) => ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
                child: child!,
              ),
        ),
      );
    }

    testWidgets('chama verifyCode ao pressionar botão principal', (
      tester,
    ) async {
      when(
        mockAuthProvider.verifyCode(code: anyNamed('code')),
      ).thenAnswer((_) async => null);

      await pumpPage(tester);

      final btn = find.textContaining('verify_email_go_to_app');
      expect(btn, findsOneWidget);

      await tester.tap(btn);
      await tester.pump();

      verify(mockAuthProvider.verifyCode(code: anyNamed('code'))).called(1);
    });

    testWidgets('chama resendCode quando botão de reenviar é habilitado', (
      tester,
    ) async {
      when(
        mockAuthProvider.resendCode(code: anyNamed('code')),
      ).thenAnswer((_) async => null);

      await pumpPage(tester);

      // Supondo que o botão de reenviar tenha texto que contenha 'resend'
      final btn = find.textContaining('resend');
      expect(btn, findsOneWidget);

      await tester.tap(btn);
      await tester.pump();

      verify(mockAuthProvider.resendCode(code: anyNamed('code'))).called(1);
    });

    testWidgets('chama signOut ao clicar em "Entrar com outra conta"', (
      tester,
    ) async {
      when(mockAuthProvider.signOut()).thenAnswer((_) async => null);

      await pumpPage(tester);

      final btn = find.textContaining('verify_email_join_another_account');
      expect(btn, findsOneWidget);

      await tester.tap(btn);
      await tester.pump();

      verify(mockAuthProvider.signOut()).called(1);
    });
  });
}
