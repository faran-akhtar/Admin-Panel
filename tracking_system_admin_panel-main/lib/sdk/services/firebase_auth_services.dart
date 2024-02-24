import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp({required String email, required String password}) async {
    String message = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          message = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
         message = 'weak-password';
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
         message = 'email-already-in-use';
        throw Exception('The account already exists for that email.');
      }
      return message;
    } catch (e) {
      throw Exception(e.toString());
    }
    return message;
  }



   Future<String> resetPassword({
    required String email,
  }) async {
    String message = '';
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      message = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'user-not-found';
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message = 'wrong-password';
        throw Exception('Wrong password provided for that user.');
      }
      return message;
    }
    return message;
  }
  

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    String message = '';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      message = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'user-not-found';
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message = 'wrong-password';
        throw Exception('Wrong password provided for that user.');
      }
      return message;
    }
    return message;
  }
 

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}