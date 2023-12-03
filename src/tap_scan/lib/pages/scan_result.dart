import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/models/ktp.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/providers/ktp_provider.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key});

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context);

    final KTP ktpInitExample = KTP(
      provinsi: "PROVINSI SULAWESI SELATAN",
      kabupaten: "KABUPATEN SOPPENG",
      rtRw: "01/01",
      kelDesa: "CELLENGENGE",
      kecamatan: "BILA",
      berlakuHingga: "SEUMUR HIDUP",
      nama: "ABDURRUSDI, S.Pd, M.Pd",
      tempatTanggalLahir: "CELLENGENGE, 25-10-1972",
      jenisKelamin: "LAKI-LAKI",
      agama: "ISLAM",
      alamat: "BILA",
      kewarganegaraan: "WNI",
      pekerjaan: "PEGAWAI NEGERI SIPIL (PNS)",
      golonganDarah: "O",
      statusPerkawinan: "KAWIN",
      nik: "7312042510720002",
      foto: "ktp.png",
    );

    goToMain() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
    }

    ktpProvider.UpdateKTP(ktpInitExample);

    return MainLayoutPage(
      useFixedBottomBar: true,
      leftIconFunction: goToMain,
      rightIconFunction: () {},
      widget: Container(
        child: Column(
          children: [
            const Text(
              "PROVINSI SULAWESI SELATAN",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
                fontSize: 18,
              ),
            ),
            const Text(
              "KABUPATEN SOPPENG",
              style: TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            KtpData(label: "NIK", text: ktpProvider.ktpScan.nik),
            KtpData(label: "Nama", text: ktpProvider.ktpScan.nama),
            KtpData(
                label: "Tempat/Tgl Lahir",
                text: ktpProvider.ktpScan.tempatTanggalLahir),
            KtpData(
                label: "Jenis Kelamin", text: ktpProvider.ktpScan.jenisKelamin),
            KtpData(label: "RT/RW", text: ktpProvider.ktpScan.rtRw),
            KtpData(label: "Kel/Desa", text: ktpProvider.ktpScan.kelDesa),
            KtpData(label: "Kecamatan", text: ktpProvider.ktpScan.kecamatan),
            KtpData(label: "Agama", text: ktpProvider.ktpScan.agama),
            KtpData(
                label: "Status Perkawinan",
                text: ktpProvider.ktpScan.statusPerkawinan),
            KtpData(label: "Pekerjaan", text: ktpProvider.ktpScan.pekerjaan),
            KtpData(
                label: "Kewarganegaraan",
                text: ktpProvider.ktpScan.kewarganegaraan),
            KtpData(
                label: "Berlaku Hingga",
                text: ktpProvider.ktpScan.berlakuHingga),
            const PlaceAndTime(),
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
