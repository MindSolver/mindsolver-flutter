import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/components/chat.bubble.dart';
import 'package:mindsolver_flutter/screens/home/diagnosis/diagnosis_screen.dart';
import 'package:mindsolver_flutter/screens/mypage/my_page_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final viewModel = MyPageViewModel();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Mind Solver', style: kTitleTextStyle),
                  SizedBox(height: 8),
                  Text('AI가 생성한 당신의 기분을 표현한 일기', style: kBody1TextStyle),
                  SizedBox(height: 16),
                  ChatBubble(
                      message: '하루 3번 기분을 작성하면 AI가 대신 일기를 작성합니다!',
                      isMe: false),
                  SizedBox(height: 8),
                  ChatBubble(message: '지금 작성하러 가기 →', isMe: true),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiagnosisScreen()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kSkyLightColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('우울증 자가진단', style: kSubtitleTextStyle),
                          SizedBox(height: 8),
                          Text(
                              'Patient Health Questionnaire-9(PHQ-9)는 우울증 진단 기준에 해당하는 9가지 설문입니다.',
                              style: kBody1TextStyle),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kGreenLightColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('정신건강복지센터', style: kSubtitleTextStyle),
                          SizedBox(height: 8),
                          Text(
                              '지역사회 내 정신질환 예방, 정신질환자 발견･상담･정신재활훈련 및 사례관리',
                              style: kBody1TextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
