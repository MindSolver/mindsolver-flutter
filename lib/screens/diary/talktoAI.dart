import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;
import 'package:intl/intl.dart';

class TalkToAI extends StatefulWidget {
  const TalkToAI({super.key});

  @override
  _TalkToAIState createState() => _TalkToAIState();
}

class _TalkToAIState extends State<TalkToAI> {
  TextEditingController textEditingController = TextEditingController();
  DiaryViewModel diaryViewModel = DiaryViewModel();
  List<Conversation> model = []; // Initialize model as an empty list
  final int _diaryHour = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                Conversation conversation = model[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: conversation.isBot
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Row(
                      children: [
                        if (!conversation.isBot) // Check if it's not a bot
                          const Expanded(
                            child:
                                SizedBox(), // Spacer to push the time and text to the right
                          ),
                        Text(
                          DateFormat('HH:mm').format(conversation.timeStamp),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: conversation.isBot
                                ? customColor.kpurpleColor
                                : customColor.kpurpleLightColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            conversation.message,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Show a popup with buttons and a text input field
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('How do you feel now?'),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                labelText: 'Write down how you feel',
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: customColor.kpurpleDarkerColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0), // Add space here
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    customColor.kpurpleColor,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  String enteredText =
                                      textEditingController.text;
                                  Conversation newConversation = Conversation(
                                    message: enteredText,
                                    isBot: false,
                                    diaryHour: _diaryHour,
                                    timeStamp: DateTime.now(),
                                  );

                                  setState(() {
                                    model.add(newConversation);
                                  });

                                  textEditingController.clear();
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    customColor.kpurpleColor,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  customColor.kpurpleDarkerColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}
