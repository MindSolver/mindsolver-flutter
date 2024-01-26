import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/screens/auth/auth_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int page = 0;

  List data = [
    {
      'image': 'images/onboarding1.png',
      'title': 'Diary',
      'description': 'You can write yout diary with ai bot.',
    },
    {
      'image': 'images/onboarding2.png',
      'title': 'Challenge',
      'description': 'You can challenge your goal.',
    },
    {
      'image': 'images/onboarding3.png',
      'title': 'Statistic',
      'description': 'You can check your statistic.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(data[page]['image']),
                  Text(data[page]['title'], style: kTitleTextStyle),
                  SizedBox(height: 8),
                  Text(data[page]['description'], style: kBody1TextStyle),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      if (page < data.length - 1) {
                        setState(() {
                          page++;
                        });
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthScreen()));
                      }
                    },
                    child: Text('Next', style: kBody1TextStyle),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < data.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = i;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: page == i ? kpurpleDarkerColor : kgrayLightColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
