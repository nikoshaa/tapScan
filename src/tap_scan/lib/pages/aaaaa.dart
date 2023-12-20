import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:tap_scan/components/components.dart';

class ScanValidate2 extends StatefulWidget {
  final List<String> ktpInner;
  const ScanValidate2({super.key, required this.ktpInner});

  @override
  _ScanValidate2State createState() => _ScanValidate2State();
}

class _ScanValidate2State extends State<ScanValidate2> {
  late TextEditingController _ktpController;

  @override
  void dispose() {
    _ktpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    String text = "";
    for (var element in widget.ktpInner) {
      text += element;
    }
    super.initState();
    _ktpController = TextEditingController(text: text ?? '');
    // Set nilai awal berdasarkan data dari API Flask
    // fetchKtpDataFromApi();

    // // dummy data untuk data ktp
    // List<String> dummyData = [
    //   "nik",
    //   "2141720117",
    //   "nama",
    //   "Ziedny",
    //   "tempatTanggalLahir",
    //   "11-06-2003",
    //   "jenisKelamin",
    //   "laki-laki",
    //   "alamat",
    //   "JL.alamat"
    // ];

    // // Concatenate the list elements into one string with "\n" as the separator
    // // setState(() {
    // _ktpController.text = widget.ktpInner;
    // });
  }

  Future<void> fetchKtpDataFromApi() async {
    try {
      const apiUrl =
          'https://sjqq06bn-5006.asse.devtunnels.ms/get/ktp'; // Ganti URL API Flask Anda
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          // Set nilai awal controller berdasarkan data dari API
          _ktpController.text = data['detected_word'];
        });
      } else {
        // Handle error
        print(
            'Failed to fetch data from API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  Future<void> updateFirestoreData() async {
    try {
      final userUid = FirebaseAuth.instance
          .currentUser; // Ganti dengan cara Anda mendapatkan UID pengguna

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid as String?)
          .collection('ktps')
          .doc('nik')
          .set({
        'nik': _ktpController.text,
        'nama': _ktpController.text,
        'tempatTanggalLahir': _ktpController.text,
        'jenisKelamin': _ktpController.text,
        'alamat': _ktpController.text,
      });

      print('Data updated successfully in Firestore.');
    } catch (error) {
      // Handle error
      print('Failed to update data in Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Validate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ... (widget lain tetap sama) ...

            // Satu TextField untuk mengganti nilai
            TextField(
              controller: _ktpController,
              decoration: const InputDecoration(labelText: 'NIK'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // Simpan perubahan ke Firestore
                await updateFirestoreData();

                // Pindah ke halaman ScanResult
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScanResult(ktpInner: _ktpController.text),
                  ),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanResult extends StatelessWidget {
  final String ktpInner;

  const ScanResult({Key? key, required this.ktpInner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('KTP ID: $ktpInner'),
            MainButton(
                function: () => generatePdf(), buttonText: "Generate PDF"),
          ],
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(ktpInner),
        ),
      ),
    );

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: ScanValidate2(
        ktpInner: [],
      ),
    ),
  );
}
