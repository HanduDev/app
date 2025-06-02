import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/ui/trail/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class TrailBody extends StatelessWidget {
  final Trail trail;
  final ScrollController scrollController = ScrollController();

  TrailBody({super.key, required this.trail});

  int getCurrentLessonIndex(List<Lesson> lessons) {
    for (int i = 0; i < lessons.length; i++) {
      if (isCurrentLesson(i, lessons)) {
        return i;
      }
    }
    return 0;
  }

  void scrollToCurrentLesson(List<Lesson> lessons) {
    final currentIndex = getCurrentLessonIndex(lessons);

    if (currentIndex >= 0 && currentIndex < lessons.length) {
      final itemHeight = 40.0;
      final separatorHeight = 28.0;
      final padding = 32.0;

      final position =
          (currentIndex * (itemHeight + separatorHeight)) + padding;

      scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  IconData lessonIcon(Lesson lesson) {
    if (lesson.activityType == 'text') {
      return Icons.text_snippet_outlined;
    }

    if (lesson.activityType == 'multiple_choice') {
      return Icons.check_circle_outline;
    }

    if (lesson.activityType == 'translation') {
      return Icons.translate_outlined;
    }

    return Icons.auto_stories_outlined;
  }

  bool isCurrentLesson(int index, List<Lesson> lessons) {
    final lesson = lessons[index];

    bool isFirstUnfinishedAfterFinished =
        index > 0 && lessons[index - 1].hasFinished && !lesson.hasFinished;

    bool isFirstUnfinishedLesson = index == 0 && !lesson.hasFinished;

    return isFirstUnfinishedAfterFinished || isFirstUnfinishedLesson;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TrailViewModel>().initialize(trail.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        final trailInfo = snapshot.data;

        if (trailInfo == null) {
          return Center(child: Text('trail.no_data_found'.i18n()));
        }

        // Chama a função de scroll quando os dados são carregados
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToCurrentLesson(trailInfo.lessons);
        });

        return ListView.separated(
          controller: scrollController,
          itemCount: trailInfo.lessons.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            final lesson = trailInfo.lessons[index];
            bool isCurrent = isCurrentLesson(index, trailInfo.lessons);

            final color =
                lesson.hasFinished
                    ? lesson.isCorrect || lesson.isTheorical
                        ? AppColors.green
                        : AppColors.error
                    : isCurrent
                    ? AppColors.primary300
                    : AppColors.lightGrey;

            return Row(
              children: [
                const SizedBox(width: 27),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 4,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            );
          },
          itemBuilder: (context, index) {
            final lesson = trailInfo.lessons[index];

            return LessonCard(
              lesson: lesson,
              isCurrentLesson: isCurrentLesson(index, trailInfo.lessons),
              icon: lessonIcon(lesson),
            );
          },
        );
      },
    );
  }
}
