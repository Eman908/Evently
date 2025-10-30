import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/helper_methods.dart';
import 'package:evently/views/auth/models/user_database.dart';
import 'package:evently/views/home/models/category_model.dart';
import 'package:evently/views/management_event/models/event_model.dart';

class EventDataBase {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference<EventModel> getCollectionReference(String uId) {
    return UserDatabase.getUserCollection()
        .doc(uId)
        .collection('events')
        .withConverter(
          fromFirestore: EventModel.fromFirestore,
          toFirestore: (EventModel event, options) => event.toFirestore(),
        );
  }

  Future<void> createEvent(EventModel event, String uId) async {
    var collectionReference = getCollectionReference(uId);
    var doc = collectionReference.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  Future<List<EventModel>> getEvent(CategoryModel cM, String uId) async {
    var date = DateTime.now().dateOnly.millisecondsSinceEpoch;
    var collectionReference = getCollectionReference(uId);
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

  Stream<QuerySnapshot<EventModel>> getEventStream(
    CategoryModel cM,
    String uId,
  ) {
    //var date = DateTime.now().dateOnly.millisecondsSinceEpoch;
    var collectionReference = getCollectionReference(uId);
    Stream<QuerySnapshot<EventModel>> data;
    if (cM.id == -1) {
      data = collectionReference.orderBy("date").snapshots();
    } else {
      data =
          collectionReference.where("categoryId", isEqualTo: cM.id).snapshots();
    }
    return data;
  }

  Future<void> updateFavorite(String uId, EventModel event) {
    var collectionReference = getCollectionReference(uId);
    return collectionReference.doc(event.id).update({
      'favoriteEvent': !event.favoriteEvent,
    });
  }

  Stream<QuerySnapshot<EventModel>> getFavoriteList(String uId) {
    var collectionReference = getCollectionReference(uId);
    Stream<QuerySnapshot<EventModel>> data;
    data =
        collectionReference
            .orderBy("date")
            .where("favoriteEvent", isEqualTo: true)
            .snapshots();
    return data;
  }

  Future<void> deleteEvent(String uId, EventModel event) async {
    var collectionReference = getCollectionReference(uId);
    return collectionReference.doc(event.id).delete();
  }
}
