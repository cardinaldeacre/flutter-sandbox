import 'package:flutter/material.dart';
import '../widgets/login_logo.dart';
import '../widgets/auth_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    LoginLogo(),
                    SizedBox(height: 20),
                    AuthForm(),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: const [
                    Expanded(child: LoginLogo()),
                    Expanded(child: Center(child: AuthForm())),
                  ],
                ),
              ),
      ),
    );
  }
}
