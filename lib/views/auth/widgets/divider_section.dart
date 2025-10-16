import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        const Expanded(child: Divider()),
        Text(
          AppLocalizations.of(context)!.or,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
