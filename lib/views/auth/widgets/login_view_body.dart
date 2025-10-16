import 'package:evently/core/app_assets.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/widgets/create_accout_button.dart';
import 'package:evently/views/auth/widgets/divider_section.dart';
import 'package:evently/views/auth/widgets/login_form.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:evently/views/onboarding/widgets/language_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 24,
        children: [
          Image.asset(
            Assets.assetsImagesLogo,
            width: MediaQuery.sizeOf(context).width * .4,
          ),

          const LoginForm(),

          const CreateAccountButton(),

          const DividerSection(),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              label: Text(AppLocalizations.of(context)!.loginWith),
              icon: Image.asset(
                Assets.assetsImagesGoogle,
                width: MediaQuery.sizeOf(context).width * .07,
              ),
            ),
          ),

          LanguageToggleWidget(provider: Provider.of<ToggleProvider>(context)),
        ],
      ),
    );
  }
}
