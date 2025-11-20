import 'package:evently/core/helper_methods.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/home/provider/bottom_nav_provider.dart';
import 'package:evently/views/home/tabs/home_tab/widgets/home_tab_bar.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:evently/views/management_event/widgets/event_card.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventDataBase eventDataBase = EventDataBase();
    var providerC = Provider.of<BottomNavProvider>(context);
    final selected =
        providerC.selectedCategory ?? providerC.categoriesList.first;

    var theme = Theme.of(context);
    var provider = Provider.of<ToggleProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
            top: 40,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                provider.isDark(context)
                    ? theme.colorScheme.surface
                    : theme.colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Column(
              spacing: 8,
              children: [
                Row(
                  children: [
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.welcome} ✨",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          capitalizeEachWord(
                            FirebaseAuth.instance.currentUser!.displayName ??
                                'LOLO',
                          ),
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (provider.themeNow() == 1) {
                          provider.changeTheme(ThemeMode.dark);
                        } else if (provider.themeNow() == 2) {
                          provider.changeTheme(ThemeMode.system);
                        } else {
                          provider.changeTheme(ThemeMode.light);
                        }
                      },
                      style: IconButton.styleFrom(
                        side: BorderSide(
                          color:
                              provider.isDark(context)
                                  ? theme.colorScheme.surface
                                  : theme.colorScheme.primary,
                        ),
                      ),
                      icon: Icon(
                        color: Colors.white,
                        provider.themeNow() == 1
                            ? Icons.light_mode
                            : provider.themeNow() == 2
                            ? Icons.dark_mode
                            : Icons.brightness_auto,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        provider.changeLanguage(
                          provider.isEn(context) ? 'ar' : 'en',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theme.colorScheme.onPrimary,
                        ),
                        child: Text(
                          provider.isEn(context) ? 'EN' : 'AR',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: theme.colorScheme.onPrimary,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                HomeTebBar(provider: provider, theme: theme),
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: eventDataBase.getEventStream(
            selected,
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
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCard(eventModel: events[index]);
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
