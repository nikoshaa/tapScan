import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanValidate2 extends StatefulWidget {
  const ScanValidate2({Key? key}) : super(key: key);

  @override
  _ScanValidate2State createState() => _ScanValidate2State();
}

class _ScanValidate2State extends State<ScanValidate2> {
  late TextEditingController _ktpController;

  @override
  void initState() {
    super.initState();
    _ktpController = TextEditingController();
    // Set nilai awal berdasarkan data dari API Flask
    fetchKtpDataFromApi();
  }

  Future<void> fetchKtpDataFromApi() async {
    try {
      final apiUrl = 'https://sjqq06bn-5006.asse.devtunnels.ms/get/ktp'; // Ganti URL API Flask Anda
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          // Set nilai awal controller berdasarkan data dari API
          _ktpController.text = data['detected_word'];
        });
      } else {
        // Handle error
        print('Failed to fetch data from API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  Future<void> updateFirestoreData() async {
    try {
      final userUid = 'userUid'; // Ganti dengan cara Anda mendapatkan UID pengguna
      final ktpId = _ktpController.text;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('ktps')
          .doc(ktpId)
          .update({
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
        title: Text('Scan Validate'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
                    builder: (context) => ScanResult(ktpId: _ktpController.text),
                  ),
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanResult extends StatelessWidget {
  final String ktpId;

  const ScanResult({Key? key, required this.ktpId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: Center(
        child: Text('KTP ID: $ktpId'),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: ScanValidate2(),
    ),
  );
}
