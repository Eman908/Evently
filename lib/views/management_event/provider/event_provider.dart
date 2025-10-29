import 'package:evently/views/home/models/category_model.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  var selected = CategoryModel.categories.first;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  changeSelected(int index) {
    selected = CategoryModel.categories[index];
    notifyListeners();
  }

  pickDate({required DateTime? date}) {
    if (date != null) {
      selectedDate = date;
    }
    notifyListeners();
  }

  pickTime({required TimeOfDay? time}) {
    if (time != null) {
      selectedTime = time;
    }
    notifyListeners();
  }
}
