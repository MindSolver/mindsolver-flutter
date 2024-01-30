import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

import 'diary_static_card.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Text('MindeSolver', style: kTitleTextStyle)),
            SvgPicture.asset('icons/tune.svg')
          ]),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kpurpleColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2024/01/15/19/40/animal-8510775_1280.jpg',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover, // 이미지를 카드에 맞게 잘라서 표시합니다.
                        ),
                      ),
                    ),
                    SizedBox(width: 80),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('챌린지', style: kBody2TextStyle),
                              Text('7', style: kBody1TextStyle),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('좋아요', style: kBody2TextStyle),
                              Text('99', style: kBody1TextStyle),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HongGildong', style: kTitleTextStyle),
                    SvgPicture.asset('icons/thumbup_filled.svg')
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text('다이어리', style: kSubtitleTextStyle),
          SizedBox(height: 8),
          Row(
            children: [
              DiaryStaticCard(
                name: '오늘',
                backgroundColor: kpurpleLightColor,
                highlightColor: kpurpleDarkerColor,
                child: SvgPicture.asset(
                  'icons/checkbox_empty.svg',
                  color: Colors.white,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 8),
              DiaryStaticCard(
                name: '주간',
                backgroundColor: kyellowLightColor,
                highlightColor: kyellowColor,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 0.7,
                        color: kyellowColor,
                        backgroundColor: Colors.white,
                        strokeWidth: 10.0,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          '1/7',
                          style: kSubtitleTextStyle.copyWith(color: kgrayDarkColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 8),
              DiaryStaticCard(
                name: '월간',
                backgroundColor: kgreenLightColor,
                highlightColor: kgreenColor,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 0.7,
                        color: kgreenColor,
                        backgroundColor: Colors.white,
                        strokeWidth: 10.0,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          '1/7',
                          style: kSubtitleTextStyle.copyWith(color: kgrayDarkColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
