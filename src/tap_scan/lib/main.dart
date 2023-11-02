import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tap_scan/pages/welcome_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// Wait for 3 seconds.
  Future.delayed(const Duration(seconds: 3), () {
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'tapScan',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: const WelcomePage());
  }
}
