import 'package:evently/core/app_assets.dart';
import 'package:evently/views/auth/widgets/already_have_account_button.dart';
import 'package:evently/views/auth/widgets/register_form.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:evently/views/onboarding/widgets/language_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          Image.asset(
            Assets.assetsImagesLogo,
            width: MediaQuery.sizeOf(context).width * .4,
          ),

          const RegisterForm(),
          const AlreadyHaveAccountButton(),
          LanguageToggleWidget(provider: Provider.of<ToggleProvider>(context)),
        ],
      ),
    );
  }
}
