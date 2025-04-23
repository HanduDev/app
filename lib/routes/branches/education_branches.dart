import 'package:app/routes/routes.dart';
import 'package:app/ui/educacao/widgets/educacao_page.dart';
import 'package:go_router/go_router.dart';

List<StatefulShellBranch> educationBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.educacao,
        builder: (context, state) => EducacaoPage(),
      ),
    ],
  ),
];
