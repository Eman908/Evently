import 'package:evently/core/app_colors.dart';
import 'package:evently/core/helper_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalizeEachWord(FirebaseAuth.instance.currentUser!.displayName!),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          FirebaseAuth.instance.currentUser!.email!,
          maxLines: 2,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
