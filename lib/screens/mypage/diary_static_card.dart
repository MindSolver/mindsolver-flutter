import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class DiaryStaticCard extends StatelessWidget {
  final Widget child;
  final String name;
  final Color backgroundColor;
  final Color highlightColor;

  const DiaryStaticCard({
    required this.child,
    required this.name,
    required this.backgroundColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            SizedBox(height: 24),
            child,
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 4), // 위아래 여백 추가
              decoration: BoxDecoration(
                color: highlightColor,
              ),
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: kSubtitleTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
