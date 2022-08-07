import 'package:verby_mobile/account/screens/login_screen.dart';
import 'package:verby_mobile/services/services.dart';

class AccountRoutes {
  AccountRoutes._();

  static const String _rootRouteName = 'account';

  static final NestedRoute route = NestedRoute(
    name: _rootRouteName,
    builder: (child, _) => child,
    subRoutes: [
      _login,
    ],
  );

  static final NestedRoute _login = NestedRoute(
    name: 'login',
    builder: (_, __) => const LoginScreen(),
  );
  static String get loginRouteName => '/$_rootRouteName/${_login.name}';
}
