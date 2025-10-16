import 'package:evently/views/onboarding/widgets/active_inactive_pagination.dart';
import 'package:flutter/material.dart';

class PaginationBuilder extends StatelessWidget {
  const PaginationBuilder({
    super.key,
    required this.currentIndex,
    required this.length,
  });
  final int currentIndex, length;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: List.generate(length, (index) {
        return ActiveInactivePagination(isActive: index == currentIndex);
      }),
    );
  }
}
