import 'package:flutter/widgets.dart';
import 'package:tap_scan/models/ktp.dart';

class KtpProvider extends ChangeNotifier {
  KTP ktpScan = KTP(
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

  void UpdateKTP(KTP ktp) {
    ktpScan = ktp;
    notifyListeners();
  }
}
