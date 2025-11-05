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

var getIt = GetIt.instance;

void setupDI() {
  // Database
  getIt.registerSingleton(Database());

  // Notifications
  getIt.registerSingleton(NotificationService());
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(notificationService: getIt()),
  );

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
}
