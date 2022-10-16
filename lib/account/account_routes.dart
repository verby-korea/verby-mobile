import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';

class AccountRoutes {
  AccountRoutes._();

  static const String _rootRouteName = 'account';

  static final NestedRoute route = NestedRoute(
    name: _rootRouteName,
    builder: (child, _) => child,
    subRoutes: [
      _login,
      _register,
    ],
  );

  static final NestedRoute _login = NestedRoute(
    name: 'login',
    builder: (_, __) => const LoginScreen(),
  );
  static String get loginRouteName => '/$_rootRouteName/${_login.name}';

  static final NestedRoute _register = NestedRoute(
    name: 'register',
    builder: (_, __) => const RegisterScreen(),
  );
  static String get registerRouteName => '/$_rootRouteName/${_register.name}';
}
