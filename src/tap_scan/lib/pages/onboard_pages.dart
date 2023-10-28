import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:tap_scan/pages/login_page.dart';

class OnBoardPages extends StatelessWidget {
  final PageController pageController = PageController();

  OnBoardPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          // print('skipped');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          // print('done tapped');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Colors.brown.shade300,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.black12,
          activeColor: Colors.black,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            // print('skipButton pressed');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Text(
            "Skip",
            style:
                TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state, context),
              child: Container(
                width: 250,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(0, 198, 232, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.isLastPage ? "SCAN IMAGE NOW" : "Next",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Scan Images Fast & Easy",
    description:
        "Turn your photographs of text or pdf files into an editable and searcable text with juts a few clikcks.",
    imgUrl: "assets/images/onboard-1.png",
  ),
  const OnBoardModel(
    title: "Translate to over 150 supported language",
    description:
        "Having difficulty translating words from printed posts or signages? Once you have scanned an image, we can transalate it for you.",
    imgUrl: 'assets/images/onboard-2.png',
  ),
  const OnBoardModel(
    title: "Copy, share and export to pdf or document format",
    description:
        "It’s easy to share export to pdf or doc format without need to copying and fasting to external word processing program.",
    imgUrl: 'assets/images/onboard-3.png',
  ),
];
