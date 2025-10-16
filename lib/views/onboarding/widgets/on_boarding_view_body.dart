import 'package:evently/core/app_assets.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:evently/views/onboarding/widgets/language_toggle.dart';
import 'package:evently/views/onboarding/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToggleProvider>(context);
    var size = MediaQuery.sizeOf(context);
    var theme = Theme.of(context);
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            Assets.assetsImagesHorizlogo,
            width: size.width * .5,
          ),
        ),
        Expanded(
          child: Image.asset(
            provider.isDark(context)
                ? Assets.assetsImagesDesignerDesk
                : Assets.assetsImagesBeingCreative,
          ),
        ),

        Text(
          AppLocalizations.of(context)!.personalizeYourExperience,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppLocalizations.of(context)!.onboardingContent,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const LanguageToggle(),
        const ThemeToggle(),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.introRoute);
            },
            child: Text(AppLocalizations.of(context)!.lets),
          ),
        ),
      ],
    );
  }
}
