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

class MainTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const MainTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromRGBO(0, 198, 232, 1)),
        border: InputBorder.none,
      ),
    );
  }
}

class ContinueWithGoogleButton extends StatelessWidget {
  final Function() function;
  final String text;
  const ContinueWithGoogleButton(
      {super.key, required this.function, required this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: FilledButton(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(0, 198, 232, 1),
                fontSize: 14,
              ),
            ),
            Image.asset(
              'assets/images/google-logo.png',
              width: 40,
            )
          ],
        ),
      ),
    );
  }
}

class MainDropDown extends StatefulWidget {
  final List<String> items;

  const MainDropDown({super.key, required this.items});

  @override
  State<MainDropDown> createState() => _MainDropDownState();
}

class _MainDropDownState extends State<MainDropDown> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 30,
          width: 140,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color.fromRGBO(214, 247, 253, 1),
          ),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}

class MainNavBar extends StatelessWidget {
  final int activeIndex;
  const MainNavBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    List<String> pages = ["MY SCANS", "DOCUMENTS", "PDF"];
    List<Function> goTos = [goToMyScans, goToMyDocs, goToPdf];

    double horizontalPadding = activeIndex == 1 ? 10 : 30.0;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 300,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 166, 194, 1),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: pages
              .asMap()
              .map((i, page) => MapEntry(
                  i,
                  TextButton(
                    style: i == activeIndex
                        ? ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(0, 94, 109, 1),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(
                                  right: horizontalPadding,
                                  left: horizontalPadding),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                          )
                        : const ButtonStyle(),
                    onPressed: () => goTos[i](context),
                    child: Text(
                      page,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )))
              .values
              .toList(),
        ),
      ),
    );
  }
}

goToMyScans(context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const MyScansPage(),
    ),
  );
}

goToMyDocs(context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const DocumentsPage(),
    ),
  );
}

goToPdf(context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const PdfPage(),
    ),
  );
}

class KtpCard extends StatelessWidget {
  const KtpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(0, 198, 232, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              kIsWeb ? 'images/ktp.png' : 'assets/images/ktp.png',
              height: 50,
            ),
            const Column(
              children: [
                Text("ID Card 1"),
                Icon(
                  Icons.check_box_rounded,
                  color: Color.fromRGBO(204, 255, 210, 1),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconData iconData;
  const IconCard({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(0, 198, 232, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Icon(
              iconData,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sample Document",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  "25/20/2023",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 94, 109, 1)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: const Color.fromRGBO(255, 240, 44, 1),
      onPressed: () {},
      label: const Text(''),
      icon: const Icon(Icons.camera),
      elevation: 4.0,
    );
  }
}
