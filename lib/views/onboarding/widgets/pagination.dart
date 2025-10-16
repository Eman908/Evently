import 'package:evently/views/onboarding/models/intro_model.dart';
import 'package:evently/views/onboarding/provider/intro_provider.dart';
import 'package:evently/views/onboarding/widgets/pagination_builder.dart';
import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key, required this.provider2, required this.items});

  final IntroProvider provider2;
  final List<IntroModel> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        provider2.currentIndex == 0
            ? IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                side: const BorderSide(width: 0, color: Colors.transparent),
              ),
              icon: const Icon(null),
            )
            : IconButton(
              onPressed: () {
                provider2.previousPage(items.length);
              },

              icon: const Icon(Icons.arrow_back),
            ),
        PaginationBuilder(
          currentIndex: provider2.currentIndex,
          length: items.length,
        ),
        IconButton(
          onPressed: () {
            provider2.nextPage(context, items.length);
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
