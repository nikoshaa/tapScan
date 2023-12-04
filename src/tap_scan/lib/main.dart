import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/welcome_page.dart';
import 'package:tap_scan/providers/ktp_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// Wait for 3 seconds.
  Future.delayed(const Duration(seconds: 3), () {
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();
  });

  runApp(const MyApp());
  configLoading();
}

// Lupa format pesan commit

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<KtpProvider>(create: (_) => KtpProvider())
      ],
      child: MaterialApp(
        title: 'tapScan',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: const WelcomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
