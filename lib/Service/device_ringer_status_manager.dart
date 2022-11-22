import 'package:code_builderz_assignment/Components/Widgets/show_snack_bar.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class DeviceRingerStatusManager {
  scheduleDeviceRinger() async {
    // i could find cron for job scheduling, but it will not work if app is killed
    // i just get this solution for now in given time
    final cron = Cron();
    await _checkDoNotDisturbPermission();

    cron.schedule(Schedule.parse('03 20 * * *'), () async {
      _setDeviceRingerMode();
    });

    cron.schedule(Schedule.parse('04 20 * * *'), () async {
      _setDeviceRingerMode(isSilent: false);
    });
  }

  _checkDoNotDisturbPermission() async {
    bool? isGranted = await PermissionHandler.permissionsGranted;
    if (!isGranted!) {
      // Opens the Do Not Disturb Access settings to grant the access
      Get.defaultDialog(
          radius: 12,
          title: 'Permission Required!',
          content: const Text(
              'To schedule ringer, DO NOT DISTURB ACCESS permission is required. Do you want to enable permission?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Get.back(); // dismiss dialogbox
                await PermissionHandler.openDoNotDisturbSetting();
              },
              child: const Text('Okay'),
            ),
            ElevatedButton(
              onPressed: () async {
                Get.back(); // dismiss dialogbox
                showSnackBar(
                  message:
                      'DO_NOT_DISTURB_ACCESS permission is required. Allow permission.',
                  mainButton: TextButton(
                    onPressed: () => _checkDoNotDisturbPermission(),
                    child: const Text('Permission'),
                  ),
                );
              },
              child: const Text('Cancel'),
            )
          ]);
    }
  }

  Future<RingerModeStatus> _checkDeviceRingModeStatus() async {
    RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
    return ringerStatus;
  }

  _setDeviceRingerMode({bool isSilent = true}) async {
    try {
      await _checkDoNotDisturbPermission();
      RingerModeStatus currentStatus = await _checkDeviceRingModeStatus();
      if (currentStatus == RingerModeStatus.normal && isSilent) {
        await SoundMode.setSoundMode(RingerModeStatus.silent);
      } else {
        await SoundMode.setSoundMode(RingerModeStatus.normal);
      }
    } on PlatformException {
      showSnackBar(
        title: 'Permission',
        message: 'Please enable permissions required',
      );
    }
  }
}
