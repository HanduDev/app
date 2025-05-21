import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/ui/trail/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailBody extends StatelessWidget {
  final Trail trail;

  const TrailBody({super.key, required this.trail});

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

    bool isPreviousFinished = index > 0 && lessons[index - 1].hasFinished;

    bool isNextFinished =
        index < lessons.length - 1 && lessons[index + 1].hasFinished;

    return (isPreviousFinished && !isNextFinished && !lesson.hasFinished) ||
        (index == 0 && !isNextFinished && !lesson.hasFinished);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TrailViewModel>().initialize(trail.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        final trailInfo = snapshot.data;

        if (trailInfo == null) {
          return const Center(child: Text('Nenhum dado encontrado'));
        }

        return Expanded(
          child: ListView.separated(
            itemCount: trailInfo.lessons.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              final lesson = trailInfo.lessons[index];
              bool isCurrent = isCurrentLesson(index, trailInfo.lessons);

              final color =
                  lesson.hasFinished
                      ? AppColors.green
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

              int currentIndex =
                  index -
                  trailInfo.lessons
                      .sublist(0, index)
                      .where((element) => element.activityType != null)
                      .length;

              return LessonCard(
                lesson: lesson,
                isCurrentLesson: isCurrentLesson(index, trailInfo.lessons),
                icon: lessonIcon(lesson),
                index: currentIndex,
              );
            },
          ),
        );
      },
    );
  }
}
