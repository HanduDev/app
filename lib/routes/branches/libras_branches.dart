import 'package:app/routes/routes.dart';
import 'package:app/ui/libras/view_model/libras_view_model.dart';
import 'package:app/ui/libras/widgets/libras_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> librasBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.libras,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LibrasViewModel(),
              child: LibrasPage(),
            ),
      ),
    ],
  ),
];
