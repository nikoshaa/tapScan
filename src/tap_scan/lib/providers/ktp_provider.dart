import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tap_scan/models/ktp.dart';

class KtpProvider extends ChangeNotifier {
  List<KTP> ktps = [];
  KTP? ktpScan;

  Future<void> fetchKtps(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('ktps')
          .get();

      ktps = snapshot.docs.map((doc) => KTP.fromFirestore(doc)).toList();

      print(ktps);
      notifyListeners();
    } catch (error) {
      print(error);
      print('Error fetching gest KTPs: $error');
    }
  }

  Future<void> fetchKtp(String userId, String ktpId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('ktps')
          .doc(ktpId)
          .get();

      ktpScan = KTP.fromFirestore(snapshot);
      notifyListeners();
    } catch (error) {
      print('Error fetching KTP: $error');
    }
  }
}
