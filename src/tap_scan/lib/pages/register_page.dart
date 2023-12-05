import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmationController =
        TextEditingController();
    return SafeArea(
      child: Material(
        child: Container(
          color: const Color.fromRGBO(0, 198, 232, 1),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              MainTextField(
                hintText: "Username",
                controller: usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextField(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextField(
                hintText: "Phone Number",
                controller: phoneNumberController,
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextField(
                hintText: "Password",
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextField(
                hintText: "Password Confirmation",
                controller: passwordConfirmationController,
              ),
              const SizedBox(
                height: 40,
              ),
              MainButton(
                function: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    // Store additional user information in Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                      'username': usernameController.text.trim(),
                      'email': emailController.text.trim(),
                      'phoneNumber': phoneNumberController.text.trim(),
                    });

                    await FirebaseAuth.instance.signOut();

                    // Navigate to the login page after successful registration
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  } catch (e) {
                    print('Registration failed: $e');
                  }
                },
                buttonText: "Register",
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
                text: "Register With Google",
              ),
              const ToLogin()
            ],
          ),
        ),
      ),
    );
  }
}

class ToLogin extends StatefulWidget {
  const ToLogin({
    super.key,
  });

  @override
  State<ToLogin> createState() => _ToLoginState();
}

class _ToLoginState extends State<ToLogin> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Already have an account?",
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
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: isHovered ? Colors.orange : Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});

//   @override
  
// }
