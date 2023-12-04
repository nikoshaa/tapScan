import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/welcome_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart'; // Import the MyScansPage
import 'package:tap_scan/providers/ktp_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Wait for 3 seconds.
  Future.delayed(const Duration(seconds: 3), () {
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already authenticated
  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    MyApp(user: user), // Pass the user to MyApp
  );

  configLoading();
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({Key? key, required this.user}) : super(key: key);

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
        // Use a ternary operator to determine the initial route based on the user's authentication status
        initialRoute: user != null ? '/myScans' : '/', 
        routes: {
          '/': (context) => const WelcomePage(),
          '/myScans': (context) => const MyScansPage(),
        },
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
