import 'package:app/routes/routes.dart';
import 'package:app/ui/account/widgets/account_edit_page.dart';
import 'package:app/ui/account/widgets/account_page.dart';
import 'package:app/ui/contact/widgets/contact_page.dart';
import 'package:go_router/go_router.dart';

List<StatefulShellBranch> accountBranches = [
  StatefulShellBranch(
    routes: [
      GoRoute(path: Routes.conta, builder: (context, state) => AccountPage()),
      GoRoute(path: Routes.editar, builder: (context, state) => AccountEditPage(),),
      GoRoute(path: Routes.contato, builder: (context, state) => ContactPage(),)
    ],
  ),
];
