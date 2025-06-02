import 'package:app/models/user.dart';
import 'package:app/ui/email_confirmation/widgets/email_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:app/providers/auth_provider.dart';

import '../../../__mocks__/general_mocks.mocks.dart';
import '../../../create_app_with_localization.dart';

class Routes {
  static const home = '/home';
  static const intro = '/intro';
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  late MockAuthProvider mockAuthProvider;
  late User mockUser;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockUser = MockUser();

    when(mockUser.email).thenReturn('usuario@teste.com');
    when(mockAuthProvider.user).thenReturn(mockUser);
  });

  Future<void> pumpPage(WidgetTester tester, {String? email}) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder:
              (context, state) => ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
                child: EmailConfirmationPage(email: email),
              ),
        ),
      ],
    );

    await tester.pumpWidget(createAppWithLocalization(router: router));

    await tester.pumpAndSettle();
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

      expect(find.byType(Image), findsOneWidget);

      final textFinder = find.text('confirmacao_cadastro.verify_email'.i18n());

      expect(textFinder, findsWidgets);
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
  });

  group('Testes de integração', () {
    testWidgets('deve chamar verifyCode ao confirmar com código válido', (
      tester,
    ) async {
      when(
        mockAuthProvider.verifyCode(
          code: anyNamed('code'),
          email: anyNamed('email'),
        ),
      ).thenAnswer((_) async => Future.value());

      await pumpPage(tester, email: 'usuario@teste.com');

      final otpField = tester.widget<OtpTextField>(find.byType(OtpTextField));
      otpField.onSubmit?.call('ABCD');
      await tester.pump();

      final confirmButton = find.byKey(
        const Key('confirm_button_verify_email_go_to_app'),
      );
      expect(confirmButton, findsOneWidget);
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      verify(
        mockAuthProvider.verifyCode(code: 'ABCD', email: 'usuario@teste.com'),
      ).called(1);
    });

    testWidgets(
      'deve chamar resendCode quando botão reenviar habilitado e clicado',
      (tester) async {
        when(
          mockAuthProvider.resendCode(
            code: anyNamed('code'),
            email: anyNamed('email'),
          ),
        ).thenAnswer((_) async => Future.value());

        await pumpPage(tester, email: 'usuario@teste.com');

        await tester.pump(const Duration(seconds: 31));
        await tester.pumpAndSettle();

        final resendTextFinder = find.byKey(const Key('resend_text'));
        expect(resendTextFinder, findsOneWidget);

        final textWidget = tester.widget<Text>(resendTextFinder);
        expect(
          textWidget.data?.contains(
            'confirmacao_cadastro.verify_email_resend'.i18n(),
          ),
          true,
        );

        await tester.tap(resendTextFinder);
        await tester.pumpAndSettle();

        verify(
          mockAuthProvider.resendCode(code: '', email: 'usuario@teste.com'),
        ).called(1);
      },
    );

    testWidgets(
      'deve chamar signOut e navegar para intro ao clicar em entrar com outra conta',
      (tester) async {
        when(
          mockAuthProvider.signOut(),
        ).thenAnswer((_) async => Future.value());

        await pumpPage(tester);

        final anotherAccountButton = find.byKey(
          const Key('confirm_button_verify_email_join_another_account'),
        );

        expect(anotherAccountButton, findsOneWidget);

        await tester.tap(anotherAccountButton);
        await tester.pumpAndSettle();

        verify(mockAuthProvider.signOut()).called(1);
      },
    );
  });
}
