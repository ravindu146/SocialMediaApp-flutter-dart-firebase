import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/pages/login_page.dart';
import 'package:mini_social_media_app_2/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially open the login page

  bool showLoginPage = true;

  // Function to toggle between login and register pages

  void togglePages() {
    setState(() {
      this.showLoginPage = !this.showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage == true) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
