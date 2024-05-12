import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_shop_app/utilities/methods.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  // sign-up method
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = result.user;
      return user;
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
  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = result.user;
      return user;
    } catch (e) {
      // show error message if login fails
      Methods().showMessage(
        e.toString(),
      );
      return null;
    }
  }
}
