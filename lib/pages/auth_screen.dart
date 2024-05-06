import 'package:coffee_shop_app/pages/signup_screen.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // stores the current user
  User? currentUser = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    // if a user is logged in, navigate to HomeScreen
    if (currentUser != null) {
      return const HomeScreen();
    } else {
      // otherwise, show the SignupScreen for user registration
      return const SignupScreen();
    }
  }
}
