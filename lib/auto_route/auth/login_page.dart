import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:router_experiments/auto_route/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    @pathParam required this.onSuccess,
  }) : super(key: key);

  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () {
            context.read<AuthService>().login();
            onSuccess();
          },
        ),
      ),
    );
  }
}
