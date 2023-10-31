import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class MyScansPage extends StatelessWidget {
  const MyScansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayoutPage(
      widget: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          KtpCard(),
          SizedBox(
            height: 20,
          ),
          KtpCard(),
          SizedBox(
            height: 20,
          ),
          KtpCard(),
        ],
      ),
      activeIndex: 0,
    );
  }
}
