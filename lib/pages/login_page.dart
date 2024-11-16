import 'package:flutter/material.dart';
import 'package:mini_chat_app/auth/auth_service.dart';
import 'package:mini_chat_app/components/my_buton.dart';
import 'package:mini_chat_app/components/my_textfield.dart';
import 'package:mini_chat_app/utils/utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap});
  final void Function()? onTap;

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      final auth = AuthService();
      await auth
          .signInPasswordAndEmail(pwController.text, emailController.text)
          .then((value) {
        Utils.showSnackBar("Login successful", context, "success");
      });
      // if (context.mounted) {
      // }
    } catch (error) {
      if (context.mounted) {
        Utils.showSnackBar(error.toString(), context, "error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),

              const SizedBox(height: 50),

              //welcome back message
              Text(
                "Welcome back to chat-mini",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              //email textfield
              MyTextfield(
                hintText: 'Email',
                controller: emailController,
                obscureText: false,
              ),
              const SizedBox(height: 25),

              //pw textfield
              MyTextfield(
                hintText: 'Password',
                controller: pwController,
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //login button
              MyButon(
                onTap: () async {
                  await login(context);
                },
                text: 'Login',
              ),

              const SizedBox(height: 25),

              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
