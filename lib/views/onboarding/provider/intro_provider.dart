import 'package:evently/core/app_routes.dart';
import 'package:flutter/widgets.dart';

class IntroProvider extends ChangeNotifier {
  int currentIndex = 0;
  void nextPage(BuildContext context, int length) {
    if (currentIndex < length - 1) {
      currentIndex++;
    } else {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
    }
    notifyListeners();
  }

  void previousPage(int length) {
    if (currentIndex != 0) {
      currentIndex--;
    }
    notifyListeners();
  }
}
