import 'package:app/ui/core/shared/dropdown/dropdown_multiple.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevelopmentStep extends StatelessWidget {
  const DevelopmentStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormsContainerViewModel>();

    return DropdownMultiple(
      controller: viewModel.developController,
      width: double.infinity,
      title: "O que você quer desenvolver?",
      render: (value) {
        return Text(value.name);
      },
      validator: (values) {
        if (values.isEmpty) {
          return "Selecione pelo menos um desenvolvimento";
        }
        return null;
      },
      data: DropdownMultipleModel.fromArray(viewModel.developments),
    );
  }
}
