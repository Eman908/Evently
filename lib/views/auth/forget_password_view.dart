import 'dart:developer';

import 'package:evently/core/app_assets.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/widgets/app_bar_leading.dart';
import 'package:evently/views/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:evently/firebase/firebase_service.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgetPassword),
        leading: const AppBarLeading(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Image.asset(Assets.assetsImagesChangeSetting),
              CustomTextField(
                controller: emailText,
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(value)) {
                    return "Invalid Email";
                  }
                  {
                    return null;
                  }
                },
              ),
              FilledButton(
                onPressed: () {
                  try {
                    FirebaseService().forgetPassword(email: emailText.text);
                    Navigator.pop(context);
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Text(AppLocalizations.of(context)!.resetPass),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
