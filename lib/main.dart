import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:farm_app/src/home/presentation/pages/splash_screen.dart';
import 'package:farm_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm IOT',
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Image.asset('assets/images/logo1.png')),
            const Text(
              'Sustainable Farm App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        nextScreen: const SplashScreen(),
        duration: 5000,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
