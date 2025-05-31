import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/routes/animation_builder.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/progress_bar.dart';
import 'package:app/ui/core/shared/secondary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/study_plan/view_model/forms_container_view_model.dart';
import 'package:app/ui/study_plan/widgets/form_label.dart';
import 'package:app/ui/study_plan/widgets/steps/development_step.dart';
import 'package:app/ui/study_plan/widgets/steps/language_step.dart';
import 'package:app/ui/study_plan/widgets/steps/level_step.dart';
import 'package:app/ui/study_plan/widgets/steps/theme_step.dart';
import 'package:app/ui/study_plan/widgets/steps/time_to_study_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class StudiesContainer extends StatelessWidget {
  const StudiesContainer({super.key});

  widgetBuilder(BuildContext context) {
    final viewModel = context.read<FormsContainerViewModel>();

    switch (viewModel.currentIndex) {
      case 0:
        return {
          "title": "Qual idioma você quer aprender?",
          "child": LanguageStep(),
        };
      case 1:
        return {
          "title": "O que você quer aprender?",
          "subtitle": "Selecione um ou mais itens abaixo",
          "child": DevelopmentStep(),
        };
      case 2:
        return {
          "title":
              "Qual o seu nível em ${viewModel.languageController.value?.label}?",
          "child": LevelStep(),
        };
      case 3:
        return {
          "title": "Quanto tempo você tem disponível por dia?",
          "child": TimeToStudyStep(),
        };
      case 4:
        return {
          "title": "Gostaria de falar sobre algum tema específico? (opcional)",
          "subtitle": "Selecione um ou mais itens abaixo",
          "child": ThemeStep(),
        };
      default:
        return {
          "title": "Em quanto tempo você quer aprender?",
          "child": const SizedBox.shrink(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<FormsContainerViewModel>();
    final isLastStep = context.watch<FormsContainerViewModel>().isLastStep;
    final currentIndex = context.watch<FormsContainerViewModel>().currentIndex;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Widget child = widgetBuilder(context)['child'];
    String starterLabel = "plano_de_estudos.steps.titles.$currentIndex".i18n();
    String label = starterLabel.replaceAll(
      "{{language}}",
      viewModel.languageController.value?.label ?? "",
    );
    String? subtitle = "plano_de_estudos.steps.subtitle.$currentIndex".i18n();

    void onFinish() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("plano_de_estudos.dialog.title".i18n()),
            content: Text("plano_de_estudos.dialog.content".i18n()),
            actions: [
              TextButton(
                child: Text(
                  "plano_de_estudos.dialog.not_now".i18n(),
                  style: Font.primary(fontSize: 14, color: AppColors.error),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "plano_de_estudos.dialog.yes_please".i18n(),
                  style: Font.primary(fontSize: 14),
                ),
                onPressed: () async {
                  try {
                    Navigator.of(context).pop();
                    context.pushReplacement(Routes.criandoPlanoDeEstudos);
                    await viewModel.onFinish();
                  } catch (e) {
                    if (!context.mounted) return;
                    Toast.error(context, getErrorMessage(e));
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        viewModel.previousPage();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'plano-hero-tag',
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        padding: const EdgeInsets.only(left: 8, right: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary400,
                              AppColors.primary200,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: AppColors.white,
                              ),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            Text(
                              "plano_de_estudos.title".i18n(),
                              style: Font.primary(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: ProgressBar(
                          value: currentIndex / (viewModel.totalSteps - 1),
                          backgroundColor: AppColors.grey.withAlpha(35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      FormLabel(label),
                      Text(
                        subtitle,
                        style: Font.primary(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Form(
                          key: formKey,
                          child: AnimationBuilder(widget: child),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Hero(
                tag: 'actions',
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      currentIndex > 0
                          ? Flexible(
                            child: SecondaryButton(
                              text: "plano_de_estudos.back".i18n(),
                              width: 150,
                              onPressed: () {
                                if (currentIndex > 0) {
                                  viewModel.previousPage();
                                } else {
                                  context.pop();
                                }
                              },
                              leftIcon: Icon(Icons.arrow_back, size: 25),
                            ),
                          )
                          : const SizedBox.shrink(),
                      currentIndex > 0
                          ? const SizedBox(width: 10)
                          : const SizedBox.shrink(),

                      Flexible(
                        child: PrimaryButton(
                          text:
                              isLastStep
                                  ? "plano_de_estudos.finish".i18n()
                                  : "plano_de_estudos.next".i18n(),
                          onPressed: () {
                            if (viewModel.isLastStep) {
                              return onFinish();
                            }

                            if (formKey.currentState!.validate()) {
                              viewModel.nextPage();
                            } else {
                              Toast.error(
                                context,
                                "plano_de_estudos.select_at_least_one_item"
                                    .i18n(),
                              );
                            }
                          },
                          leftIcon: Icon(
                            isLastStep ? Icons.check : Icons.arrow_forward,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
