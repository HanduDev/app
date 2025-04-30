import 'package:app/routes/routes.dart';
import 'package:app/ui/account/widgets/account_page.dart';
import 'package:go_router/go_router.dart';

List<StatefulShellBranch> accountBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(path: Routes.conta, builder: (context, state) => AccountPage()),
    ],
  ),
];
