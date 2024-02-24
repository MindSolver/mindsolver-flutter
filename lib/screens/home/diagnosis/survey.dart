import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class SurveyWidget extends StatefulWidget {
  final String question;
  final ValueChanged<int?> onChanged;

  const SurveyWidget({
    Key? key,
    required this.question,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SurveyWidgetState createState() => _SurveyWidgetState();
}

class _SurveyWidgetState extends State<SurveyWidget> {
  int? selectedScore;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            OptionWidget(
              option: '없음',
              isSelected: selectedScore == 0,
              onTap: () {
                setState(() {
                  selectedScore = 0;
                  widget.onChanged(selectedScore);
                });
              },
            ),
            OptionWidget(
              option: '2, 3일 이상',
              isSelected: selectedScore == 1,
              onTap: () {
                setState(() {
                  selectedScore = 1;
                  widget.onChanged(selectedScore);
                });
              },
            ),
            OptionWidget(
              option: '7일 이상',
              isSelected: selectedScore == 2,
              onTap: () {
                setState(() {
                  selectedScore = 2;
                  widget.onChanged(selectedScore);
                });
              },
            ),
            OptionWidget(
              option: '거의 매일',
              isSelected: selectedScore == 3,
              onTap: () {
                setState(() {
                  selectedScore = 3;
                  widget.onChanged(selectedScore);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionWidget({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            isSelected
                ? Icon(Icons.check_circle, color: kPurpleDarkerColor)
                : Icon(Icons.radio_button_unchecked),
            SizedBox(width: 10.0),
            Text(
              option,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}