import 'package:evently/core/app_routes.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/home/tabs/profile_tab/widgets/profile_data.dart';
import 'package:evently/views/home/tabs/profile_tab/widgets/profile_pic_widget.dart';
// import 'package:evently/views/home/tabs/profile_tab/widgets/profile_picture.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToggleProvider>(context);
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
            top: 40,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(64),
            ),
          ),
          child: const SafeArea(
            child: Row(
              spacing: 24,
              children: [
                //ProfilePicture(),
                ProfilePicWidget(),
                ProfileData(),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Text(local.language, style: theme.textTheme.bodyLarge),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: provider.appLanguage,
                  onChanged: (newValue) {
                    provider.changeLanguage(newValue!);
                  },
                  iconEnabledColor: theme.colorScheme.primary,
                  underline: const SizedBox(),
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: Text(local.english),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ar',
                      child: Text(local.arabic),
                    ),
                  ],
                ),
              ),

              Text(local.theme, style: theme.textTheme.bodyLarge),
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<ThemeMode>(
                  isExpanded: true,
                  value: provider.appTheme,
                  onChanged: (newValue) {
                    provider.changeTheme(newValue!);
                  },
                  iconEnabledColor: theme.colorScheme.primary,
                  underline: const SizedBox(),
                  items: <DropdownMenuItem<ThemeMode>>[
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.light,
                      child: Text(local.light),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.dark,
                      child: Text(local.dark),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.system,
                      child: Text(local.system),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: FilledButton(
            onPressed: () async {
              await FirebaseService().userLogout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginRoute,
                  (Route<dynamic> route) => false,
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: Row(
              spacing: 8,
              children: [
                const SizedBox(width: 16),
                const Icon(Icons.logout),
                Text(local.logout),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
