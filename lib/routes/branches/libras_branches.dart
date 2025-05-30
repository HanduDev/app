import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/libras/image/view_model/libras_image_view_model.dart';
import 'package:app/ui/libras/image/widgets/libras_image_page.dart';
import 'package:app/ui/libras/text/view_model/libras_view_model.dart';
import 'package:app/ui/libras/text/widgets/libras_text_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> librasBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.librasText,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LibrasViewModel(),
              child: LibrasTextPage(),
            ),
      ),
      GoRoute(
        path: Routes.librasImage,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => LibrasImageViewModel(
            translateRepository:
                context.read<TranslateRepositoryImageImpl>(),
          ),
          child: LibrasImagePage(),
        ),
      ),
    ],
  ),
];
