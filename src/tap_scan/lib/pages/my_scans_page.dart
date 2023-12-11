// File: pages/my_scans_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/models/ktp.dart';
import 'package:tap_scan/pages/scan_result.dart';
import 'package:tap_scan/providers/ktp_provider.dart';

class MyScansPage extends StatelessWidget {
  const MyScansPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final ktpProvider = Provider.of<KtpProvider>(context);
    User? currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder(
      future:
          ktpProvider.fetchKtps(currentUser!.uid), // Ganti dengan user_id yang sesuai
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
            child: MainLayoutPage(
              widget: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Menampilkan daftar KTP dari provider
                  for (var ktp in ktpProvider.ktps)
                    Column(
                      children: [
                        KtpCard(
                          ktp: ktp,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            // Ambil ktpId dari item yang diklik dan lanjutkan ke ScanResult
                            final ktpId =
                                "contohKtpId"; // Ganti dengan nilai yang sesuai
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ScanResult(ktpId: ktpId),
                              ),
                            );
                          },
                          child: KtpCard(
                            ktp: ktp,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              activeIndex: 0,
            ),
          );
        }
      },
    );
  }
}
