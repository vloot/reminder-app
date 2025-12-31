import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/settings/data/models/app_settings_model.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/domain/repository/app_settings_repository.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final AppSettingsRepository repo;

  AppSettingsBloc(this.repo, {required AppSettingsEntity settings})
    : super(AppSettingsState(settings: settings)) {
    on<UpdateAppSettings>(_onUpdate);
    on<LoadAppSettings>(_onLoad);
  }

  Future<void> _onLoad(
    LoadAppSettings event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        settings: AppSettingsModel.defaultSettings.toEntity(),
        isLoading: true,
      ),
    );
    final loadedSettings = await repo.load();
    emit(state.copyWith(settings: loadedSettings, isLoading: false));
  }

  Future<void> _onUpdate(
    UpdateAppSettings event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(state.copyWith(settings: event.updated, isSaving: true));
    await repo.save(event.updated);
    emit(state.copyWith(isSaving: false));
  }
}
