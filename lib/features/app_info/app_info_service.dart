import 'package:package_info_plus/package_info_plus.dart';
import 'package:reminders_app/features/app_info/app_info.dart';

class AppInfoService {
  Future<AppInfo> load() async {
    final info = await PackageInfo.fromPlatform();
    return AppInfo(version: info.version, build: info.buildNumber);
  }
}
