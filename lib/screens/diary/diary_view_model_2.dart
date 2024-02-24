import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindsolver_flutter/models/diary.dart';
import 'package:mindsolver_flutter/utils/date_time_util.dart';

class DiaryViewModel2 extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<Diary> diaries = [];
  List<Diary> filteredDiaries = [];

  void filterDiaries({DateTime? date}) {
    if (date == null) {
      filteredDiaries =
          diaries.where((diary) => diary.content.isNotEmpty).toList();
    } else {
      filteredDiaries = diaries
          .where((diary) =>
              !diary.date.isAfterDay(date) && diary.content.isNotEmpty)
          .toList();
    }
    notifyListeners();
  }

  Future<void> loadDiaries() async {
    final userId = _auth.currentUser?.uid;

    diaries = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('diaries')
          .orderBy('date', descending: true)
          .get();

      for (var doc in querySnapshot.docs) {
        final diary = Diary(
          date: (doc['date'] as Timestamp).toDate(),
          content: doc['content'],
          emoji: doc['emoji'],
        );
        print(diary);
        diaries.add(diary);
      }
    } catch (e) {
      print('Error loading diaries: $e');
    }
    print('Diaries: $diaries');
    filterDiaries();
    notifyListeners();
  }

  Future<void> addDiary(Diary diary) async {
    try {
      final userId = _auth.currentUser?.uid;

      final docRef = _firestore //
          .collection('users')
          .doc(userId)
          .collection('diaries')
          .doc();

      docRef.set({
        'date': diary.date.trimTime(),
        'content': diary.content,
        'emoji': diary.emoji,
      });
    } catch (e) {
      print('Error adding diary: $e');
    }
    notifyListeners();
  }

  Future<void> updateDiary(Diary diary) async {
    final userId = _auth.currentUser?.uid;

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('diaries')
        .get();

    for (var doc in snapshot.docs) {
      if ((doc['date'] as Timestamp).toDate().trimTime().isSameDate(diary.date)) {
        final docRef = _firestore //
            .collection('users')
            .doc(userId)
            .collection('diaries')
            .doc(doc.id);

        await docRef.update({
          'content': diary.content,
          'emoji': diary.emoji,
        });
        return;
      }
    }
  }
}
