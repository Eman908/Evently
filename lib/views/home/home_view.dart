import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/home/provider/bottom_nav_provider.dart';
import 'package:evently/views/home/tabs/home_tab/home_tab.dart';
import 'package:evently/views/home/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    List<Widget> tabs = [
      const HomeTab(),
      const Center(child: Text("plus")),
      const Center(child: Text("Profile")),
      const ProfileTab(),
    ];
    return ChangeNotifierProvider(
      create: (context) => BottomNavProvider(),
      builder: (context, child) {
        var provider = Provider.of<BottomNavProvider>(context);
        return Scaffold(
          body: tabs[provider.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.createEventRoute);
            },
            shape: const CircleBorder(
              side: BorderSide(width: 5, color: AppColors.white),
            ),
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:
                provider.currentIndex >= 2
                    ? provider.currentIndex + 1
                    : provider.currentIndex,
            onTap: (value) {
              provider.getCurrentIndex(context, value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: local.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.location_on_outlined),
                activeIcon: const Icon(Icons.location_on),
                label: local.map,
              ),
              const BottomNavigationBarItem(icon: Icon(null), label: ""),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_border_outlined),
                activeIcon: const Icon(Icons.favorite),
                label: local.love,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: local.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
