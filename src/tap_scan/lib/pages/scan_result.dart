import 'package:flutter/material.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutPage(
      widget: Container(
        child: const Column(
          children: [],
        ),
      ),
      title: "Scan Result",
    );
  }
}
