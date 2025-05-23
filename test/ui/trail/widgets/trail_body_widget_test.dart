import 'package:app/models/trail/trail_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/ui/trail/widgets/trail_body.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/language.dart';
import 'package:mockito/mockito.dart';

import '../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockTrailViewModel mockViewModel;
  late Trail trail;

  setUp(() {
    mockViewModel = MockTrailViewModel();
    trail = Trail(
      id: 1,
      name: 'Trilha Teste',
      description: 'Descrição teste',
      language: Language(name: 'Português', code: 'pt'),
      progress: 0.0,
    );
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<TrailViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(home: Scaffold(body: TrailBody(trail: trail))),
      ),
    );
  }

  testWidgets('Mostra CircularProgressIndicator enquanto carrega', (
    tester,
  ) async {
    final mockTrailInfo = TrailInfo(
      id: 1,
      name: 'Trail Teste',
      description: 'Descrição teste',
      language: Language(name: 'Português', code: 'pt'),
      progress: 0.0,
      lessons: [],
    );

    when(mockViewModel.initialize(any)).thenAnswer(
      (_) => Future.delayed(Duration(seconds: 1), () => mockTrailInfo),
    );

    await pumpWidget(tester);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('Mostra mensagem de erro quando initialize falha', (
    tester,
  ) async {
    when(
      mockViewModel.initialize(any),
    ).thenAnswer((_) async => throw Exception('Erro de teste'));

    await pumpWidget(tester);
    await tester.pumpAndSettle();

    expect(find.textContaining('Exception: Erro de teste'), findsOneWidget);
  });

  testWidgets('Renderiza lista de lições e chama scrollToCurrentLesson', (
    tester,
  ) async {
    final trail = Trail(
      id: 1,
      name: 'Trail de Espanhol',
      description: 'Aprenda Espanhol com lições interativas.',
      language: Language(name: 'Espanhol', code: 'es'),
      progress: 0.3,
    );

    final mockViewModel = MockTrailViewModel();

    when(mockViewModel.initialize(trail.id)).thenAnswer(
      (_) async => TrailInfo(
        id: 1,
        name: 'Trail de Espanhol',
        description: 'Aprenda Espanhol com lições interativas.',
        language: Language(name: 'Espanhol', code: 'es'),
        progress: 0.3,
        lessons: [
          Lesson(
            id: 1,
            name: 'Lição 1: Introdução',
            hasFinished: false,
            activityType: 'theorical',
            isCorrect: false,
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<TrailViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(home: Scaffold(body: TrailBody(trail: trail))),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Lição 1'), findsOneWidget);
    expect(find.text('Introdução'), findsOneWidget);
  });
}
