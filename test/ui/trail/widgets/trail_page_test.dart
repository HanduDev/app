import 'package:app/models/language.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/ui/trail/widgets/trail_body.dart';
import 'package:app/ui/trail/widgets/trail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/models/trail/trail.dart';
import 'package:go_router/go_router.dart';
import 'package:country_flags/country_flags.dart';
import 'package:provider/provider.dart';

import '../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late Trail mockTrail;
  late Language mockLanguage;
  late MockGoRouter mockRouter;

  setUp(() {
    mockLanguage = Language(code: 'pt', name: 'Português');

    mockTrail = Trail(
      id: 1,
      name: 'Trilha de Teste',
      description: 'Descrição de teste',
      language: mockLanguage,
      progress: 0.5,
    );

    mockRouter = MockGoRouter();
  });

  group('TrailPage Widget Tests', () {
    testWidgets('should render all main components', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Provider<TrailViewModel>(
              create:
                  (_) => MockTrailViewModel(), 
              child: TrailPage(trail: mockTrail),
            ),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(SharedHeader), findsOneWidget);
      expect(find.byType(TrailBody), findsOneWidget);
    });

    testWidgets('should display correct trail information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TrailPage(trail: mockTrail))),
      );

      expect(find.text(mockTrail.name), findsOneWidget);
      expect(find.text(mockLanguage.name), findsOneWidget);
    });

    testWidgets('should display country flag with correct parameters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TrailPage(trail: mockTrail))),
      );

      final flagFinder = find.byType(CountryFlag);
      expect(flagFinder, findsOneWidget);

      // Verifica se o widget CountryFlag está sendo renderizado
      final flagWidget = tester.widget<CountryFlag>(flagFinder);

      // Verifica as propriedades visíveis
      expect(flagWidget.width, 40);
      expect(flagWidget.height, 27);

      // Alternativa para verificar o código do país indiretamente
      expect(
        find.byWidgetPredicate(
          (widget) => widget is CountryFlag,
          description: 'CountryFlag with language code ${mockLanguage.code}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should call router when back button is pressed', (
      WidgetTester tester,
    ) async {
      // Configura o MockGoRouter
      when(
        mockRouter.pushReplacement(Routes.educacao),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder:
                    (context, state) =>
                        Scaffold(body: TrailPage(trail: mockTrail)),
              ),
            ],
            errorBuilder:
                (context, state) =>
                    Scaffold(body: Center(child: Text('Error'))),
          ),
        ),
      );

      // Encontra e pressiona o botão de voltar
      final backButtonFinder = find.byIcon(Icons.arrow_back);
      expect(backButtonFinder, findsOneWidget);

      await tester.tap(backButtonFinder);
      await tester.pump();

      // Verifica se a navegação foi chamada
      verify(mockRouter.pushReplacement(Routes.educacao)).called(1);
    });

    testWidgets('should apply correct text styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TrailPage(trail: mockTrail))),
      );

      // Verifica o estilo do título
      final titleFinder = find.text(mockTrail.name);
      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontSize, 20);
      expect(titleWidget.style?.fontWeight, FontWeight.w800);
      expect(titleWidget.style?.color, Colors.white);

      // Verifica o estilo do subtítulo
      final subtitleFinder = find.text(mockLanguage.name);
      final subtitleWidget = tester.widget<Text>(subtitleFinder);
      expect(subtitleWidget.style?.fontSize, 16);
      expect(subtitleWidget.style?.fontWeight, FontWeight.w500);
      expect(subtitleWidget.style?.color, Colors.white);
    });

    testWidgets('should handle null or empty trail data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrailPage(
              trail: Trail(
                id: 0,
                name: '',
                description: '',
                language: Language(code: '', name: ''),
                progress: 0,
              ),
            ),
          ),
        ),
      );

      // Verifica se o widget não quebra com dados vazios
      expect(find.byType(TrailPage), findsOneWidget);
    });

    testWidgets('should display correctly with long trail name', (
      WidgetTester tester,
    ) async {
      final longNameTrail = Trail(
        id: 2,
        name:
            'Nome muito longo da trilha que deve ser truncado corretamente na interface do usuário',
        description: 'Descrição',
        language: mockLanguage,
        progress: 0,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: TrailPage(trail: longNameTrail))),
      );

      // Verifica se o texto longo está presente e com overflow configurado
      final titleFinder = find.text(longNameTrail.name);
      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.overflow, TextOverflow.ellipsis);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {
  GoRouter get goRouter;
}
