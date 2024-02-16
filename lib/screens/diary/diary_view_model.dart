import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';

import 'package:http/http.dart' as http;

class DiaryViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<Conversation> conversations = [];

  Future<void> loadConversations(DateTime date) async {
    conversations = [];
    final userId = _auth.currentUser?.uid;

    try {
      DateTime startDate = DateTime(date.year, date.month, date.day, 0, 0, 0); // 해당 날짜의 시작
      DateTime endDate = DateTime(date.year, date.month, date.day, 23, 59, 59); // 해당 날짜의 끝

      QuerySnapshot querySnapshot = await _firestore //
          .collection('users')
          .doc(userId)
          .collection('conversations')
          .where('timeStamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('timeStamp', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('timeStamp', descending: true)
          .get();

      for (var doc in querySnapshot.docs) {
        final temp = Conversation(
          id: doc['id'],
          imoji: doc['imoji'],
          message: doc['message'],
          isBot: doc['isBot'],
          diaryHour: doc['diaryHour'],
          timeStamp: (doc['timeStamp'] as Timestamp).toDate(),
        );

        conversations.add(temp);
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
    notifyListeners();
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

  Future<void> generateDiary() async {
    http.Client client = http.Client();

    http.Request request = http.Request("POST", Uri.parse('http://3.36.79.79:9000/gpt35'));
    request.headers["Accept"] = "text/event-stream";
    request.headers["Cache-Control"] = "no-cache";
    request.headers["content-type"] = "application/json; charset=utf-8";
    request.body = json.encode({
      "user_info": {
        "age": 30,
        "job": "Developer",
        "gender": 1
      },
      "stampList": [
        {
          "timestamp": "2022-01-01T12:00:00",
          "content": "First diary entry"
        },
        {
          "timestamp": "2022-01-01T13:00:00",
          "content": "Second diary entry"
        }
      ]
    });

    Future<http.StreamedResponse> response = client.send(request);
    print("Subscribed!");

    String result = '';
    response.then(
      (streamedResponse) => streamedResponse.stream.listen(
        (value) {
          final parsedData = utf8.decode(value);
          result += parsedData;
          //cb(result);
          print('result ${parsedData}');
        },
        onDone: () => print(result),
      ),
    );
  }
}
