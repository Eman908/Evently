import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToggleProvider>(context);
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.theme,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        SizedBox(
          height: 40,
          child: AnimatedToggleSwitch.rolling(
            current: provider.appTheme,
            values: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
            style: ToggleStyle(
              borderColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.primary,
            ),
            indicatorSize: const Size.fromWidth(40),
            padding: EdgeInsets.zero,
            borderWidth: 1,
            onChanged: (value) {
              provider.changeTheme(value);
            },
            iconList: const [
              Icon(Icons.brightness_auto),
              Icon(Icons.light_mode),
              Icon(Icons.dark_mode),
            ],
          ),
        ),
      ],
    );
  }
}
