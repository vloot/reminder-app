import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

class ReminderState {}

class ReminderInit extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderSuccess extends ReminderState {
  final ReminderModel reminder;
  ReminderSuccess(this.reminder);
}

class ReminderDeleted extends ReminderState {}

class ReminderEdited extends ReminderState {}

class ReminderFailure extends ReminderState {
  final String errorMessage;

  ReminderFailure(this.errorMessage);
}
