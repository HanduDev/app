import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/education/view_model/education_view_model.dart';
import 'package:app/ui/education/widgets/education_page.dart';
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
                  (context) => EducationViewModel(
                    trailRepository: context.read<TrailRepositoryImpl>(),
                  ),
              child: EducationPage(),
            ),
      ),
    ],
  ),
];
