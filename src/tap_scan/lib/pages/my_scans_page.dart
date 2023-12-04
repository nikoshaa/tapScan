import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/models/ktp.dart';

class MyScansPage extends StatelessWidget {
  const MyScansPage({Key? key});

  @override
  Widget build(BuildContext context) {
    KTP ktp = KTP(
      provinsi: "PROVINSI SULAWESI SELATAN",
      kabupaten: "KABUPATEN SOPPENG",
      rtRw: "01/01",
      kelDesa: "CELLENGENGE",
      kecamatan: "BILA",
      berlakuHingga: "SEUMUR HIDUP",
      nama: "ABDURRAUF, S.Pd, M.Pd",
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

    return WillPopScope(
      onWillPop: () async {
        // Saat tombol "Back" perangkat ditekan
        // Tampilkan dialog atau lakukan sesuatu jika diperlukan
        // Gunakan SystemNavigator.pop() untuk keluar dari aplikasi
        SystemNavigator.pop();
        return true; // Setel ke false jika Anda ingin mencegah aksi kembali
      },
      child: MainLayoutPage(
        widget: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            KtpCard(
              ktp: ktp,
            ),
            const SizedBox(
              height: 20,
            ),
            KtpCard(
              ktp: ktp,
            ),
            const SizedBox(
              height: 20,
            ),
            KtpCard(
              ktp: ktp,
            ),
          ],
        ),
        activeIndex: 0,
      ),
    );
  }
}
