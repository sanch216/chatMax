import 'package:chat_max/components/my_button.dart';
import 'package:chat_max/components/my_textfield.dart';
import 'package:chat_max/services/auth/auth_service.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // метод логина
  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // иконка
            const Icon(
              Icons.message,
              size: 60,
              color: Color(0xFF2A2E8D),
            ),

            const SizedBox(height: 25),

            // приветственное сообщение
            const Text(
              "Welcome to our INAI team's Chat",
              style: TextStyle(
                color: Color(0xFF0D17C6),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 25),

            // поле ввода email
            MyTextField(
              hintText: "Email",
              obscuretext: false,
              controller: _emailController,
            ),

            const SizedBox(height: 25),

            // поле ввода пароля
            MyTextField(
              hintText: "Password",
              obscuretext: true,
              controller: _pwController,
            ),

            const SizedBox(height: 25),

            // кнопка входа
            MyButton(
              text: "LogIn",
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            // регистрация
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 38),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    " Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}