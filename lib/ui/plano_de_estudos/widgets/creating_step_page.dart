import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/plano_de_estudos/view_model/forms_container_view_model.dart';
import 'package:app/ui/plano_de_estudos/widgets/create_step_animations/finished.dart';
import 'package:app/ui/plano_de_estudos/widgets/create_step_animations/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatingStepPage extends StatefulWidget {
  const CreatingStepPage({super.key});

  @override
  State<CreatingStepPage> createState() => _CreatingStepPageState();
}

class _CreatingStepPageState extends State<CreatingStepPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FadeTransition(
              opacity: _animation,
              child:
                  context.select<FormsContainerViewModel, bool>(
                        (vm) => vm.isLoading,
                      )
                      ? Loading()
                      : Finished(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
