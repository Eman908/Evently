import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  const DataRowWidget({
    super.key,
    required this.iconData,
    required this.title,
    this.onTap,
    required this.info,
  });
  final IconData iconData;
  final String? title;
  final String info;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 8,
        children: [
          Icon(iconData, size: 28),
          Text(title ?? ''),
          const Spacer(),
          Text(info, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
