import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/progress_done.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
                child: const ProgressDone(),
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this),
          );
        },
        child: Container(
          color: const Color.fromRGBO(0, 198, 232, 1),
          width: double.infinity,
          height: double.infinity,
          child: const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              MainProcessIndicator(
                percent: 0.7,
              ),
              SizedBox(
                height: 150,
              ),
              Text(
                "Estimated waiting time: 15sec",
                style: TextStyle(color: Colors.white),
              ),
              RedButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RedButton extends StatelessWidget {
  const RedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FilledButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 55, 120, 1)),
        ),
        child: const Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 12,
            bottom: 12,
          ),
          child: Text(
            "X    Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
