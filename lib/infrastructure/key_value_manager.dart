import 'package:covid19/Assets/string_assets.dart';
import 'package:hive_manager/hive_manager.dart';

class KeyValueManager {
  Future instantiate(String appName) async => HiveManager.instantiate(appName);

  bool isAgrementAcceptedByUser() {
    return HiveManager.getValue<bool>(isAgrementAccepted, defaultvalue: false);
  }
}
