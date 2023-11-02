import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/scan_validate.dart';

class ProgressDone extends StatelessWidget {
  const ProgressDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 198, 232, 1),
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        const MainProcessIndicator(percent: 1),
        const SizedBox(
          height: 30,
        ),
        MainButton(
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScanValidate(),
              ),
            );
          },
          buttonText: "See Result",
          iconData: Icons.arrow_forward_sharp,
        )
      ]),
    );
  }
}
