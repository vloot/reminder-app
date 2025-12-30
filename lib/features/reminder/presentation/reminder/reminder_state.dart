import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

class ReminderState {}

class ReminderInit extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderAdded extends ReminderState {
  final ReminderModel reminder;
  ReminderAdded(this.reminder);
}

class ReminderEdited extends ReminderState {
  final ReminderModel reminder;
  ReminderEdited(this.reminder);
}

class ReminderDeleted extends ReminderState {}

class ReminderFailure extends ReminderState {
  final String errorMessage;
  ReminderFailure(this.errorMessage);
}
