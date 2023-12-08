import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutPage(
      widget: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          IconCard(
              icon: FaIcon(
            FontAwesomeIcons.filePdf,
            color: Colors.white,
          )),
          SizedBox(
            height: 20,
          ),
          IconCard(icon: FaIcon(FontAwesomeIcons.filePdf, color: Colors.white)),
          SizedBox(
            height: 20,
          ),
          IconCard(icon: FaIcon(FontAwesomeIcons.filePdf, color: Colors.white)),
        ],
      ),
      activeIndex: 2,
    );
  }
}
