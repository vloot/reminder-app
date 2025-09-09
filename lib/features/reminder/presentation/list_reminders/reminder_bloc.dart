import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';
import 'package:reminders_app/features/reminder/presentation/list_reminders/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/list_reminders/reminder_state.dart';

class RemindersBloc extends Bloc<ReminderEvent, RemindersState> {
  final ReminderRepository reminderRepository;

  RemindersBloc({required this.reminderRepository})
    : super(RemindersState.init()) {
    on<GetRemindersEvent>(onGetRemindersEvent);
  }

  FutureOr<void> onGetRemindersEvent(
    GetRemindersEvent event,
    Emitter<RemindersState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      var res = await reminderRepository.getReminders();
      emit(state.copyWith(status: RequestStatus.done, reminder: res));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }
}
