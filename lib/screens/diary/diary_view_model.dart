import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/models/user.dart';
import 'package:mindsolver_flutter/models/Answer.dart';

class DiaryViewModel {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<List<Conversation>> loadConversations(DateTime date) async {
    List<Conversation> conversations = [];
    final userId = _auth.currentUser?.uid;

    try {
      DateTime startDate =
          DateTime(date.year, date.month, date.day, 0, 0, 0); // 해당 날짜의 시작
      DateTime endDate =
          DateTime(date.year, date.month, date.day, 23, 59, 59); // 해당 날짜의 끝

      QuerySnapshot querySnapshot = await _firestore //
          .collection('users')
          .doc(userId)
          .collection('conversations')
          .where('timeStamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('timeStamp', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .get();

      for (var doc in querySnapshot.docs) {
        conversations.add(Conversation(
          id: doc['id'],
          imoji: doc['imoji'],
          message: doc['message'],
          isBot: doc['isBot'],
          diaryHour: doc['diaryHour'],
          timeStamp: (doc['timeStamp'] as Timestamp).toDate(),
        ));
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
    return conversations;
  }

  Future<void> addConversation(Conversation conversation) async {
    try {
      final userId = _auth.currentUser?.uid;

      final docRef = _firestore //
          .collection('users')
          .doc(userId)
          .collection('conversations')
          .doc();

      docRef.set({
        'id': docRef.id,
        'imoji': conversation.imoji,
        'message': conversation.message,
        'isBot': conversation.isBot,
        'diaryHour': conversation.diaryHour,
        'timeStamp': conversation.timeStamp,
      });
    } catch (e) {
      print('Error adding conversation: $e');
    }
  }

  Future<void> addAnswer(Answer answer) async {
    try {
      final userId = _auth.currentUser?.uid;
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('answers')
          .doc();

      docRef.set({
        'id': docRef.id,
        'questionNum': answer.questionNum,
        'message': answer.message,
        'timeStamp': answer.timeStamp,
      });
    } catch (e) {
      print('Error adding answer: $e');
    }
  }
}
