import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;

class TalkToAI extends StatefulWidget {
  const TalkToAI({Key? key}) : super(key: key);

  @override
  _TalkToAIState createState() => _TalkToAIState();
}

class _TalkToAIState extends State<TalkToAI> {
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talk to AI'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
            child: Text('COOL'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onTap: () {
                // Show the keyboard by focusing on the text input field
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () => FocusScope.of(context).requestFocus(focusNode),
                );
              },
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Talk to AI',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: customColor.kpurpleDarkerColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: customColor.kpurpleDarkerColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
