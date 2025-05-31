import 'package:app/routes/routes.dart';
import 'package:app/ui/auth/register/widgets/register_page.dart';
import 'package:app/ui/auth/introducton/view_model/introduction_view_model.dart';
import 'package:app/ui/auth/introducton/widgets/introduction_page.dart';
import 'package:app/ui/auth/login/widgets/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

List<StatefulShellBranch> authBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: Routes.intro,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => IntroductionViewModel(),
            child: IntroductionPage(),
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
          return RegisterPage();
        },
      ),
    ],
  ),
];
