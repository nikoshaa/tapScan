import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
    final ktpProvider = Provider.of<KtpProvider>(context, listen: false);
    User? currentUser = FirebaseAuth.instance.currentUser;

    // return Text("test");

    return FutureBuilder(
      future: ktpProvider
          .fetchKtps(currentUser!.uid), // Ganti dengan user_id yang sesuai
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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
                        // KtpCard(
                        //   ktp: ktp,
                        // ),
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

// class KtpCard extends StatelessWidget {
//   final KTP ktp;
//   const KtpCard({super.key, required this.ktp});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: const Color.fromRGBO(0, 198, 232, 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.network(
//               kIsWeb ? 'images/${ktp.foto}' : 'assets/images/${ktp.foto}',
//               height: 50,
//             ),
//             Column(
//               children: [
//                 Text(ktp.nama),
//                 const Icon(
//                   Icons.check_box_rounded,
//                   color: Color.fromRGBO(204, 255, 210, 1),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
