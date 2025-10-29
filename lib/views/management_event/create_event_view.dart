import 'package:evently/core/app_dialog.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/views/home/models/category_model.dart';
import 'package:evently/views/management_event/models/event_model.dart';
import 'package:evently/views/management_event/provider/event_provider.dart';
import 'package:evently/views/management_event/widgets/data_row.dart';
import 'package:evently/views/management_event/widgets/event_app_bar.dart';
import 'package:evently/views/management_event/widgets/text_field_with_title.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    var theme = Theme.of(context);
    var provider = Provider.of<ToggleProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: eventAppBar(context, title: 'Create Event'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 361 / 203,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(eventProvider.selected.imagePath),
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
                eventProvider.changeSelected(index);
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
                                e.id == eventProvider.selected.id
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
                                    e.id == eventProvider.selected.id
                                        ? Colors.white
                                        : theme.colorScheme.primary,
                              ),
                              Text(
                                provider.isEn(context) ? e.enName : e.arName,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color:
                                      e.id == eventProvider.selected.id
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
            hint: 'Event Title',
            title: 'Title',
            icon: true,
          ),
          const SizedBox(height: 16),

          TextFieldWithTitle(
            controller: description,
            hint: 'Event Description',
            title: 'Description',
            maxLines: 5,
          ),
          const SizedBox(height: 16),

          DataRowWidget(
            iconData: Icons.date_range,
            title: 'Event Date',
            info:
                eventProvider.selectedDate == null
                    ? 'Choose Date'
                    : DateFormat(
                      'dd-MM-yyyy',
                    ).format(eventProvider.selectedDate!),

            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: eventProvider.selectedDate ?? DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              eventProvider.pickDate(date: date);
            },
          ),
          const SizedBox(height: 16),

          DataRowWidget(
            iconData: Icons.schedule,
            title: 'Event Time',
            info:
                eventProvider.selectedTime == null
                    ? 'Choose Time'
                    : DateFormat().add_jm().format(
                      DateTime(
                        0,
                        0,
                        0,
                        eventProvider.selectedTime!.hour,
                        eventProvider.selectedTime!.minute,
                      ),
                    ),
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
              String errorMessage = '';
              if (title.text.isEmpty) {
                errorMessage += "Title cannot be empty\n";
              }
              if (description.text.isEmpty) {
                errorMessage += "Description cannot be empty\n";
              }
              if (eventProvider.selectedDate == null) {
                errorMessage += "Date cannot be empty\n";
              }
              if (eventProvider.selectedTime == null) {
                errorMessage += "Time cannot be empty\n";
              }
              if (errorMessage.isNotEmpty) {
                AppDialog.showInfoDialog(
                  context: context,
                  message: errorMessage,
                  title: 'Invalid Data',
                  posActionTitle: "Try Again",
                );
                return;
              }
              AppDialog.showLoadingDialog(
                barrierDismissible: false,
                context: context,
                loadingMessage: 'Creating Event...',
              );
              try {
                EventDataBase event = EventDataBase();
                await event.createEvent(
                  EventModel(
                    categoryId: eventProvider.selected.id,
                    date: eventProvider.selectedDate!.millisecondsSinceEpoch,
                    description: description.text,
                    id: '',
                    time:
                        DateTime(
                          0,
                          0,
                          0,
                          eventProvider.selectedTime!.hour,
                          eventProvider.selectedTime!.minute,
                        ).millisecondsSinceEpoch,
                    title: title.text,
                  ),
                );
                Navigator.pop(context);
                AppDialog.showInfoDialog(
                  context: context,
                  message: 'Event Created Successfully',
                  title: 'Success',
                  posActionTitle: "OK",
                  posAction: () {
                    Navigator.pop(context);
                  },
                );
              } catch (e) {
                Navigator.pop(context);
                AppDialog.showInfoDialog(
                  context: context,
                  message: e.toString(),
                  title: 'Error',
                  posActionTitle: "Try Again",
                );
              }
            },
            child: const Text('Add Event'),
          ),
        ],
      ),
    );
  }
}
