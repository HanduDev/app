import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TranslateLesson extends StatelessWidget {
  final LessonInfo lesson;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TranslateLesson({super.key, required this.lesson});

  void _checkAnswer(
    BuildContext context,
    TextEditingController controller,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    final isCorrect = await context.read<LessonViewModel>().checkAnswer(
      lesson.id,
      controller.text,
    );

    if (!context.mounted) return;

    if (isCorrect) {
      Toast.success(context, 'Resposta correta!');
      controller.clear();
      context.pop();

      return;
    }

    Toast.error(context, 'Resposta incorreta!');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: lesson.userAnswer,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lesson.question ?? "",
          style: Font.primary(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: TextInput(
            label: lesson.hasFinished ? "" : "Digite sua resposta",
            enabled: !lesson.hasFinished,
            maxLines: 3,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Resposta é obrigatória";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          onPressed: () => _checkAnswer(context, controller),
          text: lesson.hasFinished ? "Concluído" : "Enviar resposta",
          disabled: lesson.hasFinished,
        ),
      ],
    );
  }
}
