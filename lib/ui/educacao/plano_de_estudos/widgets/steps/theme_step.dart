import 'package:app/ui/core/shared/dropdown/dropdown_multiple.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeStep extends StatelessWidget {
  const ThemeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormsContainerViewModel>();

    return DropdownMultiple(
      controller: viewModel.themesController,
      width: double.infinity,
      title: "Selecione o(s) tema(s) (opcional)",
      render: (value) {
        return Text(value.name);
      },
      data: DropdownMultipleModel.fromArray(viewModel.themes),
    );
  }
}
