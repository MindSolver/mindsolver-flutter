class Conversation {
  final String? id; // pk
  final String? imoji; // 이모지
  final String message; // 메시지
  final bool isBot; // 봇
  final int diaryHour; // 일기 작성 시간 e.g. 9, 11
  final DateTime timeStamp; // 메세지 전송 시간

  Conversation({
    this.id,
    this.imoji,
    required this.message,
    required this.isBot,
    required this.diaryHour,
    required this.timeStamp,
  });

  @override
  String toString() {
    return 'Conversation(id: $id, imoji: $imoji, message: $message, isBot: $isBot, diaryHour: $diaryHour, timeStamp: $timeStamp)';
  }
}
