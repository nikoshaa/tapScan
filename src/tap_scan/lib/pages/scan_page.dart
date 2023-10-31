import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutPage(
      description:
          "Point the camera at the ID card you want to verify Make sure the image is clear",
      title: "Verification",
      widget: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 200,
                width: 300,
                child: kIsWeb
                    ? Image.asset(
                        "images/ktp-foto.png",
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        "assets/images/ktp-foto.png",
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MainButton(
              function: () {},
              buttonText: "Verification",
            ),
            const SizedBox(
              height: 30,
            ),
            const SecondaryButton()
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set the width
      height: 40, // Set the height
      child: OutlinedButton(
        onPressed: () {
          // Add your button's onPressed action here
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(0, 198, 232, 1),
          side: const BorderSide(
            width: 2,
            color: Color.fromRGBO(0, 198, 232, 1),
          ), // Border width and color
          backgroundColor: Colors.transparent, // Transparent background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Border radius
          ),
        ),
        child: const Text('Uplaod Image'),
      ),
    );
  }
}
