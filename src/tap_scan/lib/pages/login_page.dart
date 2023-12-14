import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  bool isHovered = false;

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 198, 232, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Material(
            // color: const Color.fromRGBO(0, 198, 232, 1),
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

                        print(user);

                        if (user == null) {
                          // User is not logged in, show login UI
                          return Column(
                            children: [
                              Container(
                                color: Colors
                                    .white, // Warna latar belakang untuk username
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              PasswordTextInput(
                                passwordController: passwordController,
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
                                function: () async {
                                  // Try signing in with Google
                                  try {
                                    print('Signing in with Google');
                                    await GoogleSignIn().signOut();
                                    final GoogleSignInAccount? googleUser =
                                        await GoogleSignIn().signIn();

                                    if (googleUser != null) {
                                      // Perform sign in with Google account
                                      final GoogleSignInAuthentication
                                          googleAuth =
                                          await googleUser.authentication;
                                      final credential =
                                          GoogleAuthProvider.credential(
                                        accessToken: googleAuth.accessToken,
                                        idToken: googleAuth.idToken,
                                      );

                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .signInWithCredential(credential);

                                      // Store additional user information in Firestore
                                      final ref = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userCredential.user!.uid);

                                      if (!(await ref.get()).exists) {
                                        ref.set({
                                          'username':
                                              userCredential.user!.displayName,
                                          'email': userCredential.user!.email,
                                          'phoneNumber': ''
                                        });
                                      }

                                      // Navigate to the home page or perform other actions after successful login
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MyScansPage(),
                                        ),
                                      );
                                    } else {
                                      print('Google sign in cancelled.');
                                    }
                                  } catch (e) {
                                    print('Error signing in with Google: $e');
                                  }
                                },
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
                                    MouseRegion(
                                      onEnter: (_) {
                                        // Ubah warna teks menjadi oranye
                                        setState(() {
                                          isHovered = true;
                                        });
                                      },
                                      onExit: (_) {
                                        // Kembalikan warna teks ke warna semula
                                        setState(() {
                                          isHovered = false;
                                        });
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          // Aksi yang diambil saat teks diklik
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Create Account",
                                          style: TextStyle(
                                            color: isHovered
                                                ? Colors.orange
                                                : Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        return Container(
                          color: const Color.fromRGBO(0, 198, 232, 1),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        );
                        // else {
                        //   // User is logged in, navigate to another page or show different UI
                        //   return MyScansPage(); // Adjust accordingly
                        // }
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
        ),
      ),
    );
  }
}

class PasswordTextInput extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordTextInput({super.key, required this.passwordController});

  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool _isSecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Warna latar belakang untuk password
      child: TextFormField(
        obscureText: _isSecurePassword,
        controller: widget.passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: togglePassword(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSecurePassword = !_isSecurePassword;
          });
        },
        icon: _isSecurePassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }
}
