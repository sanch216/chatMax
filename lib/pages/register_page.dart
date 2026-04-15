import 'package:chat_max/components/my_button.dart';
import 'package:chat_max/components/my_textfield.dart';
import 'package:chat_max/services/auth/auth_service.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirm_pwController = TextEditingController();

  final void Function()? onTap;

  // const RegisterPage({super.key});
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final auth = AuthService();
    if(_pwController.text == _confirm_pwController.text) {
      try {
        auth.signUpWithEmailPassword(
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match! "),
        ),
      );
    }
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xffe2a2ee),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.message,
                size: 60,
                color: Color(0xffffffff),
              ),
              const Text(
                "Let's create new account for you",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'название шрифта',
                ),
              ),
              const SizedBox( height: 25),
              MyTextField(
                hintText: "Email",
                obscuretext: false,
                controller: _emailController,
              ),
              const SizedBox( height: 25),
              MyTextField(
                hintText: "Password",
                obscuretext: false,
                controller: _pwController,
              ),
              MyTextField(
                hintText: "Confirm password",
                obscuretext: true,
                controller: _confirm_pwController,
              ),

              const SizedBox(height: 25),

              // кнопка регистрации
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),

              const SizedBox(height: 25),

              // переход на вход
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 38), // на фото ширина 38
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }