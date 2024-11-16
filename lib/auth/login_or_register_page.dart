import 'package:flutter/material.dart';
import 'package:mini_chat_app/pages/login_page.dart';
import 'package:mini_chat_app/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initial showing the login page
  bool showInitialPage = true;

  //method to toggle between login and registter page
  void toggle() {
    setState(() {
      showInitialPage = !showInitialPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showInitialPage) {
      return LoginPage(
        onTap: () {
          toggle();
        },
      );
    } else {
      return RegisterPage(
        onTap: () {
          toggle();
        },
      );
    }
  }
}
