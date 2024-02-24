import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/screens/home/diagnosis/diagnosis_result_screen.dart';
import 'package:mindsolver_flutter/screens/home/diagnosis/survey.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  List<int?> selectedScores = List.filled(9, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('우울증 자가진단', style: kAppBarTextStyle),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '최근 2주간 자신에게 해당된다고 생각되는 곳에 체크를 해주세요.\n총 문항은 9개입니다.',
                          style: kBody1TextStyle,
                        )),
                    SurveyWidget(
                      question: '1. 기분이 가라앉거나, 우울하거나, 희망이 없다고 느꼈다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[0] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '2. 평소 하던 일에 대한 흥미가 없어지거나 즐거움을 느끼지 못했다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[1] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '3. 잠들기가 어렵거나 자주 깼다/혹은 너무 많이 잤다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[2] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '4. 평소보다 식욕이 줄었다/혹은 평소보다 많이 먹었다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[3] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question:
                          '5. 다른 사람들이 눈치 챌 정도로 평소보다 말과 행동이 느려졌다/ 혹은 너무 안절부절 못해서 가만히 앉아있을 수 없었다 ',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[4] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '6. 피곤하고 기운이 없었다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[5] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question:
                          '7. 내가 잘못 했거나, 실패했다는 생각이 들었다/ 혹은 자신과 가족을 실망시켰다고 생각했다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[6] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '8. 신문을 읽거나 TV를 보는 것과 같은 일상적인 일에도 집중할 수가 없었다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[7] = score;
                        });
                      },
                    ),
                    SurveyWidget(
                      question: '9. 차라리 죽는 것이 더 낫겠다고 생각했다/혹은 자해할 생각을 했다',
                      onChanged: (int? score) {
                        setState(() {
                          selectedScores[8] = score;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Progress indicator and completion button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    // Adjust the radius as needed
                    child: LinearProgressIndicator(
                      color: kPurpleDarkerColor,
                      value: calculateProgress(),
                      minHeight: 10.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurpleDarkerColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isCompleted()
                        ? () {
                            showResult();
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => DiagnosisResultScreen(depressionScore: calculateTotalScore())));
                          }
                        : null,
                    child: Text('결과 확인하기!', style: kSubtitleTextStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('자가진단 결과', style: kAppBarTextStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${calculateTotalScore()}점', style: kSubtitleTextStyle),
              SizedBox(height: 10),
              Text(determineResult(calculateTotalScore()),
                  style: kSubtitleTextStyle),
              SizedBox(height: 10),
              Container(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('점수')),
                    DataColumn(label: Text('결과')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('0~4')),
                      DataCell(Text('우울 아님')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('5~9')),
                      DataCell(Text('가벼운 우울')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('10~19')),
                      DataCell(Text('중간정도의 우울')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('20~27')),
                      DataCell(Text('심한 우울')),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPurpleDarkerColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('확인'),
              ),
            ],
          ),
        );
      },
    );
  }

  double calculateProgress() {
    int answeredQuestions =
        selectedScores.where((score) => score != null).length;
    return answeredQuestions / selectedScores.length;
  }

  bool isCompleted() {
    return selectedScores.every((score) => score != null);
  }

  int calculateTotalScore() {
    int totalScore = 0;
    for (int? score in selectedScores) {
      if (score != null) {
        totalScore += score;
      }
    }
    return totalScore;
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
