import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/conversation.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/screens/diary/writeTemplate.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'chat/chat_screen.dart'; // Import the file containing talktoAI class
import 'package:mindsolver_flutter/utils/constants.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final viewModel = DiaryViewModel();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<Conversation>? model;

  double boxwidth = 350;

  @override
  void initState() {
    super.initState();
    viewModel.loadConversations(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryViewModel>(
      create: (cotext) => viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Diary',
                    style: kTitleTextStyle,
                  ),
                ),
                TableCalendar(
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  firstDay: DateTime(2020, 1, 0),
                  lastDay: DateTime(2030, 1, 1),
                  locale: 'ko_KR',
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedTextStyle: TextStyle(
                      color: Colors.white, // Change to your custom selected text color
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kPurpleColor, // Change to your custom selected color
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
                    });
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: kPurpleDarkerColor, // Change to your custom color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _selectedDay.toLocal().toString().split(' ')[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: boxwidth,
                  height: 100,
                  decoration: BoxDecoration(
                    color: kPurpleLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      (model != null && model!.isNotEmpty) ? model![0].message : _selectedDay.toLocal().toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    width: boxwidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPurpleDarkerColor, // Change to your custom color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(selectedDate: _selectedDay),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: boxwidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPurpleDarkerColor, // Change to your custom color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to another page when button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WriteTemplate(), // Replace OtherPage() with the desired widget for the other page
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Create with Template',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
