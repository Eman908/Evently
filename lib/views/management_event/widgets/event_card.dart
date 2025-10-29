import 'package:evently/core/app_colors.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 361 / 203,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(eventModel.category.imagePath),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(eventModel.title),
            ),
          ],
        ),
      ),
    );
  }
}
