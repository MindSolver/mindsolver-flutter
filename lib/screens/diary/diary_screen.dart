import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'talktoAI.dart'; // Import the file containing talktoAI class
import 'package:mindsolver_flutter/utils/constants.dart' as customColor;

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now(); // Added focusedDay
  DiaryViewModel diaryViewModel = DiaryViewModel();
  List<Conversation>? model;

  @override
  void initState() {
    super.initState();
    initializeConversations(_selectedDay);
  }

  Future<void> initializeConversations(DateTime selectedDay) async {
    model = await diaryViewModel.loadConversations(selectedDay);
    // Trigger a rebuild after loading conversations
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '다이어리',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime.utc(
                        _focusedDay.year, _focusedDay.month - 1, 1);
                  });
                },
              ),
              Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: const TextStyle(
                  color: Colors.black, // Change to your custom text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime.utc(
                        _focusedDay.year, _focusedDay.month + 1, 1);
                  });
                },
              ),
            ],
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            firstDay: DateTime.utc(2020, 1, 0),
            lastDay: DateTime.utc(2030, 1, 1),
            calendarStyle: const CalendarStyle(
              selectedTextStyle: TextStyle(
                color:
                    Colors.white, // Change to your custom selected text color
              ),
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.purple, // Change to your custom selected color
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = selectedDay;
                initializeConversations(_selectedDay);
              });
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple, // Change to your custom color
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Selected Date: ${_selectedDay.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: 500,
            height: 100,
            decoration: BoxDecoration(
              color: customColor.kpurpleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                (model != null && model!.isNotEmpty)
                    ? model![0].message
                    : _selectedDay.toLocal().toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple, // Change to your custom color
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to another page when button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TalkToAI(), // Replace OtherPage() with the desired widget for the other page
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Create with interactive AI',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
