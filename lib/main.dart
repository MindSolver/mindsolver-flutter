import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/firebase_options.dart';
import 'package:mindsolver_flutter/screens/onboarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingScreen(),
    );
  }
}
