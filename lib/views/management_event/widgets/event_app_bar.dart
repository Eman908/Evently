import 'package:flutter/material.dart';

AppBar eventAppBar(BuildContext context, {required String title}) {
  return AppBar(
    title: Text(title, style: Theme.of(context).textTheme.titleLarge),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: IconButton.styleFrom(
        side: const BorderSide(color: Colors.transparent),
      ),
      icon: const Icon(Icons.arrow_back),
    ),
  );
}
