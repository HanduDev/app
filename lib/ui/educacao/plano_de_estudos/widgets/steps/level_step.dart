import 'package:app/ui/core/shared/dropdown/dropdown_button.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelStep extends StatelessWidget {
  const LevelStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormsContainerViewModel>();

    return Dropdown(
      width: double.infinity,
      render: (value) => Text(value),
      title: "Qual seu nível em ${viewModel.languageController.value['name']}?",
      data: viewModel.levels,
      controller: viewModel.levelController,
      validator: (value) {
        if (value == null) {
          return 'Selecione um nível';
        }
        return null;
      },
    );
  }
}
