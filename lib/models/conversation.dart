class Conversation {
  static const String TYPE_NONE = "none";
  static const String TYPE_BOT_PROMPT = "bot_prompt";
  static const String TYPE_BOT_RESPONSE = "bot_response";
  static const String TYPE_DIARY = "diary";
  static const String TYPE_USER_RESPONSE = "user_response";

  final String? id; // pk
  final bool isBot;
  final DateTime timeStamp;
  final String message; // 메시지
  final int diaryHour; // 일기 작성 시간 e.g. 9, 13 19 23
  final String type;

  Conversation({
    this.id,
    required this.isBot,
    required this.timeStamp,
    required this.message,
    required this.diaryHour,
    required this.type,
  });

  @override
  String toString() {
    return 'Conversation{id: $id, isBot: $isBot, timeStamp: $timeStamp, message: $message, diaryHour: $diaryHour, type: $type}';
  }
}
