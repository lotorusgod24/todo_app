import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/auth/widgets/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogIn();
          },
          child: Text('LogIn Google'),
        ),
      ),
    );
  }
}
