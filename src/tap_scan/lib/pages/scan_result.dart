import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/models/ktp.dart';
import 'package:tap_scan/providers/ktp_provider.dart';

class ScanResult extends StatefulWidget {
  final String ktpId;

  const ScanResult({Key? key, required this.ktpId}) : super(key: key);

  @override
  _ScanResultState createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  @override
  void initState() {
    super.initState();
    // Ambil data KTP dari Firestore saat widget diinisialisasi
    final ktpProvider = Provider.of<KtpProvider>(context, listen: false);
    ktpProvider.fetchKtp('userId', widget.ktpId);
  }

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context, listen: false);

    return MainLayoutPage(
      useFixedBottomBar: true,
      widget: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            KtpData(label: "NIK", text: ktpProvider.ktpScan?.nik ?? ""),
            KtpData(label: "Nama", text: ktpProvider.ktpScan?.nama ?? ""),
            KtpData(
              label: "Tempat/Tgl Lahir",
              text: ktpProvider.ktpScan?.tempatTanggalLahir ?? "",
            ),
            KtpData(
              label: "Jenis Kelamin",
              text: ktpProvider.ktpScan?.jenisKelamin ?? "",
            ),
            KtpData(label: "RT/RW", text: ktpProvider.ktpScan?.rtRw ?? ""),
            KtpData(
                label: "Kel/Desa", text: ktpProvider.ktpScan?.kelDesa ?? ""),
            KtpData(
                label: "Kecamatan", text: ktpProvider.ktpScan?.kecamatan ?? ""),
            KtpData(label: "Agama", text: ktpProvider.ktpScan?.agama ?? ""),
            KtpData(
              label: "Status Perkawinan",
              text: ktpProvider.ktpScan?.statusPerkawinan ?? "",
            ),
            KtpData(
                label: "Pekerjaan", text: ktpProvider.ktpScan?.pekerjaan ?? ""),
            KtpData(
              label: "Kewarganegaraan",
              text: ktpProvider.ktpScan?.kewarganegaraan ?? "",
            ),
            KtpData(
              label: "Berlaku Hingga",
              text: ktpProvider.ktpScan?.berlakuHingga ?? "",
            ),
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              ktpProvider.ktpScan?.kabupaten ??
                  "", // Ganti dengan properti yang sesuai
              style: const TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
              ),
            ),
            // Text(
            //   ktpProvider.ktpScan?.tanggalScan ?? "", // Ganti dengan properti yang sesuai
            //   style: TextStyle(
            //     color: Color.fromRGBO(0, 198, 232, 1),
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}

class KtpData extends StatelessWidget {
  final String label;
  final String text;

  const KtpData({Key? key, required this.label, required this.text})
      : super(key: key);

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
