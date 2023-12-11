import 'package:cloud_firestore/cloud_firestore.dart';

class KTP {
  String? provinsi;
  String? kabupaten;
  String? rtRw;
  String? kelDesa;
  String? kecamatan;
  String? berlakuHingga;
  String? nama;
  String? tempatTanggalLahir;
  String? jenisKelamin;
  String? agama;
  String? alamat;
  String? kewarganegaraan;
  String? pekerjaan;
  String? golonganDarah;
  String? statusPerkawinan;
  String? nik;
  String? foto;

  KTP({
    required this.provinsi,
    required this.kabupaten,
    required this.rtRw,
    required this.kelDesa,
    required this.kecamatan,
    required this.berlakuHingga,
    required this.nama,
    required this.tempatTanggalLahir,
    required this.jenisKelamin,
    required this.agama,
    required this.alamat,
    required this.kewarganegaraan,
    required this.pekerjaan,
    required this.golonganDarah,
    required this.statusPerkawinan,
    required this.nik,
    required this.foto,
  });

  factory KTP.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return KTP(
      provinsi: data['provinsi'],
      kabupaten: data['kabupaten'],
      rtRw: data['rtRw'],
      kelDesa: data['kelDesa'],
      kecamatan: data['kecamatan'],
      berlakuHingga: data['berlakuHingga'],
      nama: data['nama'],
      tempatTanggalLahir: data['tempatTanggalLahir'],
      jenisKelamin: data['jenisKelamin'],
      agama: data['agama'],
      alamat: data['alamat'],
      kewarganegaraan: data['kewarganegaraan'],
      pekerjaan: data['pekerjaan'],
      golonganDarah: data['golonganDarah'],
      statusPerkawinan: data['statusPerkawinan'],
      nik: data['nik'],
      foto: data['foto'],
    );
  }
}
