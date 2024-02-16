import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/screens/auth/auth_screen.dart';
import 'package:mindsolver_flutter/screens/auth/auth_view_model.dart';
import 'package:mindsolver_flutter/screens/challenge/challenge.screen.dart';
import 'package:mindsolver_flutter/screens/diary/diary_screen.dart';
import 'package:mindsolver_flutter/screens/home/home_screen.dart';
import 'package:mindsolver_flutter/screens/mypage/my_page_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class MyHomePage extends StatefulWidget {
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
          HomeScreen(),
          DiaryScreen(),
          ChallengeScreen(),
          MyPageScreen(),
        ][currentPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: kPurpleColor,
          selectedItemColor: kPurpleDarkerColor,
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
              icon: SvgPicture.asset('icons/home.svg', color: kPurpleColor),
              activeIcon: SvgPicture.asset('icons/home.svg', color: kPurpleDarkerColor),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/book.svg', color: kPurpleColor),
              activeIcon: SvgPicture.asset('icons/book.svg', color: kPurpleDarkerColor),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/challenge.svg', color: kPurpleColor),
              activeIcon: SvgPicture.asset('icons/challenge.svg', color: kPurpleDarkerColor),
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('icons/profile.svg', color: kPurpleColor),
              activeIcon: SvgPicture.asset('icons/profile.svg', color: kPurpleDarkerColor),
              label: 'Mypage',
            ),
          ]),
    );
  }
}
