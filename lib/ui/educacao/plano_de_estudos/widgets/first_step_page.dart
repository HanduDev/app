import 'package:app/ui/core/shared/dropdown_multiple.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/educacao/plano_de_estudos/controllers/first_step_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstStepPage extends StatelessWidget {
  const FirstStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirstStepFormController>(
      builder: (context, controller, child) {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Qual idioma você quer aprender?"),
              const SizedBox(height: 6),
              LanguageSelector(
                width: double.infinity,
                value: controller.language,
                onChanged: (value) {
                  controller.language = value;
                },
              ),
              const SizedBox(height: 12),
              Text("O que você quer desenvolver?"),
              const SizedBox(height: 6),
              DropdownMultiple(
                width: double.infinity,
                selectedValues: controller.developments,
                placeholder: Text(
                  controller.developments.isEmpty
                      ? 'Selecione'
                      : controller.developments.join(', '),
                ),
                onChange: (value) {
                  controller.setDevelopments(value);
                },
                render: (value) {
                  return Text(value);
                },
                data: ['Fala', 'Leitura', 'Escrita', 'Escuta'],
              ),
            ],
          ),
        );
      },
    );
  }
}
