import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.system;
  String appLanguage = "en";

  void changeLanguage(String currentLanguage) {
    if (appLanguage == currentLanguage) {
      return;
    }
    appLanguage = currentLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode currentTheme) {
    if (appTheme == currentTheme) {
      return;
    }
    appTheme = currentTheme;

    notifyListeners();
  }

  bool isDark(BuildContext context) {
    switch (appTheme) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }
}
