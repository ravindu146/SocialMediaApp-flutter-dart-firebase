import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/auth/auth.dart';
import 'package:mini_social_media_app_2/auth/login_or_register.dart';
import 'package:mini_social_media_app_2/firebase_options.dart';
import 'package:mini_social_media_app_2/pages/home_page.dart';
import 'package:mini_social_media_app_2/pages/profile_page.dart';
import 'package:mini_social_media_app_2/pages/register_page.dart';
import 'package:mini_social_media_app_2/pages/users_page.dart';
import 'package:mini_social_media_app_2/theme/dark_mode.dart';
import 'package:mini_social_media_app_2/theme/light_mode.dart';

import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthPage(),
      // theme: lightMode,
      theme: darkMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profie_page': (context) => ProfilePage(),
        '/users_page': (context) => UsersPage()
      },
    );
  }
}
