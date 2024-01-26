import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindsolver_flutter/screens/auth/auth_screen.dart';
import 'package:mindsolver_flutter/screens/auth/auth_view_model.dart';
import 'package:mindsolver_flutter/screens/main_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthScreen(viewModel: AuthViewModel())));
                },
                child: Text('이동'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
