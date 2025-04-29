import 'package:app/models/lesson/lesson.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/lesson/widget/lesson_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonPage extends StatelessWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SharedHeader(
              title: Text(
                lesson.name,
                style: Font.primary(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
              onBackPressed: () {
                context.pop();
              },
            ),
            LessonBody(lesson: lesson),
          ],
        ),
      ),
    );
  }
}
