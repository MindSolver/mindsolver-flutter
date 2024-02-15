import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mindsolver_flutter/enums/bot_response.dart';
import 'package:mindsolver_flutter/firebase_options.dart';
import 'package:mindsolver_flutter/screens/onboarding/on_boarding_screen.dart';
import 'package:mindsolver_flutter/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('ko_KR', null);

  AndroidFlutterLocalNotificationsPlugin().requestNotificationsPermission();
  initNotification();
  for (BotResponse botResponse in BotResponse.values) {
    showNotification(
      botResponse: botResponse,
      hour: botResponse.diaryHour,
      min: 0,
      sec: 0,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingScreen(),
    );
  }
}
