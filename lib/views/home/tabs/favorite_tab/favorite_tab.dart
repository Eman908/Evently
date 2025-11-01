import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/home/tabs/favorite_tab/provider/search_provider.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:evently/views/management_event/widgets/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});
  @override
  Widget build(BuildContext context) {
    EventDataBase eventDataBase = EventDataBase();
    TextEditingController input = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      builder: (context, child) {
        var provider = Provider.of<SearchProvider>(context);
        return SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: input,
                  onChanged: (value) {
                    provider.setSearchText(value);
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              StreamBuilder(
                stream: eventDataBase.getFavoriteList(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapShot.hasError) {
                    return Center(child: Text((snapShot.error.toString())));
                  } else if (snapShot.hasData) {
                    List<EventModel> events =
                        snapShot.data?.docs.map((e) => e.data()).toList() ?? [];
                    List<EventModel> filteredEvents =
                        provider.searchText.isEmpty
                            ? events
                            : events
                                .where(
                                  (event) => event.title.toLowerCase().contains(
                                    provider.searchText.toLowerCase(),
                                  ),
                                )
                                .toList();

                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          return EventCard(eventModel: filteredEvents[index]);
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
