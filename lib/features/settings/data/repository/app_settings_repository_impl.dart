import 'dart:convert';

import 'package:reminders_app/features/settings/data/models/app_settings_model.dart';
import 'package:reminders_app/features/settings/data/storage/app_settings_keys.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/domain/repository/app_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<AppSettingsEntity> load() async {
    final data = prefs.getString(AppSettingsKeys.appSettings);

    if (data == null) {
      return AppSettingsModel.defaultSettingsDark.toEntity();
    }

    return AppSettingsModel.fromJson(jsonDecode(data)).toEntity();
  }

  @override
  Future<void> save(AppSettingsEntity settings) async {
    final data = jsonEncode(AppSettingsModel.fromEntity(settings).toJson());
    prefs.setString(AppSettingsKeys.appSettings, data);
  }
}
