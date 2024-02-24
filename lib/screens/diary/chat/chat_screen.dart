import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindsolver_flutter/enums/bot_response.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/models/diary.dart';
import 'package:mindsolver_flutter/screens/diary/chat/bubble.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model_2.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:mindsolver_flutter/utils/date_time_util.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final DateTime date;

  const ChatScreen({super.key, required this.date});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  late DiaryViewModel diaryViewModel;
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    diaryViewModel = DiaryViewModel(date: widget.date);

    WidgetsBinding.instance.addObserver(this);
    diaryViewModel.loadConversations().then((value) {
      runBot();
    });
  }

  void runBot() async {
    final list = diaryViewModel.conversations;

    await botPrompt(list);
    await botResponse(list);
    await botWriteDiary(list);

  }

  Future<void> botPrompt(List<Conversation> list) async {
    DateTime now = DateTime.now();
    int hour = 0;

    for (BotResponse botResponse in BotResponse.values) {
      if (now.hour >= botResponse.diaryHour &&
          now.hour < botResponse.limitHour) {
        hour = botResponse.diaryHour;
        if (list.where((element) {
          return element.diaryHour == hour &&
              element.type == Conversation.TYPE_BOT_PROMPT;
        }).isEmpty) {
          await diaryViewModel
              .addConversation(Conversation(
                message: botResponse.prompt,
                isBot: true,
                diaryHour: hour,
                timeStamp: now,
                type: Conversation.TYPE_BOT_PROMPT,
              ))
              .then((value) => diaryViewModel.loadConversations());
        }
      }
    }
  }

  Future<void> botResponse(List<Conversation> list) async {
    DateTime now = DateTime.now();
    int hour = 0;

    for (BotResponse botResponse in BotResponse.values) {
      if (now.hour >= botResponse.diaryHour &&
          now.hour < botResponse.limitHour) {
        hour = botResponse.diaryHour;
        if (list.where((element) {
          return element.diaryHour == hour &&
              element.type == Conversation.TYPE_BOT_RESPONSE;
        }).isEmpty) {
          if (isUserResponse(list, hour)) {
            await diaryViewModel
                .addConversation(Conversation(
                  message: botResponse.response,
                  isBot: true,
                  diaryHour: hour,
                  timeStamp: now,
                  type: Conversation.TYPE_BOT_RESPONSE,
                ))
                .then((value) => diaryViewModel.loadConversations());
          }
        }
      }
    }
  }

  Future<void> botWriteDiary(List<Conversation> list) async {
    DateTime now = DateTime.now();
    int hour = 0;

    for (BotResponse botResponse in BotResponse.values) {
      if (now.hour >= botResponse.diaryHour &&
          now.hour < botResponse.limitHour) {
        hour = botResponse.diaryHour;
        if (list.where((element) {
          return element.diaryHour == hour &&
              element.type == Conversation.TYPE_DIARY;
        }).isEmpty) {
          if (canDiaryBeGenerated(list)) {
            String randomId = DateTime.now().millisecondsSinceEpoch.toString();

            diaryViewModel.generateDiary((result) async {
              diaryViewModel
                  .addConversation(Conversation(
                    id: randomId,
                    message: result,
                    isBot: true,
                    diaryHour: BotResponse.end.diaryHour,
                    timeStamp: DateTime.now(),
                    type: Conversation.TYPE_DIARY,
                  ))
                  .then((value) => diaryViewModel.loadConversations());
            }, (String result) {
              DiaryViewModel2 diaryViewModel2 = DiaryViewModel2();
              diaryViewModel2.updateDiary(Diary(
                date: widget.date.trimTime(),
                content: result,
                emoji: '👟',
              ));
            });
          }
        }
      }
    }
  }





  bool isUserResponse(List<Conversation> list, int hour) {
    return list.where((element) {
      return element.diaryHour == hour &&
          element.type == Conversation.TYPE_USER_RESPONSE;
    }).isNotEmpty;
  }

  bool canDiaryBeGenerated(List<Conversation> list) {
    return list.where((element) {
      return element.type == Conversation.TYPE_BOT_RESPONSE;
    }).length == 4;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // runBot();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.date.toFormattedString()),
      ),
      body: ChangeNotifierProvider(
        create: (context) => diaryViewModel,
        child: Column(
          children: [
            Expanded(
              child: Consumer<DiaryViewModel>(
                builder: (context, viewModel, child) {
                  final list = viewModel.conversations;

                  return ListView.builder(
                    itemCount: list.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Conversation conversation = list[index];
                      return Bubble(
                        message: conversation.message,
                        isMe: !conversation.isBot,
                        date:
                            DateFormat('HH:mm').format(conversation.timeStamp),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime now = DateTime.now();

                      int hour = 0;

                      for (BotResponse botResponse in BotResponse.values) {
                        if (now.hour >= botResponse.diaryHour &&
                            now.hour < botResponse.limitHour) {
                          hour = botResponse.diaryHour;
                        }
                      }

                      String enteredText = textEditingController.text;
                      Conversation userConversation = Conversation(
                        message: enteredText,
                        isBot: false,
                        type: Conversation.TYPE_USER_RESPONSE,
                        diaryHour: hour,
                        timeStamp: now,
                      );

                      diaryViewModel
                          .addConversation(userConversation)
                          .then((value) {
                        diaryViewModel.loadConversations().then((value) => runBot());
                      });

                      textEditingController.clear(); // Clear the text field
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kPurpleDarkerColor,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Send'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
