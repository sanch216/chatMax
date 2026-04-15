import 'package:chat_max/pages/register_page.dart';
import 'package:chat_max/pages/login_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  void tooglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: tooglePage,
      );
    } else {
      return RegisterPage(
        onTap: tooglePage,
      );
    }
  }
}
