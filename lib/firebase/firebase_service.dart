import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    await userData.user?.sendEmailVerification();
    return userData;
  }

  Future<void> userLogout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    var userData = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userData.user?.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await FirebaseAuth.instance.signOut();
      throw FirebaseAuthException(
        code: 'email-not-verified',
        message: 'Please verify your email before logging in.',
      );
    }

    return userData;
  }

  bool isLoggedIn() {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> forgetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //69941563771-9e11vl0kkhu60abm7vl9tpn1ls6nrbkq.apps.googleusercontent.com
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final userCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(userCredential);
  }

  // Future<String?> uploadProfileImage(File imageFile) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     final storageRef = FirebaseStorage.instance.ref().child(
  //       'profile_pics/${user!.uid}.jpg',
  //     );

  //     await storageRef.putFile(imageFile);

  //     String downloadURL = await storageRef.getDownloadURL();
  //     return downloadURL;
  //   } catch (e) {
  //     log('Error uploading image: $e');
  //     return null;
  //   }
  // }
}
