class UserDoc {
  final String? uid;
  final String name;
  final String job;
  final String profileUrl;
  final int gender; // 0: 남자, 1: 여자

  final int age;

  UserDoc({
    this.uid,
    required this.name,
    required this.job,
    required this.profileUrl,
    required this.age,
    required this.gender,
  });

  @override
  String toString() {
    return 'UserDoc{uid: $uid, name: $name, job: $job, profileUrl: $profileUrl, age: $age, gender: $gender}';
  }
}
