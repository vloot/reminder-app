import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_state.dart';

class RemindersListBloc extends Bloc<RemindersListEvent, RemindersListState> {
  final ReminderRepository reminderRepository;

  RemindersListBloc({required this.reminderRepository})
    : super(RemindersListState.init()) {
    on<GetRemindersListEvent>(onGetRemindersEvent);
    on<GetRemindersDayListEvent>(onGetRemindersDayEvent);
  }

  FutureOr<void> onGetRemindersEvent(
    GetRemindersListEvent event,
    Emitter<RemindersListState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      var res = await reminderRepository.getReminders();
      await Future.delayed(const Duration(milliseconds: 400)); // debounce time
      res.sort((a, b) => a.time.compareTo(b.time));
      emit(state.copyWith(status: RequestStatus.done, reminders: res));
    } catch (e) {
      emit(
        state.copyWith(status: RequestStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> onGetRemindersDayEvent(
    GetRemindersDayListEvent event,
    Emitter<RemindersListState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      var res = await reminderRepository.getDailyReminders(event.weekdaysSet);
      res.sort((a, b) => a.time.compareTo(b.time));
      emit(state.copyWith(status: RequestStatus.done, reminders: res));
    } catch (e) {
      emit(
        state.copyWith(status: RequestStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
