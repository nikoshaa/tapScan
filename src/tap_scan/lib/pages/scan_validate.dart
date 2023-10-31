import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class ScanValidate extends StatelessWidget {
  const ScanValidate({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutPage(
      widget: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              kIsWeb
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("images/ktp.png"),
                    )
                  : Image.asset("assets/images/ktp.png"),
              const SizedBox(
                height: 20,
              ),
              const TextValidate(
                text: "7312042510720002",
              ),
              const SizedBox(
                height: 20,
              ),
              const TextValidate(
                text: "7312042510720002",
              ),
              const SizedBox(
                height: 20,
              ),
              const TextValidate(
                text: "7312042510720002",
              ),
              const SizedBox(
                height: 20,
              ),
              const TextValidate(
                text: "7312042510720002",
              ),
              const SizedBox(
                height: 20,
              ),
              MainButton(
                function: () {},
                buttonText: "Submit",
              )
            ],
          ),
        ),
      ),
      cleanLayout: true,
      title: "Verification Validate",
    );
  }
}

class TextValidate extends StatelessWidget {
  final String text;
  const TextValidate({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: const Color.fromRGBO(0, 198, 232, 1),
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
