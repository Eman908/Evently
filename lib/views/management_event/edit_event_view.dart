import 'package:evently/core/app_dialog.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/home/models/category_model.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:evently/views/management_event/provider/event_provider.dart';
import 'package:evently/views/management_event/widgets/data_row.dart';
import 'package:evently/views/management_event/widgets/text_field_with_title.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventView extends StatefulWidget {
  const EditEventView({super.key});

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  late EventModel model;
  late CategoryModel selected;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      model = ModalRoute.of(context)!.settings.arguments as EventModel;
      title.text = model.title;
      description.text = model.description;
      selected = CategoryModel.categories.firstWhere(
        (e) => e.id == model.category.id,
      );
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<ToggleProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);

    var local = AppLocalizations.of(context)!;
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
        title: Text(local.edit_event),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 361 / 203,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(selected.imagePath),
            ),
          ),
          DefaultTabController(
            length: CategoryModel.categories.length,
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 16),
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(right: 16),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              onTap: (index) {
                selected = CategoryModel.categories[index];
                setState(() {});
              },
              tabs:
                  CategoryModel.categories
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:
                                e.id == selected.id
                                    ? theme.colorScheme.primary
                                    : Colors.transparent,
                            border: Border.all(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(
                                e.iconData,
                                color:
                                    e.id == selected.id
                                        ? Colors.white
                                        : theme.colorScheme.primary,
                              ),
                              Text(
                                provider.isEn(context) ? e.enName : e.arName,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color:
                                      e.id == selected.id
                                          ? Colors.white
                                          : theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          TextFieldWithTitle(
            controller: title,
            hint: local.event_title,
            title: local.title,
            icon: true,
          ),
          const SizedBox(height: 16),

          TextFieldWithTitle(
            controller: description,
            hint: local.event_description,
            title: local.description,
            maxLines: 5,
          ),
          const SizedBox(height: 16),

          DataRowWidget(
            iconData: Icons.date_range,
            title: local.event_date,
            info: DateFormat.yMMMMd(
              provider.isEn(context) ? 'en' : 'ar',
            ).format(
              eventProvider.selectedDate ??
                  DateTime.fromMillisecondsSinceEpoch(model.date),
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime.fromMillisecondsSinceEpoch(
                  model.date,
                ).subtract(const Duration(days: 365)),
                initialDate:
                    eventProvider.selectedDate ??
                    DateTime.fromMillisecondsSinceEpoch(model.date),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );

              eventProvider.pickDate(date: date);
            },
          ),

          const SizedBox(height: 16),

          DataRowWidget(
            iconData: Icons.schedule,
            title: local.event_time,
            info:
                eventProvider.selectedTime != null
                    ? DateFormat.jm(
                      provider.isEn(context) ? 'en' : 'ar',
                    ).format(
                      DateTime(
                        0,
                        1,
                        1,
                        eventProvider.selectedTime!.hour,
                        eventProvider.selectedTime!.minute,
                      ),
                    )
                    : DateFormat().add_jm().format(DateTime(model.time)),
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: eventProvider.selectedTime ?? TimeOfDay.now(),
              );
              eventProvider.pickTime(time: time);
            },
          ),
          const SizedBox(height: 16),

          FilledButton(
            onPressed: () async {
              model = EventModel(
                id: model.id,
                title: title.text.trim(),
                description: description.text.trim(),
                categoryId: selected.id,
                date:
                    (eventProvider.selectedDate ??
                            DateTime.fromMillisecondsSinceEpoch(model.date))
                        .millisecondsSinceEpoch,
                time:
                    DateTime(
                      0,
                      1,
                      1,
                      eventProvider.selectedTime?.hour ??
                          DateTime.fromMillisecondsSinceEpoch(model.time).hour,
                      eventProvider.selectedTime?.minute ??
                          DateTime.fromMillisecondsSinceEpoch(
                            model.time,
                          ).minute,
                    ).millisecondsSinceEpoch,
                favoriteEvent: model.favoriteEvent,
              );

              setState(() {});

              AppDialog.showLoadingDialog(
                barrierDismissible: false,
                context: context,
                loadingMessage: local.updatingEvent,
              );

              try {
                EventDataBase event = EventDataBase();
                event.updateEvent(
                  FirebaseAuth.instance.currentUser!.uid,
                  model,
                );

                Navigator.pop(context);

                AppDialog.showInfoDialog(
                  context: context,
                  message: local.eventUpdatedSuccessfully,
                  title: local.success,
                  posActionTitle: local.ok,
                  posAction: () {
                    Navigator.pop(context);
                  },
                );
              } catch (e) {
                Navigator.pop(context);
                AppDialog.showInfoDialog(
                  context: context,
                  message: e.toString(),
                  title: local.error,
                  posActionTitle: local.try_again,
                );
              }
            },

            child: Text(local.updateEvent),
          ),
        ],
      ),
    );
  }
}
