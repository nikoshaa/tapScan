import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/scan_result.dart';
import 'package:tap_scan/providers/ktp_provider.dart';
import 'package:http/http.dart' as http;

class ScanValidate extends StatelessWidget {
  const ScanValidate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context, listen: false);
    final TextEditingController nikController =
        TextEditingController(text: ktpProvider.ktpScan?.nik ?? '');
    final TextEditingController namaController =
        TextEditingController(text: ktpProvider.ktpScan?.nama ?? '');
    final TextEditingController tempatTanggalLahirController =
        TextEditingController(
            text: ktpProvider.ktpScan?.tempatTanggalLahir ?? '');
    final TextEditingController jenisKelaminController =
        TextEditingController(text: ktpProvider.ktpScan?.jenisKelamin ?? '');
    final TextEditingController alamatController =
        TextEditingController(text: ktpProvider.ktpScan?.alamat ?? '');

    goToMain() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
    }

    Future<Map<String, dynamic>> fetchDataFromApi() async {
    // Ganti dengan implementasi sesuai kebutuhan untuk mengambil data dari API
    // Misalnya, Anda bisa menggunakan http package untuk mengirim GET request ke API
    final apiUrl = 'https://9452-114-6-31-174.ngrok-free.app/get/ktp'; // Ganti dengan URL API yang sesuai
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

    return FutureBuilder<Map<String, dynamic>>(
      future: fetchDataFromApi(), // Ganti 'your_document_id' dengan ID dokumen Firestore yang sesuai
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Text('No data available');
          }

          final Map<String, dynamic> data = snapshot.data!;

          String concatenatedData = "";
          for (int i = 0; i < data.length; i += 2) {
            concatenatedData += "${data[i]}: ${data[i + 1]}\n";
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
                      child: Image.network(data[
                          'foto']), // Ganti dengan properti yang sesuai di Firestore
                    )
                  : Image.network(data[
                      'foto']), // Ganti dengan properti yang sesuai di Firestore
              const SizedBox(
                height: 20,
              ),
              TextValidate(
                text:
                    "NIK: ${data['nik']}", // Ganti dengan properti yang sesuai di Firestore
              ),
              const SizedBox(
                height: 20,
              ),
              TextValidate(
                text:
                    "Nama: ${data['nama']}", // Ganti dengan properti yang sesuai di Firestore
              ),
              const SizedBox(
                height: 20,
              ),
              TextValidate(
                text:
                    "Tempat/Tanggal Lahir: ${data['tempatTanggalLahir']}", // Ganti dengan properti yang sesuai di Firestore
              ),
              const SizedBox(
                height: 20,
              ),
              TextValidate(
                text:
                    "Jenis Kelamin: ${data['jenisKelamin']}", // Ganti dengan properti yang sesuai di Firestore
              ),
              const SizedBox(
                height: 20,
              ),
              TextValidate(
                text:
                    "Alamat: ${data['alamat']}", // Ganti dengan properti yang sesuai di Firestore
              ),
              const SizedBox(
                height: 20,
              ),
              // TextFields for updating data
              TextField(
                controller: nikController,
                decoration: const InputDecoration(labelText: 'NIK'),
              ),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: tempatTanggalLahirController,
                decoration:
                    const InputDecoration(labelText: 'Tempat/Tanggal Lahir'),
              ),
              TextField(
                controller: jenisKelaminController,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(
                height: 20,
              ),
              MainButton(
                function: () async {
                  // Simpan perubahan ke Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('ktps')
                      .doc(nikController.text)
                      .set({
                    'nik': nikController.text,
                    'nama': namaController.text,
                    'tempatTanggalLahir': tempatTanggalLahirController.text,
                    'jenisKelamin': jenisKelaminController.text,
                    'alamat': alamatController.text,
                  });

                  // Pindah ke halaman ScanResult
                  if (context.mounted)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScanResult(ktpId: nikController.text!)),
                    );
                },
                buttonText: "Submit",
              )
            ],
          ),
          cleanLayout: true,
          title: "Verification Validate",
        );
      },
    );
  }
}

class TextValidate extends StatelessWidget {
  final String text;
  const TextValidate({
    Key? key,
    required this.text,
  }) : super(key: key);

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
