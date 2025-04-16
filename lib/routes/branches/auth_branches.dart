import 'package:app/routes/routes.dart';
import 'package:app/ui/cadastro/widgets/cadastro_page.dart';
import 'package:app/ui/intro/view_model/intro_view_model.dart';
import 'package:app/ui/intro/widgets/intro_page.dart';
import 'package:app/ui/login/widgets/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> authBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.intro,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => IntroViewModel(),
            child: IntroPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: Routes.cadastro,
        builder: (context, state) {
          return CadastroPage();
        },
      ),
    ],
  ),
];
