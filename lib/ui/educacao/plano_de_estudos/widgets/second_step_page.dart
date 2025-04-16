import 'package:app/ui/core/shared/dropdown/dropdown_button.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondStepPage extends StatelessWidget {
  const SecondStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<FormsContainerViewModel>();

    return Form(
      key: viewModel.secondStepFormController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Qual seu nível em"),
              const SizedBox(width: 4),

              Text(
                "${viewModel.firstStepFormController.languageController.value['name']}?",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              CountryFlag.fromLanguageCode(
                viewModel
                    .firstStepFormController
                    .languageController
                    .value['countryCode'],
                height: 20,
                width: 30,
                shape: const RoundedRectangle(4),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Dropdown(
            width: double.infinity,
            render: (value) => Text(value),
            title:
                "Qual seu nível em ${viewModel.firstStepFormController.languageController.value['name']}?",
            data: ['Iniciante', 'Intermediário', 'Avançado'],
            controller: viewModel.secondStepFormController.level,
            validator: (value) {
              if (value == null) {
                return 'Selecione um nível';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Text("Quanto tempo você quer que dure o plano de estudos?"),
          const SizedBox(height: 6),
          Dropdown(
            width: double.infinity,
            render: (value) => Text(value),
            title: "Selecione um tempo de duração",
            data: ['1 semana', '2 semanas', '3 semanas', '4 semanas'],
            controller: viewModel.secondStepFormController.timeToLearn,
            validator: (value) {
              if (value == null) {
                return 'Selecione um tempo de duração';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Text("Quantos minutos você quer estudar por dia?"),
          const SizedBox(height: 6),
          Dropdown(
            width: double.infinity,
            render: (value) => Text(value),
            title: "Quantos minutos por dia?",
            data: [
              '10 minutos',
              '20 minutos',
              '30 minutos',
              '40 minutos',
              '50 minutos',
              '60 minutos',
            ],
            controller: viewModel.secondStepFormController.timeToStudy,
            validator: (value) {
              if (value == null) {
                return 'Selecione o tempo de estudo';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
