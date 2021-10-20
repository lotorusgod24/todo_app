import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasker/auth/screens/loginPage.dart';
import 'package:tasker/todo_list/screens/homescreen.dart';

class AuthCheckState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Ops, error'),
            );
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else
            return LoginPage();
        },
      ),
    );
  }
}
