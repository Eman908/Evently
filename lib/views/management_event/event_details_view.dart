import 'package:evently/core/app_dialog.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    EventDataBase eventDataBase = EventDataBase();
    var provider = Provider.of<ToggleProvider>(context);
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
        title: Text(AppLocalizations.of(context)!.event_details),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editEventRoute,
                arguments: model,
              );
            },
            style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
            ),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              AppDialog.showLoadingDialog(
                context: context,
                loadingMessage: AppLocalizations.of(context)!.delete,
                barrierDismissible: false,
              );

              try {
                await EventDataBase().deleteEvent(
                  FirebaseAuth.instance.currentUser!.uid,
                  model,
                );
              } catch (e) {
                Navigator.pop(context);
                AppDialog.showInfoDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.error,
                  message: e.toString(),
                  posActionTitle: AppLocalizations.of(context)!.try_again,
                );
              }
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
      body: StreamBuilder(
        stream: eventDataBase.getEventStreamEdited(
          FirebaseAuth.instance.currentUser!.uid,
          model,
        ),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || !(snapshot.data?.exists ?? false)) {
            Future.microtask(() {
              if (Navigator.canPop(context)) Navigator.pop(context);
            });
            return const SizedBox();
          }

          final updatedModel = snapshot.data!.data()!;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              AspectRatio(
                aspectRatio: 361 / 203,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(updatedModel.category.imagePath),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                updatedModel.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                          DateFormat.yMMMMd(
                            provider.isEn(context) ? 'en' : 'ar',
                          ).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              updatedModel.date,
                            ),
                          ),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          DateFormat.jm(
                            provider.isEn(context) ? 'en' : 'ar',
                          ).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              updatedModel.time,
                            ),
                          ),

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
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                AppLocalizations.of(context)!.description,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                updatedModel.description,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          );
        },
      ),
    );
  }
}
