import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/models/language.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail_info.dart';

import '../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockTrailRepositoryImpl mockTrailRepository;
  late TrailViewModel trailViewModel;

  setUp(() {
    mockTrailRepository = MockTrailRepositoryImpl();
    trailViewModel = TrailViewModel(trailRepository: mockTrailRepository);
  });

  group('TrailViewModel', () {
    final tLesson1 = Lesson(
      id: 1,
      name: 'Lição Teste',
      hasFinished: false,
      activityType: 'theorical',
      isCorrect: false,
    );
    final tTrailInfo = TrailInfo(
      id: 1,
      name: 'Trilha Teste',
      description: 'Uma descrição de teste',
      language: Language(name: 'Português', code: 'pt'),
      progress: 0.0,
      lessons: [tLesson1],
    );

    test(
      'initialize deve chamar getById e retornar o TrailInfo buscado',
      () async {
        when(
          mockTrailRepository.getById(1),
        ).thenAnswer((_) async => tTrailInfo);

        final result = await trailViewModel.initialize(1);

        expect(result, tTrailInfo);
        verify(mockTrailRepository.getById(1)).called(1);
        verifyNoMoreInteractions(mockTrailRepository);
      },
    );

    test('initialize deve propagar o erro quando getById falha', () async {
      final exception = Exception('Erro ao carregar trilha do repositório');
      when(mockTrailRepository.getById(any)).thenThrow(exception);

      expectLater(
        () => trailViewModel.initialize(1),
        throwsA(isA<Exception>()),
      );

      verify(mockTrailRepository.getById(1)).called(1);
      verifyNoMoreInteractions(mockTrailRepository);
    });

    test('o getter trail deve retornar nulo inicialmente', () {
      expect(trailViewModel.trail, isNull);
    });
  });
}
