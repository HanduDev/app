import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:app/ui/traducao_texto/widgets/translate_text_page.dart';
import 'package:app/ui/translate_audio/widgets/translate_audio_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> translateBranches = [
  StatefulShellBranch(
    routes: [
      ShellRoute(
        builder:
            (context, state, child) => ChangeNotifierProvider(
              create: (_) => LanguagesProvider(),
              child: child,
            ),
        routes: [
          GoRoute(
            path: Routes.home,
            builder:
                (context, state) => ChangeNotifierProvider(
                  create:
                      (_) => TranslateTextViewModel(
                        translateRepository:
                            context.read<TranslateRepositoryImpl>(),
                      ),
                  child: TranslateTextPage(),
                ),
          ),
          GoRoute(path: Routes.audio, builder: (_, __) => TranslateAudioPage()),
        ],
      ),
    ],
  ),
];
