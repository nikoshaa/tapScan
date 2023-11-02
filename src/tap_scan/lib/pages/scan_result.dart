import 'package:flutter/material.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key});

  @override
  Widget build(BuildContext context) {
    goToMain() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
    }

    return MainLayoutPage(
      useFixedBottomBar: true,
      leftIconFunction: goToMain,
      widget: Container(
        child: const Column(
          children: [
            Text(
              "PROVINSI SULAWESI SELATAN",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
                fontSize: 18,
              ),
            ),
            Text(
              "KABUPATEN SOPPENG",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            KtpData(label: "NIK", text: "7312042510720002"),
            KtpData(label: "Nama", text: "ABDURRAUF, S.Pd, M.Pd"),
            KtpData(label: "Tempat/Tgl Lahir", text: "CELLENGENGE, 25-10-1972"),
            KtpData(label: "Jenis Kelamin", text: "LAKI-LAKI"),
            KtpData(label: "RT/RW", text: "001/004"),
            KtpData(label: "Kel/Desa", text: "BILA"),
            KtpData(label: "Kecamatan", text: "LALABATA"),
            KtpData(label: "Agama", text: "ISLAM"),
            KtpData(label: "Status Perkawinan", text: "KAWIN"),
            KtpData(label: "Pekerjaan", text: "PEGAWAI NEGERI SIPIL (PNS)"),
            KtpData(label: "Kewarganegaraan", text: "WNI"),
            KtpData(label: "Berlaku Hingga", text: "SEUMUR HIDUP"),
            PlaceAndTime(),
          ],
        ),
      ),
      cleanLayout: true,
      leftIcon: Icons.arrow_back,
      rightIcon: Icons.more_horiz,
      title: "Scan Result",
      whiteBoxTopPadding: 10,
    );
  }
}

class PlaceAndTime extends StatelessWidget {
  const PlaceAndTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              "SOPPENG",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
            Text(
              "30-03-2021",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class KtpData extends StatelessWidget {
  final String label;
  final String text;
  const KtpData({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
          ),
          const Expanded(
            flex: 0,
            child: Text(
              ":",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
          ),
          const Expanded(
            flex: 0,
            child: Text("   "),
          ),
          Expanded(
            flex: 6,
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
