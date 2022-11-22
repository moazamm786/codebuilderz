// import 'dart:isolate';
//
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
//
// class AlarmManagerService {
//   Future<void> scheduleAlarm() async {
//     const int helloAlarmID = 0;
//     DateTime now = DateTime.now();
//     await AndroidAlarmManager.oneShot(
//         // DateTime(
//         //   now.year,
//         //   now.month,
//         //   now.day,
//         //   10,
//         //   2,
//         // ),
//         Duration(seconds: 10),
//         helloAlarmID,
//         printHello);
//   }
//
//   @pragma('vm:entry-point')
//   static printHello() {
//     final DateTime now = DateTime.now();
//     final int isolateId = Isolate.current.hashCode;
//     print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
//   }
// }
