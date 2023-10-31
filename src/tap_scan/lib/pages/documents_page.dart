import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayoutPage(
      widget: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          IconCard(iconData: Icons.document_scanner),
          SizedBox(
            height: 20,
          ),
          IconCard(iconData: Icons.document_scanner),
          SizedBox(
            height: 20,
          ),
          IconCard(iconData: Icons.document_scanner),
        ],
      ),
      activeIndex: 1,
    );
  }
}
