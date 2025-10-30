import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            side: const BorderSide(color: Colors.transparent),
          ),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Event Details"),
        actions: [
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
            ),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await EventDataBase().deleteEvent(
                FirebaseAuth.instance.currentUser!.uid,
                model,
              );
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
            ),
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          AspectRatio(
            aspectRatio: 361 / 203,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(model.category.imagePath),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            model.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Icon(Icons.date_range, color: Colors.white),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat(
                        'd MMMM y',
                      ).format(DateTime.fromMillisecondsSinceEpoch(model.date)),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat(
                        'h:mm a',
                      ).format(DateTime.fromMillisecondsSinceEpoch(model.time)),

                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Icon(Icons.gps_fixed, color: Colors.white),
                ),
                Text(
                  "Cairo, Egypt",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text(
            "Description",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            model.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
