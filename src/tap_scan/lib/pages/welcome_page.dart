import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/onboard_pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OnBoardPages(),
              ),
            );
          },
          child: Container(
            color: const Color.fromRGBO(0, 198, 232, 1),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(80),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ),
                const Text(
                  "WELCOME",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Colors.white,
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Import an image to be converted",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                MainButton(
                  function: () {},
                  buttonText: "TAKE A PICTURE",
                  iconData: Icons.camera_alt_outlined,
                ),
                const SizedBox(
                  height: 20,
                ),
                MainButton(
                  function: () {},
                  buttonText: "GALLERY",
                  iconData: Icons.photo,
                  horizontalPadding: 70,
                ),
                const SizedBox(
                  height: 20,
                ),
                MainButton(
                  function: () {},
                  buttonText: "IMPORT PDF",
                  iconData: Icons.picture_as_pdf_outlined,
                  horizontalPadding: 55,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
