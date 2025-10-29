import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/helper_methods.dart';
import 'package:evently/views/home/models/category_model.dart';
import 'package:evently/views/management_event/models/event_model.dart';

class EventDataBase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference<EventModel> getCollectionReference() {
    return firestore
        .collection('events')
        .withConverter(
          fromFirestore: EventModel.fromFirestore,
          toFirestore: (EventModel event, options) => event.toFirestore(),
        );
  }

  Future<void> createEvent(EventModel event) async {
    var collectionReference = getCollectionReference();
    var doc = collectionReference.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  Future<List<EventModel>> getEvent(CategoryModel cM) async {
    var date = DateTime.now().dateOnly.millisecondsSinceEpoch;
    var collectionReference = getCollectionReference();
    QuerySnapshot<EventModel> data;
    // var data = await collectionReference.get();
    if (cM.id == -1) {
      data = await collectionReference.where("date", isEqualTo: date).get();
    } else {
      data =
          await collectionReference
              .where("date", isEqualTo: date)
              .where("categoryId", isEqualTo: cM.id)
              .get();
    }
    var event = data.docs.map((e) => e.data()).toList();
    return event;
  }
}
