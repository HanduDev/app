import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/progress_bar.dart';
import 'package:app/ui/core/shared/secondary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EstudosContainer extends StatelessWidget {
  final Widget child;

  const EstudosContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<FormsContainerViewModel>();
    final title = context.watch<FormsContainerViewModel>().currentTitle;
    final isLastStep = context.watch<FormsContainerViewModel>().isLastStep;
    final currentIndex = context.watch<FormsContainerViewModel>().currentIndex;

    void onFinish() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Criar plano?"),
            content: Text(
              "Podemos prosseguir com a criação do seu plano de estudos?",
            ),
            actions: [
              TextButton(
                child: Text(
                  "Agora não",
                  style: Font.primary(fontSize: 14, color: AppColors.error),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "Sim, por favor",
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
                              'Plano de Estudos',
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  title,
                                  style: Font.primary(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${currentIndex + 1} de ${viewModel.totalSteps}",
                                  style: Font.primary(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary400,
                                  ),
                                ),
                              ],
                            ),
                            ProgressBar(
                              value: (currentIndex) / 2,
                              backgroundColor: AppColors.grey.withAlpha(35),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: child,
                ),
              ),
              const SizedBox(height: 4),

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
                              text: "Voltar",
                              width: 150,
                              onPressed: () {
                                context.pop();
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
                          text: isLastStep ? "Finalizar" : "Próximo",
                          onPressed: () {
                            if (!viewModel.validate()) {
                              return;
                            }

                            if (viewModel.isLastStep) {
                              return onFinish();
                            }

                            if (currentIndex == 0) {
                              context.push(Routes.planoDeEstudosSecondStep);
                            }

                            viewModel.nextPage();
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
