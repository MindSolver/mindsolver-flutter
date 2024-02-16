import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;

class WriteTemplate extends StatefulWidget {
  const WriteTemplate({super.key});

  @override
  _WriteTemplate createState() => _WriteTemplate();
}

class _WriteTemplate extends State<WriteTemplate> {
  double boxwidth = 350;

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
                color: customColor.kPurpleLightColor,
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
                child: const TextField(
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
                color: customColor.kPurpleLightColor,
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
                child: const TextField(
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
                color: customColor.kPurpleLightColor,
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
                child: const TextField(
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
                  print('Submission logic goes here');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(customColor.kPurpleDarkerColor),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
