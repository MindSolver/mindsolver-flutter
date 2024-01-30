class Answer {
  final String? id; // pk
  final String message; // 메시지
  final int questionNum; // 질문 넘버
  final DateTime timeStamp; // 메세지 전송 시간

  Answer({
    this.id,
    required this.message,
    required this.questionNum,
    required this.timeStamp,
  });

  @override
  String toString() {
    return 'Answer(id: $id, questionNum: $questionNum, message: $message, timeStamp: $timeStamp)';
  }
}
