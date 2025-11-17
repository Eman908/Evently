import 'package:evently/views/auth/models/user_model.dart';
import 'package:flutter/material.dart';

class NewUser extends ChangeNotifier {
  UserModel? user;
  updateUser(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}
