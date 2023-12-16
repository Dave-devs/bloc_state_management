import 'package:bloc_state_management/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthProvider{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInUser({required String email, required String password}) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if(user != null) {
        return;
      }

      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future signUpUser({
    required String name,
    required String email,
    required String password,
    required String password2,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      final User? user = credential.user;
      if(user != null) {
        return UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
    return null;
  }

  Future<void> signOutUser() async {
    final User? user = _firebaseAuth.currentUser;
    if(user != null) {
      await _firebaseAuth.signOut();
    }
  }

  Future<bool> isSignedIn() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<String> getUser() async {
    return _firebaseAuth.currentUser!.email ?? '';
  }
}