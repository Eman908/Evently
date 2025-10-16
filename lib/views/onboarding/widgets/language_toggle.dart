import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/app_assets.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToggleProvider>(context);
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        LanguageToggleWidget(provider: provider),
      ],
    );
  }
}

class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key, required this.provider});

  final ToggleProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: AnimatedToggleSwitch.rolling(
        current: provider.appLanguage,
        values: const ['en', 'ar'],
        style: ToggleStyle(
          borderColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
        ),
        indicatorSize: const Size.fromWidth(40),
        padding: EdgeInsets.zero,
        borderWidth: 3,
        onChanged: (value) {
          provider.changeLanguage(value);
        },
        iconList: [
          Image.asset(Assets.assetsImagesEN),
          Image.asset(Assets.assetsImagesAR),
        ],
      ),
    );
  }
}
