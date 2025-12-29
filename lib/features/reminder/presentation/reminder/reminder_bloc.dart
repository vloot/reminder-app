import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/notifications/domain/notification_repository.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository reminderRepository;
  final NotificationRepository notificationRepository;

  ReminderBloc({
    required this.reminderRepository,
    required this.notificationRepository,
  }) : super(ReminderInit()) {
    on<AddReminderEvent>(onAddReminderEvent);
    on<EditReminderEvent>(onEditReminderEvent);
    on<DeleteReminderEvent>(onDeleteReminderEvent);
  }

  FutureOr<void> onAddReminderEvent(
    AddReminderEvent event,
    Emitter<ReminderState> emit,
  ) async {
    emit(ReminderLoading());
    try {
      final reminder = ReminderModel(
        title: event.title,
        description: event.description,
        time: event.time,
        reminderDays: event.reminderDays,
      );

      final int id = await reminderRepository.addReminder(reminder.toEntity());
      final newReminder = reminder.copyWith(id: id);

      await notificationRepository.scheduleNotification(newReminder);

      emit(ReminderAdded(newReminder));
    } catch (err) {
      emit(ReminderFailure(err.toString()));
    }
  }

  FutureOr<void> onEditReminderEvent(
    EditReminderEvent event,
    Emitter<ReminderState> emit,
  ) async {
    final reminder = ReminderModel(
      id: event.id,
      title: event.title,
      time: event.time,
      reminderDays: event.reminderDays,
      description: event.description,
    );
    emit(ReminderLoading());
    try {
      await reminderRepository.editReminder(reminder.toEntity());
      emit(ReminderEdited());
    } catch (err) {
      emit(ReminderFailure(err.toString()));
    }
  }

  FutureOr<void> onDeleteReminderEvent(
    DeleteReminderEvent event,
    Emitter<ReminderState> emit,
  ) async {
    await notificationRepository.cancelNotification(event.reminder);
    await reminderRepository.deleteReminder(event.reminder);
    emit(ReminderDeleted());
  }
}
