import 'package:app/ui/core/shared/dropdown/dropdown_multiple.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstStepPage extends StatelessWidget {
  const FirstStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormsContainerViewModel>(
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.firstStepFormController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Qual idioma você quer aprender?"),
              const SizedBox(height: 6),
              LanguageSelector(
                width: double.infinity,
                controller:
                    viewModel.firstStepFormController.languageController,
              ),
              const SizedBox(height: 12),
              Text("O que você quer desenvolver?"),
              const SizedBox(height: 6),
              DropdownMultiple(
                controller:
                    viewModel.firstStepFormController.developmentsController,
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
              ),

              const SizedBox(height: 12),
              Text(
                "Existe algum tema em especial que você gostaria de estudar? (opcional)",
              ),
              const SizedBox(height: 6),
              DropdownMultiple(
                controller: viewModel.firstStepFormController.themesController,
                width: double.infinity,
                title: "Selecione um tema",
                render: (value) {
                  return Text(value.name);
                },
                data: DropdownMultipleModel.fromArray(viewModel.themes),
              ),
            ],
          ),
        );
      },
    );
  }
}
