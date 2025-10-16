import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:evently/firebase/firebase_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double?> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        var loggedIn = FirebaseService().isLoggedIn();
        String initialRoute =
            loggedIn ? AppRoutes.onBoardingRoute : AppRoutes.homeRoute;
        Navigator.pushReplacementNamed(context, initialRoute);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          AnimatedBuilder(
            animation: _animationController,
            builder:
                (context, child) => Transform.scale(
                  scale: _animation.value,
                  child: Center(
                    child: Image.asset(
                      Assets.assetsImagesLogo,
                      width: MediaQuery.sizeOf(context).width * .5,
                    ),
                  ),
                ),
          ),
          const Spacer(),
          SafeArea(
            bottom: true,
            child: Image.asset(
              Assets.assetsImagesBranding,
              width: MediaQuery.sizeOf(context).width * .5,
            ),
          ),
        ],
      ),
    );
  }
}
