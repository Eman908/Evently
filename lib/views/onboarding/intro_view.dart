import 'package:evently/core/app_assets.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/onboarding/models/intro_model.dart';
import 'package:evently/views/onboarding/provider/intro_provider.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:evently/views/onboarding/widgets/intro_view_body.dart';
import 'package:evently/views/onboarding/widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToggleProvider>(context);
    var size = MediaQuery.sizeOf(context);
    List<IntroModel> items = [
      IntroModel(
        title: AppLocalizations.of(context)!.onBoarding1Title,
        content: AppLocalizations.of(context)!.onBoarding1Content,
        image: Assets.assetsImagesHotTrending,
      ),
      IntroModel(
        title: AppLocalizations.of(context)!.onBoarding2Title,
        content: AppLocalizations.of(context)!.onBoarding2Content,
        image:
            provider.isDark(context)
                ? Assets.assetsImagesWireframe
                : Assets.assetsImagesBeingCreative2,
      ),
      IntroModel(
        title: AppLocalizations.of(context)!.onBoarding3Title,
        content: AppLocalizations.of(context)!.onBoarding2Content,
        image:
            provider.isDark(context)
                ? Assets.assetsImagesUploading
                : Assets.assetsImagesBeingCreative1,
      ),
    ];
    return ChangeNotifierProvider(
      create: (context) => IntroProvider(),
      builder: (context, child) {
        var provider2 = Provider.of<IntroProvider>(context);

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  Center(
                    child: Image.asset(
                      Assets.assetsImagesHorizlogo,
                      width: size.width * .5,
                    ),
                  ),
                  Expanded(
                    child: IntroViewBody(item: items[provider2.currentIndex]),
                  ),
                  const SizedBox(height: 8),
                  Pagination(provider2: provider2, items: items),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
