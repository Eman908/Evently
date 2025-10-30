import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/views/home/models/category_model.dart';

class EventModel {
  String title, description, id;
  int categoryId;
  int date, time;
  bool favoriteEvent;

  EventModel({
    required this.categoryId,
    required this.date,
    required this.description,
    required this.id,
    required this.time,
    required this.title,
    this.favoriteEvent = false,
  });

  factory EventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EventModel(
      categoryId: data?['categoryId'],
      date: data?['date'],
      description: data?['description'],
      id: data?['id'],
      time: data?['time'],
      title: data?['title'],
      favoriteEvent: data?['favoriteEvent'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "categoryId": categoryId,
      "date": date,
      "time": time,
      "title": title,
      "description": description,
      "favoriteEvent": favoriteEvent,
    };
  }

  CategoryModel get category {
    return CategoryModel.categories.firstWhere((e) => e.id == categoryId);
  }
}
