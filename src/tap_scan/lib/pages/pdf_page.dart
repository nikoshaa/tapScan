import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data, replace it with your actual data
    final List<Map<String, String>> pdfs = [
      {'title': 'Sample 1', 'date': '8/10/2023'},
      {'title': 'Sample 2', 'date': '9/10/2023'},
      {'title': 'Sample 3', 'date': '10/10/2023'},
      // Add more data as needed
    ];

    List<Widget> pdfCards = pdfs.map((pdf) {
      return Column(
        children: [
          IconCard(
            icon: const FaIcon(FontAwesomeIcons.filePdf, color: Colors.white),
            title: pdf['title'] ?? '',
            date: pdf['date'] ?? '',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }).toList();

    return MainLayoutPage(
      widget: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // Use the list of IconCard widgets for PDFs
          ...pdfCards,
        ],
      ),
      activeIndex: 2,
    );
  }
}
