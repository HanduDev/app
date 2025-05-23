import 'package:app/models/language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/ui/trail/widgets/trail_body.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail.dart';
import 'package:flutter/material.dart';

void main() {
  late TrailBody trailBody;

  setUp(() {
    trailBody = TrailBody(
      trail: Trail(
        id: 1,
        name: 'Trilha Teste',
        description: '',
        progress: 0.0,
        language: Language(name: 'Português', code: 'pt'),
      ),
    );
  });

  group('Função isCurrentLesson', () {
    test(
      'Retorna verdadeiro para a primeira lição não concluída no índice 0',
      () {
        final lessons = [
          Lesson(
            id: 1,
            name: 'Lição 1',
            hasFinished: false,
            activityType: 'text',
            isCorrect: false,
          ),
          Lesson(
            id: 2,
            name: 'Lição 2',
            hasFinished: false,
            activityType: 'text',
            isCorrect: false,
          ),
        ];

        expect(trailBody.isCurrentLesson(0, lessons), true);
        expect(trailBody.isCurrentLesson(1, lessons), false);
      },
    );

    test(
      'Retorna verdadeiro para a primeira lição não concluída logo após uma concluída',
      () {
        final lessons = [
          Lesson(
            id: 1,
            name: 'Lição 1',
            hasFinished: true,
            activityType: 'text',
            isCorrect: false,
          ),
          Lesson(
            id: 2,
            name: 'Lição 2',
            hasFinished: false,
            activityType: 'text',
            isCorrect: false,
          ),
        ];

        expect(trailBody.isCurrentLesson(1, lessons), true);
        expect(trailBody.isCurrentLesson(0, lessons), false);
      },
    );

    test('Retorna falso se não for a primeira lição não concluída', () {
      final lessons = [
        Lesson(
          id: 1,
          name: 'Lição 1',
          hasFinished: true,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 2,
          name: 'Lição 2',
          hasFinished: true,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 3,
          name: 'Lição 3',
          hasFinished: false,
          activityType: 'text',
          isCorrect: false,
        ),
      ];

      expect(trailBody.isCurrentLesson(2, lessons), true);
      expect(trailBody.isCurrentLesson(1, lessons), false);
    });
  });

  group('Função getCurrentLessonIndex', () {
    test('Retorna o índice da primeira lição não concluída', () {
      final lessons = [
        Lesson(
          id: 1,
          name: 'Lição 1',
          hasFinished: true,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 2,
          name: 'Lição 2',
          hasFinished: false,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 3,
          name: 'Lição 3',
          hasFinished: false,
          activityType: 'text',
          isCorrect: false,
        ),
      ];

      expect(trailBody.getCurrentLessonIndex(lessons), 1);
    });

    test('Retorna 0 se todas as lições estiverem concluídas', () {
      final lessons = [
        Lesson(
          id: 1,
          name: 'Lição 1',
          hasFinished: true,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 2,
          name: 'Lição 2',
          hasFinished: true,
          activityType: 'text',
          isCorrect: false,
        ),
      ];

      expect(trailBody.getCurrentLessonIndex(lessons), 0);
    });

    test('Retorna 0 se a primeira lição não estiver concluída', () {
      final lessons = [
        Lesson(
          id: 1,
          name: 'Lição 1',
          hasFinished: false,
          activityType: 'text',
          isCorrect: false,
        ),
        Lesson(
          id: 2,
          name: 'Lição 2',
          hasFinished: false,
          activityType: 'text',
          isCorrect: false,
        ),
      ];

      expect(trailBody.getCurrentLessonIndex(lessons), 0);
    });
  });

  group('Função lessonIcon', () {
    test('Retorna ícone de texto para activityType "text"', () {
      final lesson = Lesson(
        id: 1,
        name: 'Lição 1',
        hasFinished: false,
        activityType: 'text',
        isCorrect: false,
      );
      expect(trailBody.lessonIcon(lesson), Icons.text_snippet_outlined);
    });

    test(
      'Retorna ícone de múltipla escolha para activityType "multiple_choice"',
      () {
        final lesson = Lesson(
          id: 1,
          name: 'Lição 1',
          hasFinished: false,
          activityType: 'multiple_choice',
          isCorrect: false,
        );
        expect(trailBody.lessonIcon(lesson), Icons.check_circle_outline);
      },
    );

    test('Retorna ícone de tradução para activityType "translation"', () {
      final lesson = Lesson(
        id: 1,
        name: 'Lição 1',
        hasFinished: false,
        activityType: 'translation',
        isCorrect: false,
      );
      expect(trailBody.lessonIcon(lesson), Icons.translate_outlined);
    });

    test('Retorna ícone padrão para outros tipos', () {
      final lesson = Lesson(
        id: 1,
        name: 'Lição 1',
        hasFinished: false,
        activityType: 'outro',
        isCorrect: false,
      );
      expect(trailBody.lessonIcon(lesson), Icons.auto_stories_outlined);
    });
  });
}
