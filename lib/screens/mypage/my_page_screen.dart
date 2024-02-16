import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/screens/mypage/my_page_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

import 'diary_static_card.dart';

class MyPageScreen extends StatelessWidget {
  final viewModel = MyPageViewModel();

  MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    viewModel.loadUserData();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
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
                color: kPurpleColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Consumer<MyPageViewModel>(builder: (context, viewModel, child) {
                            return viewModel.userData.profileUrl.isNotEmpty
                                ? Image.network(
                                    viewModel.userData.profileUrl,
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover, // 이미지를 카드에 맞게 잘라서 표시합니다.
                                  )
                                : Container(
                                    width: 56,
                                    height: 56,
                                  );
                          }),
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
                      Consumer<MyPageViewModel>(
                        builder: (context, viewModel, child) => Text(viewModel.userData.name, style: kTitleTextStyle),
                      ),
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
                  backgroundColor: kPurpleLightColor,
                  highlightColor: kPurpleDarkerColor,
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
                  backgroundColor: kYellowLightColor,
                  highlightColor: kYellowColor,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          color: kYellowColor,
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
                            style: kSubtitleTextStyle.copyWith(color: kGrayDarkColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8),
                DiaryStaticCard(
                  name: '월간',
                  backgroundColor: kGreenLightColor,
                  highlightColor: kGreenColor,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          color: kGreenColor,
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
                            style: kSubtitleTextStyle.copyWith(color: kGrayDarkColor),
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
      ),
    );
  }
}
