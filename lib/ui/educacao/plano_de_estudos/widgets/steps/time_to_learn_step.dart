import 'package:app/ui/core/shared/dropdown/dropdown_button.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeToLearnStep extends StatelessWidget {
  const TimeToLearnStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormsContainerViewModel>();

    return Dropdown(
      width: double.infinity,
      render: (value) => Text(value),
      title: "Em quanto tempo você quer aprender?",
      data: viewModel.timeToLearn,
      controller: viewModel.timeToLearnController,
      validator: (value) {
        if (value == null) {
          return 'Selecione um tempo de aprendizado';
        }
        return null;
      },
    );
  }
}
