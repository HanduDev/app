import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/translate/translate_text/view_model/translate_text_view_model.dart';
import 'package:app/ui/translate/translate_text/widgets/translate_text_page.dart';
import 'package:app/ui/translate/translate_audio/widgets/translate_audio_page.dart';
import 'package:app/ui/translate/translate_image/widgets/translate_image_page.dart';
import 'package:app/ui/translate/translate_image/view_model/translate_image_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> translateBranches = [
  StatefulShellBranch(
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
      GoRoute(
        path: Routes.audio,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) => TranslateTextViewModel(
                    translateRepository:
                        context.read<TranslateRepositoryImpl>(),
                  ),
              child: const TranslateAudioPage(),
            ),
      ),
      GoRoute(
        path: Routes.image,
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) => TranslateImageViewModel(
                    translateRepository:
                        context.read<TranslateRepositoryImageImpl>(),
                  ),
              child: const TranslateImagePage(),
            ),
      ),
    ],
  ),
];
