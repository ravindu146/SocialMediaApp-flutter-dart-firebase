// import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/components/my_button.dart';
import 'package:mini_social_media_app_2/components/my_textfield.dart';

import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  // register method
  void registerUSer() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure the passwords match
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);

      // show the error message to the user
      displayMessageToTheUser("Passwords don't match!", context);
    } else {
      // if the passwords do match
      // try creating the user
      try {
        // Create the user
        UserCredential UserCredential1 = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Create a user document and add to the firestore
        createUserDocument(UserCredential1);

        // pop the loading circle

        Navigator.pop(context);
      } on FirebaseException catch (e) {
        // pop the loading circle
        Navigator.pop(context);

        // display the error message to the user
        displayMessageToTheUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential1) async {
    if (userCredential1 != null && userCredential1.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential1.user!.email)
          .set({
        'uid': userCredential1.user!.uid,
        'email': userCredential1.user!.email,
        'username': usernameController.text
      });
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

              // username text  field
              MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController),

              SizedBox(height: 25),

              // email text  field
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),

              SizedBox(height: 25),

              // password text field
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              SizedBox(height: 25),

              // confirm password text field
              MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController),

              SizedBox(height: 25),

              // signin Button

              MyButton(text: 'Register', onTap: registerUSer),

              SizedBox(height: 25),

              // don't have an account? Register here

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    child: Text(
                      "Login Here",
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
