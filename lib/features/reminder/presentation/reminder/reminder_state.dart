class ReminderState {}

class ReminderInit extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderSuccess extends ReminderState {}

class ReminderDeleted extends ReminderState {}

class ReminderEdited extends ReminderState {}

class ReminderFailure extends ReminderState {
  final String errorMessage;

  ReminderFailure(this.errorMessage);
}
