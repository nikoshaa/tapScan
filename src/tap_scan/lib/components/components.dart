import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tap_scan/pages/documents_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/pdf_page.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Function() function;
  final double horizontalPadding;
  final IconData? iconData;
  const MainButton({
    super.key,
    this.buttonText = "Button Text",
    required this.function,
    this.horizontalPadding = 40.0,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return FilledButton.icon(
        icon: Icon(iconData),
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 240, 44, 1)),
        ),
        label: Padding(
          padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: 12,
              bottom: 12),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    } else {
      return FilledButton(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 240, 44, 1)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: 12,
            bottom: 12,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
  }
}
