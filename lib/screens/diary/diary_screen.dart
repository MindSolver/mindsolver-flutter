import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/diary.dart';
import 'package:mindsolver_flutter/screens/diary/diary_view_model.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:mindsolver_flutter/utils/date_time_util.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'chat/chat_screen.dart'; // Import the file containing talktoAI class

import 'diary_view_model_2.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final diaryViewModel2 = DiaryViewModel2();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    diaryViewModel2.loadDiaries();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaryViewModel2>(
      create: (context) => diaryViewModel2,
      child: Scaffold(
        body: Container(
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
              buildTableCalendar(context),
              // 다이어리 위젯
              Consumer<DiaryViewModel2>(
                builder: (context, viewModel, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: diaryViewModel2.filteredDiaries.length,
                      itemBuilder: (context, index) {
                        final diary = diaryViewModel2.filteredDiaries[index];
                        return Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: kGrayColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(diary.date.toFormattedString()),
                              SizedBox(height: 8),
                              Text(diary.content),
                              Text(diary.emoji),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<DiaryViewModel2> buildTableCalendar(
      BuildContext context) {
    return Consumer(
      builder: (context, viewModel, child) {
        return TableCalendar(
          locale: 'ko_KR',
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          firstDay: DateTime(2020, 1, 0),
          lastDay: DateTime(2030, 1, 1),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: const CalendarStyle(
            selectedTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, date, events) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                child: Text('${date.day}',
                    style: TextStyle(fontSize: 16, color: kGrayColor)),
              );
            },
            defaultBuilder: (context, date, events) {
              final diary = getDiary(diaryViewModel2.diaries, date);
              if(isDiaryValid(diary)) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4),
                  child: Text(diary!.emoji, style: TextStyle(fontSize: 30)),
                );
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                child: Text('${date.day}', style: TextStyle(fontSize: 16)),
              );
            },
            todayBuilder: (context, date, events) {
              final diary = getDiary(diaryViewModel2.diaries, date);
              if(isDiaryValid(diary)) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4),
                  child: Text(diary!.emoji, style: TextStyle(fontSize: 30)),
                );
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                child: Text('${date.day}', style: TextStyle(fontSize: 16)),
              );
            },
            selectedBuilder: (context, date, events) {
              final diary = getDiary(diaryViewModel2.diaries, date);
              if(isDiaryValid(diary)) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4),
                  child: Text(diary!.emoji, style: TextStyle(fontSize: 30)),
                );
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                child: Text('${date.day}', style: TextStyle(fontSize: 16)),
              );
            },
          ),
          onDaySelected: (selectedDay, focusedDay) {
            // diaryViewModel2.addDiary(Diary(
            //   date: selectedDay,
            //   content: '일기를 작성해주세요',
            //   emoji: '😊',
            // ));
            diaryViewModel2.filterDiaries(date: selectedDay);

            final diary = getDiary(diaryViewModel2.diaries, selectedDay);
            if(!isDiaryValid(diary)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(date: selectedDay)
                ),
              );
            }
          },
          onPageChanged: (date) {
            print(date);
            setState(() {
              _selectedDay = date;
              _focusedDay = date;
            });
          },
        );
      },
    );
  }

  bool isDiaryValid(Diary? diary) {
    if(diary == null) {
      return false;
    }
    return diary.content.isNotEmpty;
  }

  Diary? getDiary(List<Diary> diaries, DateTime date) {
    for (var diary in diaries) {
      if (diary.date.isSameDate(date)) {

          return diary;

      }
    }
    return null;
  }
}
