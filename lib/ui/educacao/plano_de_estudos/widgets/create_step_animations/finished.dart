import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/educacao/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Finished extends StatefulWidget {
  const Finished({super.key});

  @override
  State<Finished> createState() => _FinishedState();
}

class _FinishedState extends State<Finished> with TickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkAnimation;

  int _afterCreatedSeconds = 5;
  bool _hasFinishedCheckAnimation = false;

  void startSeconds(BuildContext context, bool hasError) {
    Future.delayed(Duration(seconds: 1), () {
      if (context.mounted) {
        setState(() {
          _afterCreatedSeconds -= 1;
        });

        if (_afterCreatedSeconds > 0) {
          startSeconds(context, hasError);
        }

        if (_afterCreatedSeconds == 0) {
          if (hasError) {
            context.pushReplacement(Routes.planoDeEstudosSecondStep);
            return;
          }

          context.go(Routes.educacao);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormsContainerViewModel>();

    String errorText = viewModel.errorText;
    bool hasError = errorText != "";

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            hasError ? 'assets/lottie/error.json' : 'assets/lottie/check.json',
            width: hasError ? 200 : 200,
            height: hasError ? 200 : 200,
            repeat: false,
            onLoaded: (composition) {
              Future.delayed(const Duration(milliseconds: 1200), () {
                if (!context.mounted) return;

                setState(() {
                  _hasFinishedCheckAnimation = true;
                  _checkController.forward();
                  startSeconds(context, hasError);
                });
              });
            },
          ),

          Visibility(
            visible: _hasFinishedCheckAnimation,
            child: ScaleTransition(
              scale: _checkAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    hasError ? errorText : 'Criado com sucesso!',
                    textAlign: TextAlign.center,
                    style: Font.primary(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text:
                        hasError ? "Tentar novamente" : 'Ver plano de estudos',
                    onPressed: () {
                      if (hasError) {
                        context.pushReplacement(
                          Routes.planoDeEstudosSecondStep,
                        );
                        return;
                      }

                      context.go(Routes.educacao);
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ou aguarde $_afterCreatedSeconds segundos",
                    style: Font.primary(fontSize: 14, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _checkAnimation = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }
}
