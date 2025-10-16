import 'package:evently/views/onboarding/models/intro_model.dart';
import 'package:flutter/material.dart';

class IntroViewBody extends StatelessWidget {
  const IntroViewBody({super.key, required this.item});
  final IntroModel item;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 32,
      children: [
        Expanded(child: Image.asset(item.image)),
        Text(
          item.title,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          item.content,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
