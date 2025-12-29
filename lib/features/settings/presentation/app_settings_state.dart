import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

class AppSettingsState {
  final AppSettingsEntity settings;
  final bool isLoading;
  final bool isSaving;
  final String? error;

  const AppSettingsState({
    required this.settings,
    this.isLoading = false,
    this.isSaving = false,
    this.error,
  });

  AppSettingsState copyWith({
    AppSettingsEntity? settings,
    bool? isLoading,
    bool? isSaving,
    String? error,
  }) {
    return AppSettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error,
    );
  }
}
