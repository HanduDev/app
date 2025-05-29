import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

double radius = 30;

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
      if (lesson.isCorrect || lesson.isTheorical) {
        return {
          "backgroundColor": AppColors.green,
          "borderColor": const Color.fromARGB(255, 51, 112, 53),
          "textColor": const Color.fromARGB(255, 51, 112, 53),
        };
      }

      return {
        "backgroundColor": AppColors.error,
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

    return InkWell(
      onTap: () {
        if (!isCurrentLesson && !lesson.hasFinished) {
          Toast.info(context, "trail.lesson_card.unpermitted_access".i18n());
          return;
        }

        context.push(Routes.aula, extra: {"lesson": lesson});
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: radius,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: backgroundColor, width: 6),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: radius * 2,
                height: radius * 2,
                child: Icon(
                  icon,
                  color:
                      lesson.hasFinished || isCurrentLesson
                          ? AppColors.grey
                          : AppColors.lightGrey,
                  size: radius / 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: Font.primary(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  lesson.subtitle,
                  style: Font.primary(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
