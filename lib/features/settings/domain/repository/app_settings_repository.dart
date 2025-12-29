import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

abstract class AppSettingsRepository {
  Future<AppSettingsEntity> load();
  Future<void> save(AppSettingsEntity settings);
}
