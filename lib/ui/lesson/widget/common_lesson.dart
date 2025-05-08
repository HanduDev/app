import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/models/lesson/lesson_update_request.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CommonLesson extends StatelessWidget {
  final LessonInfo lesson;

  const CommonLesson({super.key, required this.lesson});

  void _updateLesson(BuildContext context) async {
    try {
      if (lesson.hasFinished) return;

      await context.read<LessonViewModel>().update(
        LessonUpdateRequest(id: lesson.id, hasFinished: true),
      );

      if (!context.mounted) return;

      Toast.success(context, 'Aula concluída com sucesso!');

      context.pop();
    } catch (e) {
      if (!context.mounted) return;

      Toast.error(context, getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: MarkdownBody(data: lesson.content ?? ""),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          onPressed: () => _updateLesson(context),
          text: lesson.hasFinished ? "Concluído" : "Marcar como concluído",
          disabled: lesson.hasFinished,
        ),
      ],
    );
  }
}
