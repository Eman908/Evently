import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
    );
  }
}
