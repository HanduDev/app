import 'package:app/ui/cadastro/widgets/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routes/routes.dart';

void main() {
  testWidgets('Testa a navegação da tela CadastroPage', (
    WidgetTester tester,
  ) async {
    final GoRouter router = GoRouter(
      initialLocation: '/cadastro',
      routes: [
        GoRoute(path: '/cadastro', builder: (context, state) => const CadastroPage()),
        GoRoute(
          path: Routes.confirmacaoCadastro,
          builder:
              (context, state) => Scaffold(body: Text('Confirmação Cadastro')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    expect(find.text('Cadastro'), findsOneWidget);

    await tester.pumpAndSettle();

    await tester.tap(find.text('Cadastrar conta'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmação Cadastro'), findsOneWidget);
  });
}
