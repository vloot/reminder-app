import 'package:flutter/material.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

abstract class AppSettingsEvent {}

class LoadAppSettings extends AppSettingsEvent {
  late AppSettingsEntity loadedSettings;
}

class UpdateAppSettings extends AppSettingsEvent {
  final AppSettingsEntity updated;
  UpdateAppSettings(this.updated);
}

class LocaleChanged extends AppSettingsEvent {
  final Locale locale;
  LocaleChanged(this.locale);
}
