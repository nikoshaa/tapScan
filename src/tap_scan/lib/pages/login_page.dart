import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _timer;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to the home page or perform other actions after login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login errors, e.g., display an error message
      print('Login failed: ${e.message}');
      EasyLoading.showError('Login failed: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: const Color.fromRGBO(0, 198, 232, 1),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(60),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                ),
              ),
              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    User? user = snapshot.data;

                    if (user == null) {
                      // User is not logged in, show login UI
                      return Column(
                        children: [
                          MainTextField(
                            hintText: "Username",
                            controller: usernameController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MainTextField(
                            hintText: "Password",
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MainButton(
                            function: _login,
                            buttonText: "Login",
                            horizontalPadding: 80,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Or",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ContinueWithGoogleButton(
                            function: () {},
                            text: "Continue With Google",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  "No account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      // User is logged in, navigate to another page or show different UI
                      return MyScansPage(); // Adjust accordingly
                    }
                  } else {
                    // Show a loading indicator or placeholder UI while checking authentication state
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
