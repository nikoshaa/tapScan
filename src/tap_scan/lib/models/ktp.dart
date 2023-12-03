class KTP {
  String provinsi;
  String kabupaten;
  String nik;
  String nama;
  String tempatTanggalLahir;
  String jenisKelamin;
  String golonganDarah;
  String alamat;
  String rtRw;
  String kelDesa;
  String kecamatan;
  String agama;
  String statusPerkawinan;
  String pekerjaan;
  String kewarganegaraan;
  String berlakuHingga;
  String foto;

  KTP({
    required this.provinsi,
    required this.kabupaten,
    required this.nik,
    required this.nama,
    required this.tempatTanggalLahir,
    required this.jenisKelamin,
    required this.golonganDarah,
    required this.alamat,
    required this.rtRw,
    required this.kelDesa,
    required this.kecamatan,
    required this.agama,
    required this.statusPerkawinan,
    required this.pekerjaan,
    required this.kewarganegaraan,
    required this.berlakuHingga,
    required this.foto,
  });

  @override
  String toString() {
    return '''
  provinsi: $provinsi
  kabupaten: $kabupaten
  nik: $nik
  nama: $nama
  tempatTanggalLahir: $tempatTanggalLahir
  jenisKelamin: $jenisKelamin
  golonganDarah: $golonganDarah
  alamat: $alamat
  rtRw: $rtRw
  kelDesa: $kelDesa
  kecamatan: $kecamatan
  agama: $agama
  statusPerkawinan: $statusPerkawinan
  pekerjaan: $pekerjaan
  kewarganegaraan: $kewarganegaraan
  berlakuHingga: $berlakuHingga
  foto: $foto
    ''';
  }
}
