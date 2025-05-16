import 'package:app/models/lesson/lesson.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isCurrentLesson;
  const LessonCard({
    super.key,
    required this.lesson,
    required this.isCurrentLesson,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isCurrentLesson
            ? AppColors.primary400
            : lesson.hasFinished
            ? AppColors.green
            : AppColors.lightGrey;
    final Color borderColor =
        isCurrentLesson
            ? AppColors.primary500
            : lesson.hasFinished
            ? AppColors.green
            : AppColors.grey;
    return GestureDetector(
      onTap: () {
        context.push(Routes.aula, extra: {"lesson": lesson});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(100),
        ),
        width: 100,
        height: 100,
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color:
                  lesson.hasFinished
                      ? AppColors.primary300
                      : AppColors.lightGrey,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
