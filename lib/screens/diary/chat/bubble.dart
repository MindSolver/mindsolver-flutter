import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

class Bubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String date; // 추가된 부분

  Bubble({
    required this.message,
    required this.isMe,
    required this.date, // 추가된 부분
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? kPurpleDarkerColor : kPurpleLightColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 8 : 0),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(isMe ? 0 : 8),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
          child: Text(
            date,
            style: kCaption1TextStyle,
          ),
        ),
      ],
    );
  }
}
