import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindsolver_flutter/enums/bot_response.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/chat/bubble.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:mindsolver_flutter/utils/date_time_util.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final DateTime selectedDate;

  const ChatScreen({super.key, required this.selectedDate});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final diaryViewModel = DiaryViewModel();

  final textEditingController = TextEditingController();

  bool isDiaryToday = false;

  @override
  void initState() {
    super.initState();
    isDiaryToday = isSameDate(widget.selectedDate, DateTime.now());
    check();

    WidgetsBinding.instance.addObserver(this);

    diaryViewModel.generateDiary();
  }

  void check() {
    if (!isDiaryToday) {
      return;
    }

    diaryViewModel.loadConversations(widget.selectedDate).then(
          (value) {
        final list = diaryViewModel.conversations;

        for (BotResponse botResponse in BotResponse.values) {
          bool isBotPrompted = false;
          bool isBotResponse = false;
          bool isUserExists = false;

          for (Conversation conversation in list) {
            if (conversation.diaryHour != botResponse.diaryHour) {
              continue;
            }

            if (!isBotPrompted) {
              isBotPrompted = conversation.isBot &&
                  conversation.message == botResponse.prompt;
            }

            if (!isBotResponse) {
              isBotResponse = conversation.isBot &&
                  conversation.message == botResponse.response;
            }

            if (!isUserExists) {
              isUserExists = !conversation.isBot;
            }
          }

          // 디버깅을 위한 로그 출력
          print('botResponse: $botResponse');
          print('list: $list');
          print('isBotPrompted: $isBotPrompted');
          print('isBotResponse: $isBotResponse');
          print('isUserExists: $isUserExists');

          final now = DateTime.now();
          print(now);

          if (!isBotPrompted) {
            if (now.hour >= botResponse.diaryHour &&
                now.hour < botResponse.limitHour) {
              print('프롬프트 추가');
              diaryViewModel
                  .addConversation(
                Conversation(
                  message: botResponse.prompt,
                  isBot: true,
                  diaryHour: botResponse.diaryHour,
                  timeStamp: now,
                ),
              )
                  .then((value) =>
                  diaryViewModel.loadConversations(widget.selectedDate));
            }
          } else {
            // 프롬포트 있는 경우
            if (isUserExists && !isBotResponse) {
              // 사용자 대답이 있는 경우
              diaryViewModel
                  .addConversation(Conversation(
                message: botResponse.response,
                isBot: true,
                diaryHour: botResponse.diaryHour,
                timeStamp: now,
              )).then((value) async {
                diaryViewModel.loadConversations(widget.selectedDate);
                if (botResponse.diaryHour == BotResponse.end.diaryHour) {
                  print('호출 시작!');
                  // await diaryViewModel.generateDiary((result) {
                  //   print(result);
                  // });
                }
              });
            }
          }
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        check();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
      case AppLifecycleState.paused:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${DateFormat('MM/dd').format(widget.selectedDate)}'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => diaryViewModel,
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, DiaryViewModel viewModel, child) {
                  final list = viewModel.conversations;

                  return ListView.builder(
                    itemCount: list.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Conversation conversation = list[index];
                      return Bubble(
                        message: conversation.message,
                        isMe: !conversation.isBot,
                        date: DateFormat('HH:mm').format(conversation
                            .timeStamp),
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
                        diaryHour: hour,
                        timeStamp: now,
                      );

                      await diaryViewModel.addConversation(userConversation);

                      textEditingController.clear(); // Clear the text field

                      check();
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
