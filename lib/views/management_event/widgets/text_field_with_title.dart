import 'package:flutter/material.dart';

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    super.key,
    required this.title,
    this.icon,
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });
  final String title, hint;
  final bool? icon;
  final int? maxLines;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This Cannot be empty";
            } else {
              return '';
            }
          },
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: icon == null ? null : const Icon(Icons.edit),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
