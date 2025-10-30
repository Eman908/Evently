import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String id;
  String email;

  UserModel({required this.email, required this.id, required this.name});
  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return UserModel(
      email: data?['email'],
      id: data?['id'],
      name: data?['name'],
    );
  }
  Map<String, dynamic> toFireStore() {
    return {'name': name, 'id': id, 'email': email};
  }
}
