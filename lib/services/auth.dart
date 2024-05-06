import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_shop_app/utilities.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  // sign-up method
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result;
    } catch (e) {
      // show error message if sign-up fails
      Methods().showMessage(
        e.toString(),
      );
      return null;
    }
  }

  // method that gets the currently signed-in user
  User? get currentUser {
    return _auth.currentUser;
  }

  // login method
  Future<UserCredential?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result;
    } catch (e) {
      // show error message if login fails
      Methods().showMessage(
        e.toString(),
      );
      return null;
    }
  }
}
