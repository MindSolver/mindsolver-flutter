import 'package:flutter/material.dart';

class DiagnosisResultScreen extends StatelessWidget {
  final int depressionScore;

  const DiagnosisResultScreen({Key? key, required this.depressionScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = determineResult(depressionScore);

    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis Result'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Diagnosis Result:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Scoring Criteria:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '0~4점: 우울 아님\n'
                      '5~9점: 가벼운 우울\n'
                      '10~19점: 중간정도의 우울\n(가까운 지역센터나 전문기관 방문을 요망합니다.)\n'
                      '20~27점: 심한 우울\n(전문기관의 치료적 개입과 평가가 필요합니다.)',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String determineResult(int score) {
    if (score >= 0 && score <= 4) {
      return '우울 아님';
    } else if (score >= 5 && score <= 9) {
      return '가벼운 우울';
    } else if (score >= 10 && score <= 19) {
      return '중간정도의 우울\n(가까운 지역센터나 전문기관 방문을 요망합니다.)';
    } else if (score >= 20 && score <= 27) {
      return '심한 우울\n(전문기관의 치료적 개입과 평가가 필요합니다.)';
    } else {
      return '유효하지 않은 점수입니다.';
    }
  }
}