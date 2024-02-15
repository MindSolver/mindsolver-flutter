import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mindsolver_flutter/enums/bot_response.dart';
import 'package:mindsolver_flutter/utils/constants.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

initNotification() async {
  var androidSetting = AndroidInitializationSettings('ic_notification');

  var initializationSettings = InitializationSettings(
    android: androidSetting,
  );
  await notifications.initialize(
    initializationSettings,
  );
}

showNotification({required BotResponse botResponse,required hour, required min, required sec}) async {
  tz.initializeTimeZones();

  final location = tz.getLocation('Asia/Seoul');

  final androidNotificationDetails = AndroidNotificationDetails(
    'mindsolver_diary',
    '일기 작성시간',
    channelDescription: '일기 작성 시간을 알림',
    priority: Priority.high,
    importance: Importance.max,
    color: kPurpleColor,
  );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  final temp2 = makeDate(location: location, hour: hour, min: min, sec: sec);
  notifications.zonedSchedule(
    botResponse.diaryHour,
    '일기',
    botResponse.notification,
    temp2,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

makeDate({required location, required hour, required min, required sec}) {
  var now = tz.TZDateTime.now(location);
  var targetTime = tz.TZDateTime(location, now.year, now.month, now.day, hour, min, sec);
  if (targetTime.isBefore(now)) {
    return targetTime.add(Duration(days: 1));
  } else {
    return targetTime;
  }
}
