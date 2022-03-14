import 'package:firebase_auth/firebase_auth.dart';

// This class will help in firebase authentication tasks.

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        UserCredential? _userCredential = await _createUserWithEmailAndPassword(
                email: email, password: password)
            .onError((error, stackTrace) => throw (error.toString()));
        print(_userCredential);
        return _userCredential;
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw ('Invalid email provided for that user.');
      } else {
        rethrow;
      }
    }
  }

  Future<UserCredential?> _createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
