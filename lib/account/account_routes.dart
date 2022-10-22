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
      _findId,
      _passwordReset,
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

  static final NestedRoute _findId = NestedRoute(
    name: 'find-id',
    builder: (_, __) => const FindIdScreen(),
  );
  static String get findIdRouteName => '/$_rootRouteName/${_findId.name}';

  static final NestedRoute _passwordReset = NestedRoute(
    name: 'password-reset',
    builder: (_, __) => const PasswordResetScreen(),
  );
  static String get passwordResetRouteName => '/$_rootRouteName/${_passwordReset.name}';
}
