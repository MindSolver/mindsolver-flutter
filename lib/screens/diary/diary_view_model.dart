import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';

import 'package:http/http.dart' as http;
import 'package:mindsolver_flutter/screens/diary/diary_view_model_2.dart';
import 'package:mindsolver_flutter/utils/date_time_util.dart';

class DiaryViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<Conversation> conversations = [];

  DateTime date;
  String? diaryDocId;

  DiaryViewModel({required this.date});

  Future<void> loadConversations() async {
    print('loadConversations');
    conversations = [];
    final userId = _auth.currentUser?.uid;

    try {
      if(diaryDocId == null) {
        print(date);
        final collectionRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('diaries');

        final snapshot = await collectionRef.get();

        bool isNotExists = true;
        for (var doc in snapshot.docs) {
          print('content: ${doc['content']}');
          print('emoji: ${doc['emoji']}');
          print('date: ${doc['date']}');
          if ((doc['date'] as Timestamp).toDate().trimTime().isSameDate(date)) {
            isNotExists = false;
            diaryDocId = doc.id;
            break;
          }
        }
        if (isNotExists) {
          await initDiary();
        }
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('diaries')
          .doc(diaryDocId)
          .collection('conversations')
          .orderBy('timeStamp', descending: true)
          .get();

      for (var doc in querySnapshot.docs) {
        final temp = Conversation(
          id: doc['id'],
          timeStamp: (doc['timeStamp'] as Timestamp).toDate(),
          isBot: doc['isBot'],
          message: doc['message'],
          diaryHour: doc['diaryHour'],
          type: doc['type'],
        );

        conversations.add(temp);
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
    notifyListeners();
  }

  Future<void> initDiary() async {
    final userId = _auth.currentUser?.uid;
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('diaries')
        .doc();


    await docRef.set({
      'emoji': '',
      'date': date.trimTime(),
      'content': '',
    });

    diaryDocId = docRef.id;
    print('diaryDocId: $diaryDocId');
  }

  Future<void> addConversation(Conversation conversation) async {
    try {
      final userId = _auth.currentUser?.uid;

      DocumentReference<Map<String, dynamic>> docRef;
      if (conversation.id != null) {
        docRef = _firestore //
            .collection('users')
            .doc(userId)
            .collection('diaries')
            .doc(diaryDocId)
            .collection('conversations')
            .doc(conversation.id);
      } else {
        docRef = _firestore //
            .collection('users')
            .doc(userId)
            .collection('diaries')
            .doc(diaryDocId)
            .collection('conversations')
            .doc();
      }

      docRef.set({
        'id': docRef.id,
        'message': conversation.message,
        'diaryHour': conversation.diaryHour,
        'isBot': conversation.isBot,
        'timeStamp': conversation.timeStamp,
        'type': conversation.type,
      });
    } catch (e) {
      print('Error adding conversation: $e');
    }
    notifyListeners();
  }

  Future<void> generateDiary(Function onResult, Function onDone) async {
    http.Client client = http.Client();

    http.Request request = http.Request("POST",
        Uri.parse('http://10.0.2.2:8080/diary')); // Android Emulator 10.0.2.2

    request.headers["Accept"] = "text/event-stream";
    request.headers["Cache-Control"] = "no-cache";
    request.headers["content-type"] = "application/json; charset=utf-8";

    request.body = json.encode({
      "UserDto": {
        "GoogleID": "",
        "username": "영진",
        "age": 25,
        "gender": "남자",
        "job": "개발자 취업을 희망하는 학생"
      },
      "TodayStampList": [
        {
          "GoogleID": "",
          "dateTime": "2024-02-09 T15:00:30",
          "stamp": "피곤",
          "memoLet":
              "오늘 아침 9시에 집에서 출발해서 방금 할머니댁에 도착했다. 내가 운전을 3시간하고, 아빠가 나머지를 했는데, 너무 힘들다."
        },
        {
          "GoogleID": "",
          "dateTime": "2024-02-09 T19:00:50",
          "stamp": "배부름",
          "memoLet": "할머니가 해주신 맛있는 음식을 먹었다. 너무 맛있는 음식을 많이 먹어서 살 찔 거 같음.."
        },
        {
          "GoogleID": "",
          "dateTime": "2024-02-09 T23:00:44",
          "stamp": "기쁨",
          "memoLet":
              "먹고 나서는 조카와 함께 카페를 갔었는데, 대학입학을 앞둔 조카를 만나서 이것저것 얘기해주면서 나도 대학생활 시절로 돌아간 느낌이었다. 좋은 시간이었던 것 같다"
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
          onResult(result);
        },
        onDone: () {
          debugPrint("Done!");
          debugPrint(result);
          onDone(result);

        },
      ),
    );
  }
}
