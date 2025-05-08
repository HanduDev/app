import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_controller.dart';
import 'package:app/ui/core/shared/selectable_grid/selectable_grid_model.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OptionsLesson extends StatelessWidget {
  final LessonInfo lesson;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  OptionsLesson({super.key, required this.lesson});

  void _checkAnswer(
    BuildContext context,
    SelectableGridController controller,
  ) async {
    try {
      if (!_formKey.currentState!.validate()) {
        Toast.error(context, 'Selecione uma opção');
        return;
      }

      final selectedOption = controller.value?.value;

      if (selectedOption == null) return;

      final isCorrect = await context.read<LessonViewModel>().checkAnswer(
        lesson.id,
        selectedOption,
      );

      if (!context.mounted) return;

      if (isCorrect) {
        Toast.success(context, 'Resposta correta!');
        context.pop();
        return;
      }

      Toast.error(context, 'Resposta incorreta!');
    } catch (e) {
      Toast.error(context, getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = SelectableGridController();

    List<SelectableGridModel> list =
        lesson.options!
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            lesson.question ?? "",
            style: Font.primary(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SelectableGrid(
            items: list,
            crossAxisCount: 1,
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return "Selecione uma opção";
              }

              return null;
            },
            childAspectRatio: 16 / 3,
            render: (item, isSelected) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      item.label,
                      style: Font.primary(
                        color:
                            isSelected ? AppColors.primary500 : AppColors.black,
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
            onPressed: () => _checkAnswer(context, controller),
            text: lesson.hasFinished ? "Concluído" : "Enviar resposta",
            disabled: lesson.hasFinished,
          ),
        ],
      ),
    );
  }
}
