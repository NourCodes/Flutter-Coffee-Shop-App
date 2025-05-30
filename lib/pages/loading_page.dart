import 'dart:async';
import 'package:coffee_shop_app/pages/auth_screen.dart';
import 'package:coffee_shop_app/pages/signup_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 10000), () {});

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/background.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            color: Colors.white10,
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  "images/intro_c.gif",
                  width: 100,
                  height: 180,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Coffee Makes Everything Better",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.white12,
                        blurRadius: 6,
                      ),
                      Shadow(
                        color: Colors.deepOrangeAccent,
                        blurRadius: 6,
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
