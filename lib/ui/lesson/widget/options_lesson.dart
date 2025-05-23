import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/models/option.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_color.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OptionsLesson extends StatefulWidget {
  final LessonInfo lesson;

  const OptionsLesson({super.key, required this.lesson});

  @override
  State<OptionsLesson> createState() => _OptionsLessonState();
}

class _OptionsLessonState extends State<OptionsLesson> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SelectableGridController _controller = SelectableGridController();
  late LessonInfo _lesson;

  double alpha = 0.2;

  void _checkAnswer(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        Toast.error(context, 'Selecione uma opção');
        return;
      }

      final selectedOption = _controller.value?.value;

      if (selectedOption == null) return;

      final isCorrect = await context.read<LessonViewModel>().checkAnswer(
        _lesson.id,
        selectedOption,
      );

      if (!context.mounted) return;

      if (isCorrect) {
        Toast.success(context, 'Resposta correta!');
        context.pop();
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

  SelectableGridColor selectedColor(String value) {
    if (!_lesson.hasFinished) {
      return SelectableGridColor(
        backgroundColor: AppColors.white,
        borderColor: AppColors.lightGrey,
      );
    }

    if (_lesson.userAnswer == value) {
      return _lesson.isCorrect
          ? SelectableGridColor(
            backgroundColor: AppColors.green.withValues(alpha: alpha),
            borderColor: const Color.fromARGB(255, 89, 168, 91),
          )
          : SelectableGridColor(
            backgroundColor: AppColors.error.withValues(alpha: alpha),
            borderColor: AppColors.error,
          );
    }

    if (_lesson.options == null) {
      return SelectableGridColor(
        backgroundColor: AppColors.white,
        borderColor: AppColors.grey,
      );
    }

    Option? option = _lesson.options?.firstWhere(
      (option) => option.id.toString() == value,
    );

    if (option == null || !option.isCorrect) {
      return SelectableGridColor(
        backgroundColor: AppColors.white,
        borderColor: AppColors.grey,
      );
    }

    return SelectableGridColor(
      backgroundColor: AppColors.white,
      borderColor: AppColors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    int attemptCount = 3 - _lesson.attemptCount;

    List<SelectableGridModel> list =
        _lesson.options!
            .map(
              (option) => SelectableGridModel(
                value: option.id.toString(),
                label: option.content,
              ),
            )
            .toList();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _lesson.question ?? "",
            style: Font.primary(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),

          if (!_lesson.hasFinished)
            Text(
              attemptCount == 0
                  ? "Sem tentativas restantes"
                  : "Você ainda tem ${3 - _lesson.attemptCount} tentativas",
              style: Font.primary(fontSize: 14, color: AppColors.grey),
            ),
          const SizedBox(height: 16),
          SelectableGrid(
            items: list,
            disabled: _lesson.hasFinished,
            crossAxisCount: 1,
            onColorChange: _lesson.hasFinished ? selectedColor : null,
            controller: _controller,
            validator: (value) {
              if (value.isEmpty) {
                return "Selecione uma opção";
              }

              return null;
            },
            childAspectRatio: 16 / 3,
            render: (item, isSelected, colorData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      item.label,
                      style: Font.primary(
                        color: colorData.borderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            onPressed: () => _checkAnswer(context),
            text: _lesson.hasFinished ? "Concluído" : "Enviar resposta",
            disabled: _lesson.hasFinished,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lesson = widget.lesson;
  }
}
