import 'dart:convert';

import 'package:eventsource/eventsource.dart';
import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/screens/auth/auth_screen.dart';
import 'package:mindsolver_flutter/utils/constants.dart';

import 'package:http/http.dart' as http;

Future<String> fetchSentences() async {
  var url = Uri.parse('http://3.36.79.79:9000/gpt35?text=give%20me%205%20sentences');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // 서버가 성공적으로 응답한 경우, 응답 데이터를 파싱합니다.
    return response.body;
  } else {
    // 서버가 오류 응답을 보낸 경우, 에러를 던집니다.
    throw Exception('Failed to load sentences');
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int page = 0;

  List data = [
    {
      'image': 'images/onboarding1.png',
      'title': 'Diary',
      'description': 'You can write yout diary with ai bot.',
    },
    {
      'image': 'images/onboarding2.png',
      'title': 'Challenge',
      'description': 'You can challenge your goal.',
    },
    {
      'image': 'images/onboarding3.png',
      'title': 'Statistic',
      'description': 'You can check your statistic.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(data[page]['image']),
                  Text(data[page]['title'], style: kTitleTextStyle),
                  SizedBox(height: 8),
                  Text(data[page]['description'], style: kBody1TextStyle),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () async {
                      ///GET REQUEST

                      // http.Client client = http.Client();

                      // http.Request request = http.Request("GET", Uri.parse('http://3.36.79.79:9000/gpt35?text=give%20me%205%20sententces'));
                      // request.headers["Accept"] = "text/event-stream";
                      // request.headers["Cache-Control"] = "no-cache";

                      // Future<http.StreamedResponse> response = client.send(request);
                      // print("Subscribed!");
                      // response.then(
                      //   (streamedResponse) => streamedResponse.stream.listen(
                      //     (value) {
                      //       final parsedData = utf8.decode(value);
                      //       print(parsedData);
                      //     },
                      //     onDone: () => print("The streamresponse is ended"),
                      //   ),
                      // );
                      if (page < data.length - 1) {
                        setState(() {
                          page++;
                        });
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthScreen()));
                      }
                    },
                    child: Text('Next', style: kBody1TextStyle),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < data.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = i;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: page == i ? kpurpleDarkerColor : kgrayLightColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
