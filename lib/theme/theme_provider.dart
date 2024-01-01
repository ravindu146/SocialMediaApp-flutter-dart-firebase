import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/theme/dark_mode.dart';
import 'package:mini_social_media_app_2/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightMode;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme == lightMode) ? darkMode : lightMode;
    notifyListeners();
  }
}
