import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/study_plan/view_model/forms_container_view_model.dart';
import 'package:app/ui/study_plan/widgets/creating_step_page.dart';
import 'package:app/ui/study_plan/widgets/studies_container.dart';
import 'package:app/ui/study_plan/widgets/finished_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> createTrailBranches = [
  StatefulShellBranch(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ChangeNotifierProvider(
            create:
                (context) => FormsContainerViewModel(
                  trailRepository: context.read<TrailRepositoryImpl>(),
                ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: Routes.planoDeEstudos,
            builder: (context, state) => StudiesContainer(),
          ),
          GoRoute(
            path: Routes.criandoPlanoDeEstudos,
            builder: (context, state) => CreatingStepPage(),
          ),
          GoRoute(
            path: Routes.finalizarPlanoDeEstudos,
            builder: (context, state) {
              final thisState = state.extra as Map<String, dynamic>?;
              final trail = thisState?['trail'] as Trail?;
              final errorMessage = thisState?['errorMessage'] as String?;

              return FinishedPage(
                errorMessage: errorMessage ?? '',
                trail: trail,
              );
            },
          ),
        ],
      ),
    ],
  ),
];
