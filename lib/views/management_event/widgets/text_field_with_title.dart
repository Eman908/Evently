import 'package:flutter/material.dart';

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    super.key,
    required this.title,
    this.icon,
    required this.hint,
    this.maxLines = 1,
    this.controller,
    this.label,
    this.onChanged,
  });
  final String title, hint;
  final bool? icon;
  final String? label;
  final int? maxLines;
  final void Function(String)? onChanged;
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This Cannot be empty";
            } else {
              return '';
            }
          },
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: icon == null ? null : const Icon(Icons.edit),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
