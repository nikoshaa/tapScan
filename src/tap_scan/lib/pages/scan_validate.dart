import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/scan_result.dart';
import 'package:tap_scan/providers/ktp_provider.dart';

class ScanValidate extends StatelessWidget {
  const ScanValidate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context);
    goToMain() {
      Navigator.of(context).push(
        PageTransition(
            child: const MyScansPage(),
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this),
      );
    }

    return MainLayoutPage(
      whiteBoxTopPadding: 0,
      leftIcon: Icons.arrow_back,
      rightIcon: Icons.more_horiz,
      leftIconFunction: goToMain,
      widget: Column(
        children: [
          kIsWeb
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("images/${ktpProvider.ktpScan.foto}"),
                )
              : Image.asset("assets/images/${ktpProvider.ktpScan.foto}"),
          const SizedBox(
            height: 20,
          ),
          TextValidate(
            text: ktpProvider.ktpScan.nik,
          ),
          const SizedBox(
            height: 20,
          ),
          TextValidate(
            text: ktpProvider.ktpScan.nama,
          ),
          const SizedBox(
            height: 20,
          ),
          TextValidate(
            text: ktpProvider.ktpScan.tempatTanggalLahir,
          ),
          const SizedBox(
            height: 20,
          ),
          TextValidate(
            text: ktpProvider.ktpScan.jenisKelamin,
          ),
          const SizedBox(
            height: 20,
          ),
          TextValidate(
            text: ktpProvider.ktpScan.alamat,
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanResult(),
                ),
              );
            },
            buttonText: "Submit",
          )
        ],
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
