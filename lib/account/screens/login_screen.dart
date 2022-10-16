import 'package:flutter/material.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VerbyButton.textButton(
          text: '회원가입',
          onPressed: () => Navigator.of(context).pushNamed(
            AccountRoutes.registerRouteName,
            arguments: const RouteArguments(
              trasition: RouteTransitions.slideTop,
            ),
          ),
          style: VerbyButton.styleFrom(
            buttonWidth: VerbyButtonWidth.contract,
          ),
        ),
      ),
    );
  }
}
