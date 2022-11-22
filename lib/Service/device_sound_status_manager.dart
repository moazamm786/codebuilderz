import 'package:flutter/services.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class DeviceSoundStatusManager {
  Future<RingerModeStatus> checkDeviceRingModeStatus() async {
    RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
    print(ringerStatus.name);
    return ringerStatus;
  }

  toggleDeviceRingMode() async {
    bool? isGranted = await PermissionHandler.permissionsGranted;
    if (!isGranted!) {
      // Opens the Do Not Disturb Access settings to grant the access
      await PermissionHandler.openDoNotDisturbSetting();
    }
    try {
      RingerModeStatus currentStatus = await checkDeviceRingModeStatus();
      if (currentStatus == RingerModeStatus.normal) {
        await SoundMode.setSoundMode(RingerModeStatus.silent);
      } else {
        await SoundMode.setSoundMode(RingerModeStatus.normal);
      }
    } on PlatformException {
      print('Please enable permissions required');
    }
  }
}
