import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/data/repositories/lesson/check_answer/check_answer_repository.dart';
import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:app/ui/lesson/widget/lesson_page.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/ui/trail/widgets/trail_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> trailBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.trilha,
        builder: (context, state) {
          final trail = state.extra as Map<String, dynamic>?;
          final trailData = trail?['trail'] as Trail;

          return ChangeNotifierProvider(
            create:
                (context) => TrailViewModel(
                  trailRepository: context.read<TrailRepositoryImpl>(),
                ),
            child: TrailPage(trail: trailData),
          );
        },
      ),
      GoRoute(
        path: Routes.aula,
        builder: (context, state) {
          final lesson = state.extra as Map<String, dynamic>?;
          final lessonData = lesson?['lesson'] as Lesson;

          return ChangeNotifierProvider(
            create:
                (context) => LessonViewModel(
                  lessonRepository: context.read<LessonRepositoryImpl>(),
                  checkAnswerRepository: context.read<CheckAnswerRepositoryImpl>(),
                ),
            child: LessonPage(lesson: lessonData),
          );
        },
      ),
    ],
  ),
];
