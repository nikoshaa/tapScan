import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';

class MainLayoutPage extends StatelessWidget {
  final Widget widget;
  final String title;
  final String description;
  final int activeIndex;
  final bool cleanLayout;
  final double whiteBoxTopPadding;
  final IconData leftIcon;
  final IconData rightIcon;
  final bool useFixedBottomBar;
  final Function() leftIconFunction;
  final Function() rightIconFunction;

  const MainLayoutPage({
    super.key,
    required this.widget,
    this.activeIndex = 0,
    this.cleanLayout = false,
    this.title = "My Scans",
    this.description = "",
    this.whiteBoxTopPadding = 100,
    this.leftIcon = Icons.search,
    this.rightIcon = Icons.settings,
    this.useFixedBottomBar = false,
    this.leftIconFunction = defaultFunction,
    this.rightIconFunction = defaultFunction,
  });

  static void defaultFunction() {}

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              //background
              const MainBackGround(),
              //white box
              WhiteBox(
                mediaQueryData: mediaQueryData,
                widget: widget,
                whiteBoxTopPadding: whiteBoxTopPadding,
                title: title,
                description: description,
                leftIcon: leftIcon,
                rightIcon: rightIcon,
                leftIconFunction: leftIconFunction,
                rightIconFunction: rightIconFunction,
              ),
              Container(
                padding: const EdgeInsets.only(top: 70),
                alignment: Alignment.topCenter,
                child: cleanLayout
                    ? Container()
                    : MainNavBar(activeIndex: activeIndex),
              ),
              useFixedBottomBar ? const FixedBottomBar() : Container()
            ],
          ),
          floatingActionButton:
              cleanLayout ? Container() : const MainFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: cleanLayout
              ? const EmptyBottomNavBar()
              : const MainBottomNavBar()),
    );
  }
}

class WhiteBox extends StatelessWidget {
  const WhiteBox({
    super.key,
    required this.mediaQueryData,
    required this.widget,
    this.cleanLayout = true,
    required this.whiteBoxTopPadding,
    required this.description,
    required this.title,
    required this.leftIcon,
    required this.rightIcon,
    required this.rightIconFunction,
    required this.leftIconFunction,
  });

  final MediaQueryData mediaQueryData;
  final Widget widget;
  final bool cleanLayout;
  final double whiteBoxTopPadding;
  final String title;
  final String description;
  final IconData leftIcon;
  final Function() leftIconFunction;
  final IconData rightIcon;
  final Function() rightIconFunction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => leftIconFunction(),
                  child: Icon(
                    leftIcon,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => rightIconFunction(),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
                Icon(
                  rightIcon,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              description,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: whiteBoxTopPadding,
          ),
          MediaQuery(
            data: mediaQueryData,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height + 50,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      cleanLayout ? Container() : const SortAndView(),
                      //conent widget rendered here
                      widget
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainBackGround extends StatelessWidget {
  const MainBackGround({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 198, 232, 1),
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class SortAndView extends StatelessWidget {
  const SortAndView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              "Sort:",
              style: TextStyle(color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: MainDropDown(items: items),
            )
          ],
        ),
        const Row(
          children: [
            Text(
              "View:",
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.view_list,
              color: Color.fromRGBO(0, 198, 232, 1),
            ),
            Icon(
              Icons.grid_view_sharp,
              color: Color.fromRGBO(214, 247, 253, 1),
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyBottomNavBar extends StatelessWidget {
  const EmptyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      width: 0,
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(IconData(0)), label: ""),
          BottomNavigationBarItem(icon: Icon(IconData(0)), label: ""),
        ],
      ),
    );
  }
}

class FixedBottomBar extends StatelessWidget {
  const FixedBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, // Position it at the bottom
      left: 0, // Align it to the left (you can adjust this as needed)
      right: 0, // Align it to the right (you can adjust this as needed)
      child: Container(
        width: double.infinity,
        height: 80,
        color: const Color.fromRGBO(16, 152, 174, 1),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FixedBottomBarItem(
              icon: Icons.document_scanner,
              label: "Document",
            ),
            FixedBottomBarItem(
              icon: Icons.document_scanner,
              label: "Pdf",
            ),
            FixedBottomBarItem(
              icon: Icons.copy,
              label: "Copy",
            ),
            FixedBottomBarItem(
              icon: Icons.search,
              label: "Search",
            ),
            FixedBottomBarItem(
              icon: Icons.share,
              label: "Share",
            )
          ],
        ),
      ),
    );
  }
}

class FixedBottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const FixedBottomBarItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
