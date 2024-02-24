
class Diary {
  final DateTime date;
  final String content;
  final String emoji;

  Diary({
    required this.date,
    required this.content,
    required this.emoji,
  });

  @override
  String toString() {
    return 'Diary{date: $date, content: $content, emoji: $emoji}';
  }
}