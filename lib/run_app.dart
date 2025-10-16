import 'package:evently/core/app_routes.dart';
import 'package:evently/core/app_theme.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/forget_password_view.dart';
import 'package:evently/views/auth/login_view.dart';
import 'package:evently/views/auth/register_view.dart';
import 'package:evently/views/home/home_view.dart';
import 'package:evently/views/onboarding/intro_view.dart';
import 'package:evently/views/onboarding/on_boarding_view.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:evently/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ToggleProvider(),
      builder: (context, child) {
        var provider = Provider.of<ToggleProvider>(context);
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.appLanguage),
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          themeMode: provider.appTheme,
          routes: {
            AppRoutes.splashRoute: (context) => const SplashView(),
            AppRoutes.onBoardingRoute: (context) => const OnBoardingView(),
            AppRoutes.introRoute: (context) => const IntroView(),
            AppRoutes.loginRoute: (context) => const LoginView(),
            AppRoutes.registerRoute: (context) => const RegisterView(),
            AppRoutes.homeRoute: (context) => const HomeView(),
            AppRoutes.forgetPasswordRoute:
                (context) => const ForgetPasswordView(),
          },
          initialRoute: AppRoutes.loginRoute,
        );
      },
    );
  }
}
