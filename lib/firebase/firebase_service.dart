import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  Future<UserCredential> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userData.user?.updateDisplayName(name);
    return userData;
  }

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    var userData = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userData;
  }

  bool isLoggedIn() {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> forgetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
