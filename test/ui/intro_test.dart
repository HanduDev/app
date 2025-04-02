import 'package:app/ui/intro/widgets/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testa se as rotas dos botões funcionam', () {
    testWidgets('Testa se a rota do botão Entrar funciona', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: IntroPage(),
        routes: {
          '/intro'
        },
      ));
    });
  });
}
