import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data, replace it with your actual data
    final List<Map<String, String>> documents = [
      {'title': 'Sample 1', 'date': '6/10/2023'},
      {'title': 'Sample 2', 'date': '7/10/2023'},
      {'title': 'Sample 3', 'date': '8/10/2023'},
      // Add more data as needed
    ];

    List<Widget> iconCards = documents.map((document) {
      return Column(
        children: [
          IconCard(
            icon: const FaIcon(FontAwesomeIcons.fileWord, color: Colors.white),
            title: document['title'] ?? '',
            date: document['date'] ?? '',
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
          // Use the list of IconCard widgets
          ...iconCards,
        ],
      ),
      activeIndex: 1,
    );
  }
}
