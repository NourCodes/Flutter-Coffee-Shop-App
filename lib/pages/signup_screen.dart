import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/bk.jpg",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Image.asset(
                "images/logo.png",
                height: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an Account?"),
                TextButton(
                  child: const Text(
                    "Login.",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
