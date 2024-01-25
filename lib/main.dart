import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/screens/challenge/challenge.screen.dart';
import 'package:mindsolver_flutter/screens/diary/diary_screen.dart';
import 'package:mindsolver_flutter/screens/home/home_screen.dart';
import 'package:mindsolver_flutter/screens/mypage/my_page_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: [
          const HomeScreen(),
          const DiaryScreen(),
          const ChallengeScreen(),
          const MyPageScreen(),
        ][currentPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: kpurpleColor,
          selectedItemColor: kpurpleDarkerColor,
          showUnselectedLabels: true,
          currentIndex: currentPageIndex,
          onTap: (int index) {
            setState(() {
              print(index);
              currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/home.svg', color: kpurpleColor),
              activeIcon: SvgPicture.asset('icons/home.svg', color: kpurpleDarkerColor),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/book.svg', color: kpurpleColor),
              activeIcon: SvgPicture.asset('icons/book.svg', color: kpurpleDarkerColor),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/challenge.svg', color: kpurpleColor),
              activeIcon: SvgPicture.asset('icons/challenge.svg', color: kpurpleDarkerColor),
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/profile.svg', color: kpurpleColor),
              activeIcon: SvgPicture.asset('icons/profile.svg', color: kpurpleDarkerColor),
              label: 'Mypage',
            ),
          ]),
    );
  }
}
