import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

class RemindersState {
  final RequestStatus status;
  final List<ReminderModel>? reminders;
  final String? errorMessage;

  RemindersState({required this.status, this.reminders, this.errorMessage});

  factory RemindersState.init() => RemindersState(status: RequestStatus.init);

  RemindersState copyWith({
    RequestStatus? status,
    List<ReminderModel>? reminder,
    String? error,
  }) {
    return RemindersState(
      status: status ?? this.status,
      reminders: reminder ?? this.reminders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
