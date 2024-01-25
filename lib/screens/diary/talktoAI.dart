import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;

class TalkToAI extends StatefulWidget {
  const TalkToAI({Key? key}) : super(key: key);

  @override
  _TalkToAIState createState() => _TalkToAIState();
}

class _TalkToAIState extends State<TalkToAI> {
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talk to AI'),
      ),
      body: Column(
        children: [
          // Some buttons at the top
          // "작성하기" button at the bottom
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
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
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your onPressed logic for Option 1
                                      String enteredCategory =
                                          categoryController.text;
                                      // Process the entered category as needed
                                      print(
                                          'Entered Category: $enteredCategory');
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
                                    child: const Text('Icon 1'),
                                  ),
                                  const SizedBox(width: 16.0), // Add spacing
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your onPressed logic for Option 2
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
                                    child: const Text('Icon 2'),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  controller: categoryController,
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
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('작성하기'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
