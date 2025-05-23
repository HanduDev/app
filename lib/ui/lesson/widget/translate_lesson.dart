import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranslateLesson extends StatefulWidget {
  final LessonInfo lesson;

  const TranslateLesson({super.key, required this.lesson});

  @override
  State<TranslateLesson> createState() => _TranslateLessonState();
}

class _TranslateLessonState extends State<TranslateLesson> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LessonInfo _lesson;
  late TextEditingController _controller;

  void _checkAnswer(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) return;

      final isCorrect = await context.read<LessonViewModel>().checkAnswer(
        _lesson.id,
        _controller.text,
      );

      if (!context.mounted) return;

      if (isCorrect) {
        Toast.success(context, 'Resposta correta!');
        _controller.clear();
        return;
      }

      _lesson = await context.read<LessonViewModel>().initialize(_lesson.id);
      setState(() {});

      if (!context.mounted) return;

      Toast.error(context, 'Resposta incorreta!');
    } catch (e) {
      Toast.error(context, getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAnswering = context.select<LessonViewModel, bool>(
      (viewModel) => viewModel.isAnswering,
    );

    int attemptCount = 3 - _lesson.attemptCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _lesson.question ?? "",
          style: Font.primary(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        if (!_lesson.hasFinished)
          Text(
            attemptCount == 0
                ? "Sem tentativas restantes"
                : "Você ainda tem ${3 - _lesson.attemptCount} tentativas",
            style: Font.primary(fontSize: 14, color: AppColors.grey),
          ),
        const SizedBox(height: 16),
        buildContainer(_controller),
        const SizedBox(height: 16),
        PrimaryButton(
          loading: isAnswering,
          onPressed: () => _checkAnswer(context),
          text: _lesson.hasFinished ? "Concluído" : "Enviar resposta",
          disabled: _lesson.hasFinished,
        ),
      ],
    );
  }

  Widget buildContainer(TextEditingController controller) {
    if (!_lesson.hasFinished) {
      return Form(
        key: _formKey,
        child: TextInput(
          label: _lesson.hasFinished ? "" : "Digite sua resposta",
          enabled: !_lesson.hasFinished,
          maxLines: 3,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Resposta é obrigatória";
            }
            return null;
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sua resposta",
          style: Font.primary(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _lesson.isCorrect ? AppColors.green : AppColors.error,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _lesson.userAnswer ?? "",
          style: Font.primary(
            fontSize: 15,
            color: _lesson.isCorrect ? AppColors.green : AppColors.error,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Resposta sugerida pelo Handu",
          style: Font.primary(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(_lesson.expectedAnswer ?? '', style: Font.primary(fontSize: 15)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _lesson = widget.lesson;
    _controller = TextEditingController(text: _lesson.userAnswer);
  }
}
