import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

class RemindersListState {
  final RequestStatus status;
  final List<ReminderModel>? reminders;
  final String? errorMessage;

  RemindersListState({required this.status, this.reminders, this.errorMessage});

  factory RemindersListState.init() =>
      RemindersListState(status: RequestStatus.init);

  RemindersListState copyWith({
    RequestStatus? status,
    List<ReminderModel>? reminders,
    String? errorMessage,
  }) {
    return RemindersListState(
      status: status ?? this.status,
      reminders: reminders ?? this.reminders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
