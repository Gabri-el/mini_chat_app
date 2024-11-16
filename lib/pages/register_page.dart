import 'package:flutter/material.dart';
import 'package:mini_chat_app/auth/auth_service.dart';
import 'package:mini_chat_app/components/my_buton.dart';
import 'package:mini_chat_app/components/my_textfield.dart';
import 'package:mini_chat_app/utils/utils.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});
  final void Function()? onTap;

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();

  //method to register
  void register(context) async {
    if (pwController.text == confirmPwController.text) {
      try {
        final auth = AuthService();
        await auth
            .createAccountWithPasswordAndEmail(
                emailController.text, pwController.text)
            .then((value) {
          Utils.showSnackBar("Login successful", context, "success");
        });
      } catch (error) {
        Utils.showSnackBar(error.toString(), context, "error");
      }
    } else {
      Utils.showSnackBar("Password does not match", context, "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
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
                  "Let's create an account for you",
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

                //pw textfield
                MyTextfield(
                  hintText: 'Confirm password',
                  controller: confirmPwController,
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //login button
                MyButon(
                  onTap: () {
                    register(context);
                  },
                  text: 'Register',
                ),

                const SizedBox(height: 25),

                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        " Login now",
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
      ),
    );
  }
}
