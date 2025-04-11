import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CreatingStepPage extends StatefulWidget {
  const CreatingStepPage({super.key});

  @override
  State<CreatingStepPage> createState() => _CreatingStepPageState();
}

class _CreatingStepPageState extends State<CreatingStepPage>
    with TickerProviderStateMixin {
  int _delaySeconds = 5;
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _checkController;
  late Animation<double> _checkAnimation;

  bool _hasFinishedCheckAnimation = false;

  void startDelay() {
    Future.delayed(Duration(seconds: 1), () {
      if (context.mounted) {
        setState(() {
          _delaySeconds -= 1;
        });

        if (_delaySeconds > 0) {
          startDelay();
        }

        if (_delaySeconds == 1) {
          _controller.forward();
        }

        if (_delaySeconds == 0) {
          _controller.reverse();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasFinished = _delaySeconds == 0;

    Widget content() {
      if (hasFinished) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/check.json',
                width: 200,
                height: 200,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(const Duration(milliseconds: 1200), () {
                    setState(() {
                      _hasFinishedCheckAnimation = true;
                      _checkController.forward();
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
                        'Criado com sucesso!',
                        textAlign: TextAlign.center,
                        style: Font.primary(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        text: 'Ver plano de estudos',
                        onPressed: () {
                          context.pushReplacement(Routes.educacao);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/working.json',
            repeat: true,
            width: double.infinity,
          ),
          const SizedBox(height: 16),
          Text(
            'Trabalhando nisso...',
            textAlign: TextAlign.center,
            style: Font.primary(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Já estamos quase lá',
            textAlign: TextAlign.center,
            style: Font.primary(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.white,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FadeTransition(opacity: _animation, child: content()),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startDelay();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

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
    _controller.dispose();
    _checkController.dispose();
    super.dispose();
  }
}
