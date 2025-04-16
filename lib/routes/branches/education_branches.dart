import 'package:app/routes/routes.dart';
import 'package:app/ui/educacao/plano_de_estudos/widgets/creating_step_page.dart';
import 'package:app/ui/educacao/plano_de_estudos/widgets/estudos_container.dart';
import 'package:app/ui/educacao/plano_de_estudos/widgets/first_step_page.dart';
import 'package:app/ui/educacao/plano_de_estudos/widgets/second_step_page.dart';
import 'package:app/ui/educacao/widgets/educacao_page.dart';
import 'package:go_router/go_router.dart';

List<StatefulShellBranch> educationBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.educacao,
        builder: (context, state) => EducacaoPage(),
      ),
      GoRoute(
        path: Routes.planoDeEstudos,
        builder: (context, state) => EstudosContainer(child: FirstStepPage()),
      ),
      GoRoute(
        path: Routes.planoDeEstudosSecondStep,
        builder: (context, state) => EstudosContainer(child: SecondStepPage()),
      ),
      GoRoute(
        path: Routes.criandoPlanoDeEstudos,
        builder: (context, state) => CreatingStepPage(),
      ),
    ],
  ),
];
