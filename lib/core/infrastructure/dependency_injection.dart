import 'package:get_it/get_it.dart';
import 'package:reminders_app/core/infrastructure/database.dart';
import 'package:reminders_app/features/notifications/data/notification_service.dart';
import 'package:reminders_app/features/notifications/data/repository/notification_repository_impl.dart';
import 'package:reminders_app/features/notifications/domain/notification_repository.dart';
import 'package:reminders_app/features/reminder/data/datasource/reminders_datasource.dart';
import 'package:reminders_app/features/reminder/data/repository/reminder_repository_impl.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/settings/data/repository/app_settings_repository_impl.dart';
import 'package:reminders_app/features/settings/domain/repository/app_settings_repository.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';

var getIt = GetIt.instance;

Future<void> setupDI() async {
  // Database
  getIt.registerSingleton(Database());

  // Notifications
  getIt.registerSingleton(NotificationService());
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(notificationService: getIt()),
  );

  // Settings
  getIt.registerSingletonAsync<AppSettingsRepository>(() async {
    final repo = AppSettingsRepositoryImpl();
    await repo.init();
    return repo;
  });

  getIt.registerSingletonAsync<AppSettingsBloc>(() async {
    final repo = await getIt.getAsync<AppSettingsRepository>();
    final initialSettings = await repo.load();

    return AppSettingsBloc(repo, settings: initialSettings);
  }, dependsOn: [AppSettingsRepository]);

  // Reminders list
  getIt.registerLazySingleton(() => RemindersDatasource(database: getIt()));
  getIt.registerLazySingleton<ReminderRepository>(
    () => ReminderRepositoryImpl(datasource: getIt<RemindersDatasource>()),
  );
  getIt.registerFactory(
    () => RemindersListBloc(reminderRepository: getIt<ReminderRepository>()),
  );

  // Reminder bloc
  getIt.registerFactory(
    () => ReminderBloc(
      reminderRepository: getIt<ReminderRepository>(),
      notificationRepository: getIt<NotificationRepository>(),
    ),
  );

  await getIt.allReady();
}
