import 'package:evently/core/app_routes.dart';
import 'package:evently/core/helper_methods.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.eventDetailsRoute, arguments: eventModel);
      },
      child: AspectRatio(
        aspectRatio: 361 / 203,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(eventModel.category.imagePath),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Text(
                  eventModel.date.formattedDate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      eventModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        EventDataBase().updateFavorite(
                          FirebaseAuth.instance.currentUser!.uid,
                          eventModel,
                        );
                      },
                      child: Icon(
                        color: Theme.of(context).colorScheme.primary,
                        eventModel.favoriteEvent
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
