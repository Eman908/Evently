import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase/event_data_base.dart';
import 'package:evently/views/auth/models/user_model.dart';

class UserDatabase {
  static CollectionReference<UserModel> getUserCollection() {
    return EventDataBase.firestore
        .collection('Users')
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(UserModel user) {
    return getUserCollection().doc(user.id).set(user);
  }
}
