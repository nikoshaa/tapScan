import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _timer;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                function: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyScansPage(),
                    ),
                  );
                  EasyLoading.showProgress(0.3, status: 'login...');

                  Future.delayed(const Duration(seconds: 1), () {
                    EasyLoading.dismiss();
                  });
                },
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
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: isHovered ? Colors.orange : Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
