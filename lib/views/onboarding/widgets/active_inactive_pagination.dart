import 'package:flutter/material.dart';

class ActiveInactivePagination extends StatelessWidget {
  const ActiveInactivePagination({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
          height: 8,
          width: 20,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(40),
          ),
        )
        : Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
        );
  }
}
