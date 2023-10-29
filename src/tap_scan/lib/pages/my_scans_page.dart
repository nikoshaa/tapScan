import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';

class MyScansPage extends StatelessWidget {
  const MyScansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              //background
              Container(
                color: const Color.fromRGBO(0, 198, 232, 1),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text(
                          "My Scans",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    MainNavBar(activeIndex: 0),
                  ],
                ),
              ),
              //white box
              Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  MediaQuery(
                    data: mediaQueryData,
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 200,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Sort:",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const KtpCard(),
                              const SizedBox(
                                height: 20,
                              ),
                              const KtpCard(),
                              const SizedBox(
                                height: 20,
                              ),
                              const KtpCard(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          floatingActionButton: const MainFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const MainBottomNavBar()),
    );
  }
}
