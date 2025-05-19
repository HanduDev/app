import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isCurrentLesson;
  final IconData icon;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.isCurrentLesson,
    required this.icon,
  });

  Map<String, Color> colorsConfig() {
    if (isCurrentLesson) {
      return {
        "backgroundColor": AppColors.primary300,
        "borderColor": AppColors.primary500,
        "textColor": AppColors.white,
      };
    }

    if (lesson.hasFinished) {
      return {
        "backgroundColor": AppColors.green,
        "borderColor": const Color.fromARGB(255, 51, 112, 53),
        "textColor": const Color.fromARGB(255, 51, 112, 53),
      };
    }

    return {
      "backgroundColor": AppColors.lightGrey,
      "borderColor": const Color.fromARGB(255, 158, 153, 153),
      "textColor": AppColors.black,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = colorsConfig();
    final backgroundColor = colors["backgroundColor"]!;
    final borderColor = colors["borderColor"]!;

    return GestureDetector(
      onTap: () {
        if (!isCurrentLesson && !lesson.hasFinished) {
          Toast.info(context, "Você ainda não pode acessar esta aula");
          return;
        }

        context.push(Routes.aula, extra: {"lesson": lesson});
      },
      child: CircleAvatar(
        radius: 50,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: borderColor,
                spreadRadius: -0.5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          width: 100,
          height: 100,
          child: Icon(icon, color: colors["textColor"], size: 30),
        ),
      ),
    );
  }
}
