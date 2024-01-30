import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/diary_screen.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/models/Answer.dart';
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;

class WriteTemplate extends StatefulWidget {
  const WriteTemplate({super.key});

  @override
  _WriteTemplate createState() => _WriteTemplate();
}

class _WriteTemplate extends State<WriteTemplate> {
  double boxwidth = 350;
  DiaryViewModel diaryViewModel = DiaryViewModel();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: boxwidth,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: customColor.kpurpleLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'What did you eat today?',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16.0), // Add space here
            Center(
              child: SizedBox(
                width: boxwidth,
                child: TextField(
                  controller: textEditingController1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your answer',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50.0),

            Container(
              width: boxwidth,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: customColor.kpurpleLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Who did you meet?',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16.0), // Add space here
            Center(
              child: SizedBox(
                width: boxwidth,
                child: TextField(
                  controller: textEditingController2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your answer',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              width: boxwidth,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: customColor.kpurpleLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'What did you see?',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16.0), // Add space here
            Center(
              child: SizedBox(
                width: boxwidth,
                child: TextField(
                  controller: textEditingController3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your answer',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Add space here
            // Submit button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission logic here
                  // You can print the values, store them, or perform any other action
                  Answer answer1 = Answer(
                    questionNum: 1,
                    message: textEditingController1.text,
                    timeStamp: DateTime.now(),
                  );

                  Answer answer2 = Answer(
                    questionNum: 2,
                    message: textEditingController2.text,
                    timeStamp: DateTime.now(),
                  );

                  Answer answer3 = Answer(
                    questionNum: 3,
                    message: textEditingController3.text,
                    timeStamp: DateTime.now(),
                  );

                  setState(() {
                    diaryViewModel.addAnswer(answer1);
                    diaryViewModel.addAnswer(answer2);
                    diaryViewModel.addAnswer(answer3);
                  });

                  textEditingController1.clear();
                  textEditingController2.clear();
                  textEditingController3.clear();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DiaryScreen(), // Replace OtherPage() with the desired widget for the other page
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      customColor.kpurpleDarkerColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
