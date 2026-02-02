import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        SizedBox(height: 16),
        Text(
          'Welcome to Violet App',
          style: isSmallScreen
              ? Theme.of(context).textTheme.headlineSmall
              : Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
