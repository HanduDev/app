import 'package:app/models/trail/trail.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';

class Finished extends StatefulWidget {
  final String errorMessage;
  final Trail? trail;

  const Finished({super.key, required this.errorMessage, this.trail});

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
            context.pushReplacement(Routes.planoDeEstudos);
            return;
          }

          context.pushReplacement(
            Routes.trilha,
            extra: {"trail": widget.trail},
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasError = widget.errorMessage != "";

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            hasError ? 'assets/lottie/error.json' : 'assets/lottie/check.json',
            width: 150,
            height: 200,
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
                    hasError
                        ? widget.errorMessage
                        : 'plano_de_estudos.created'.i18n(),
                    textAlign: TextAlign.center,
                    style: Font.primary(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text:
                        hasError
                            ? "plano_de_estudos.try_again".i18n()
                            : 'plano_de_estudos.view_study_plan'.i18n(),
                    onPressed: () {
                      if (hasError) {
                        context.pushReplacement(Routes.planoDeEstudos);
                        return;
                      }

                      context.pushReplacement(
                        Routes.trilha,
                        extra: {"trail": widget.trail},
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "plano_de_estudos.after_created_seconds".i18n().replaceAll(
                      "{{seconds}}",
                      _afterCreatedSeconds.toString(),
                    ),
                    style: Font.primary(fontSize: 13, color: AppColors.white),
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
