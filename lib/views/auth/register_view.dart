import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/widgets/app_bar_leading.dart';
import 'package:evently/views/auth/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        leading: const AppBarLeading(),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RegisterViewBody(),
        ),
      ),
    );
  }
}
