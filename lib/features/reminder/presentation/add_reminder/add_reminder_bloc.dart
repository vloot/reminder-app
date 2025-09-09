import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/notifications/domain/notification_repository.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_state.dart';

class AddReminderBloc extends Bloc<AddReminderEvent, AddReminderState> {
  final ReminderRepository reminderRepository;
  final NotificationRepository notificationRepository;

  AddReminderBloc({
    required this.reminderRepository,
    required this.notificationRepository,
  }) : super(AddReminderInit()) {
    on<SubmitReminderEvent>(onAddReminderEvent);
  }

  FutureOr<void> onAddReminderEvent(
    SubmitReminderEvent event,
    Emitter<AddReminderState> emit,
  ) async {
    emit(AddReminderLoading());
    try {
      final reminder = ReminderModel(
        title: event.title,
        description: event.description,
        time: event.time,
        reminderDays: event.reminderDays,
      );

      final int id = await reminderRepository.addReminder(reminder);

      await notificationRepository.scheduleNotification(
        reminder.copyWith(id: id),
      );

      emit(AddReminderSuccess());
    } catch (err) {
      emit(AddReminderFailure(err.toString()));
    }
  }
}
