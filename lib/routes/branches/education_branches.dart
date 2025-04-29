import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/educacao/view_model/educacao_view_model.dart';
import 'package:app/ui/educacao/widgets/educacao_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> educationBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.educacao,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (context) => EducacaoViewModel(
                    trailRepository: context.read<TrailRepositoryImpl>(),
                  ),
              child: EducacaoPage(),
            ),
      ),
    ],
  ),
];
