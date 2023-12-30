import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/components/my_button.dart';
import 'package:mini_social_media_app_2/components/my_textfield.dart';
import 'package:mini_social_media_app_2/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // Show the loading circle

    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try to signIn

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // if (context.mounted) Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);

      // show message to the user
      displayMessageToTheUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(height: 25),
              //app name

              Text(
                "M I N I M A L",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              SizedBox(height: 50),

              // email text  field
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),

              SizedBox(height: 50),

              // password text field
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              SizedBox(height: 10),

              // forgot password

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password ?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),

              SizedBox(height: 25),

              // signin Button

              MyButton(text: 'Login', onTap: login),

              SizedBox(height: 25),

              // don't have an account? Register here

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    child: Text(
                      "Register Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: widget.onTap,
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
