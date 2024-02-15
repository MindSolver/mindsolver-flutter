enum BotResponse {
  morning(
    diaryHour: 9,
    limitHour: 13,
    prompt: '오늘 아침 기분은 어때?',
    notification: '아직 자고 있는건 아니지?',
    response: '아침부터 활기차게 시작해보자!',
  ),
  launch(
    diaryHour: 13,
    limitHour: 19,
    prompt: '오늘 점심은 어땠어?',
    notification: '점심에는 가벼운 산책 어때?',
    response: '저녁에도 다시 나랑 얘기하자!',
  ),
  dinner(
    diaryHour: 19,
    limitHour: 21,
    prompt: '오늘 저녁은 어땠어?',
    notification: '오늘 하루는 피곤하지 않았어?',
    response: '아하 그런 일이 있었구나',
  ),
  end(
    diaryHour: 21,
    limitHour: 24,
    prompt: '일기 쓰는거 힘들지? 오늘 너의 하루를 내가 일기로 작성해줄게',
    notification: '오늘의 채팅을 내가 일기로 만들어줄게!',
    response: '일기를 생성중이야! 잠시만 기다려줘',
  );

  const BotResponse({
    required this.diaryHour,
    required this.limitHour,
    required this.prompt,
    required this.notification,
    required this.response,
  });

  final int diaryHour;
  final int limitHour;

  final String prompt;
  final String notification;
  final String response;

  @override
  String toString() {
    return 'BotResponse{diaryHour: $diaryHour, limitHour: $limitHour, prompt: $prompt, notification: $notification, response: $response}';
  }
}
